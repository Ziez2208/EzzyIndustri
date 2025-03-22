<?php

namespace App\Livewire\Components;

use App\Models\MaintenanceTask;
use Livewire\Component;
use Livewire\WithFileUploads;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;  
use App\Models\Production;
use App\Models\Machine;
use App\Models\ProductionCheck;     // Add this
use App\Models\ProductionSopCheck;  // Add this
use App\Models\ChecksheetEntry;
use App\Models\Sop;
use Illuminate\Support\Facades\Redirect;
use App\Models\Shift;
use App\Models\OeeRecord;
use Sentry\State\Scope;

class ChecksheetTable extends Component
{
    use WithFileUploads;
    public $tasks;
    public $machineId;
    public $shiftId;
    public $machineSop;
    public $sopResults = [];
    public $checkResults = [];  // Add this
    public $notes = [];        // Add this
    public $photos = [];       // Add this
    
    
    public function mount($machineId, $shiftId)
    {
        $this->machineId = $machineId;
        $this->shiftId = $shiftId;
        
        // Get tasks based on frequency
        $this->tasks = $this->getTasksByFrequency();
        
        // Load SOP for this machine
        $this->machineSop = Sop::where('machine_id', $machineId)
                              ->where('is_active', true)
                              ->with(['steps' => function($query) {
                                  $query->where('is_checkpoint', true)
                                       ->orderBy('urutan');
                              }])
                              ->latest()
                              ->first();
    }

    private function getTasksByFrequency()
    {
        $tasks = MaintenanceTask::where('machine_id', $this->machineId)
            ->where('is_active', true)
            ->get();
    
        return $tasks->filter(function($task) {
            $lastCheck = ChecksheetEntry::where('task_id', $task->id)
                ->latest()
                ->first();
    
            $shouldShow = true;
            
            if ($lastCheck) {
                $lastCheckDate = $lastCheck->created_at;
                $today = now();
                
                switch ($task->frequency) {
                    case 'weekly':
                        $shouldShow = $lastCheckDate->diffInWeeks($today) >= 1;
                        Log::info("Weekly Task {$task->task_name}: Last check was on {$lastCheckDate}. Should show: " . ($shouldShow ? 'Yes' : 'No'));
                        break;
                        
                    case 'monthly':
                        $shouldShow = $lastCheckDate->diffInMonths($today) >= 1;
                        Log::info("Monthly Task {$task->task_name}: Last check was on {$lastCheckDate}. Should show: " . ($shouldShow ? 'Yes' : 'No'));
                        break;
                        
                    case 'daily':
                        $shouldShow = $lastCheckDate->diffInDays($today) >= 1;
                        Log::info("Daily Task {$task->task_name}: Last check was on {$lastCheckDate}. Should show: " . ($shouldShow ? 'Yes' : 'No'));
                        break;
                }
            } else {
                Log::info("Task {$task->task_name}: No previous check found. Showing task.");
            }
            
            return $shouldShow;
        });
    }

    public function render()
    {
        $sopCheckpoints = collect([]); 
    
        if ($this->machineSop) {
            $sopCheckpoints = $this->machineSop->steps ?? collect([]);
        }
    
        return view('livewire.components.checksheet-table', [
            'tasks' => $this->tasks,
            'maintenanceTasks' => $this->tasks, // keep this for backward compatibility
            'sopCheckpoints' => $sopCheckpoints
        ]);
    }

    public function startProduction()
    {
        try {
            \Sentry\configureScope(function (Scope $scope): void {
                $scope->setExtra('machine_id', $this->machineId);
                $scope->setExtra('shift_id', $this->shiftId);
                $scope->setExtra('check_results', $this->checkResults);
                $scope->setUser(['id' => Auth::id()]);
            });

            Log::info('Starting production process', [
                'machine_id' => $this->machineId,
                'shift_id' => $this->shiftId,
                'check_results' => $this->checkResults,
                'pending_production' => session('pending_production')
            ]);
            
            // Get pending production from session
            $pendingProduction = session('pending_production');
            if (!$pendingProduction) {
                throw new \Exception('Data produksi tidak ditemukan dalam session');
            }

            // Validate required data
            if (!isset($pendingProduction['machine_id'], 
                      $pendingProduction['product_id'], 
                      $pendingProduction['shift_id'])) {
                throw new \Exception('Data produksi tidak lengkap');
            }

            DB::beginTransaction();

            try {
                // Create production record
                $production = Production::create([
                    'user_id' => Auth::id(),
                    'machine_id' => $pendingProduction['machine_id'],
                    'machine' => $pendingProduction['machine_name'],
                    'product_id' => $pendingProduction['product_id'],
                    'product' => $pendingProduction['product_name'],
                    'shift_id' => $pendingProduction['shift_id'],
                    'status' => 'running',
                    'start_time' => now(),
                    'planned_production_time' => $pendingProduction['planned_production_time'],
                    'cycle_time' => $pendingProduction['cycle_time'],
                    'target_per_shift' => $pendingProduction['target_per_shift'],
                    'ideal_cycle_time' => $pendingProduction['cycle_time']
                ]);

                \Sentry\addBreadcrumb(new \Sentry\Breadcrumb(
                    \Sentry\Breadcrumb::LEVEL_INFO,
                    \Sentry\Breadcrumb::TYPE_DEFAULT,
                    'production',
                    'Production record created',
                    ['production_id' => $production->id]
                ));

                // Create OEE record
                $oeeRecord = OeeRecord::create([
                    'production_id' => $production->id,
                    'machine_id' => $pendingProduction['machine_id'],
                    'shift_id' => $pendingProduction['shift_id'],
                    'date' => now(),
                    'planned_production_time' => $pendingProduction['planned_production_time'],
                    'operating_time' => 0,
                    'total_downtime' => 0,
                    'total_output' => 0,
                    'good_output' => 0,
                    'ideal_cycle_time' => $pendingProduction['cycle_time'],
                    'availability_rate' => 0,
                    'performance_rate' => 0,
                    'quality_rate' => 0,
                    'oee_score' => 0
                ]);

                \Sentry\addBreadcrumb(new \Sentry\Breadcrumb(
                    \Sentry\Breadcrumb::LEVEL_INFO,
                    \Sentry\Breadcrumb::TYPE_DEFAULT,
                    'oee',
                    'OEE record created',
                    ['oee_id' => $oeeRecord->id]
                ));

                // Save checksheet entries
                foreach ($this->checkResults as $taskId => $result) {
                    $task = MaintenanceTask::findOrFail($taskId);
                    
                    $checksheetData = [
                        'production_id' => $production->id,
                        'task_id' => $taskId,
                        'machine_id' => $this->machineId,
                        'shift_id' => $this->shiftId,
                        'user_id' => Auth::id(),
                        'result' => $result,
                        'notes' => $this->notes[$taskId] ?? null,
                    ];

                    if (isset($this->photos[$taskId])) {
                        $checksheetData['photo_path'] = $this->photos[$taskId]->store('photos', 'public');
                    }

                    $checksheetEntry = ChecksheetEntry::create($checksheetData);
                    
                    \Sentry\addBreadcrumb(new \Sentry\Breadcrumb(
                        \Sentry\Breadcrumb::LEVEL_INFO,
                        \Sentry\Breadcrumb::TYPE_DEFAULT,
                        'checksheet',
                        "Checksheet entry created for task $taskId",
                        ['entry_id' => $checksheetEntry->id]
                    ));
                }

                DB::commit();
                session()->forget('pending_production');

                return redirect()->route('production.status');

            } catch (\Exception $e) {
                DB::rollBack();
                throw $e;
            }

        } catch (\Exception $e) {
            \Sentry\captureException($e);
            
            Log::error('Error starting production', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'session' => session()->all(),
                'user_id' => Auth::id(),
                'machine_id' => $this->machineId,
                'shift_id' => $this->shiftId
            ]);

            session()->flash('error', 'Terjadi kesalahan saat memulai produksi: ' . $e->getMessage());
            return null;
        }
    }

    public function getProgressPercentage()
    {
        if (!$this->tasks || $this->tasks->count() === 0) {
            return 0;
        }
        return min(100, round((count($this->checkResults) / $this->tasks->count()) * 100));
    }

    public function getProgressText()
    {
        return count($this->checkResults) . '/' . ($this->tasks?->count() ?? 0);
    }
    public function getProgressProperty()
    {
        if (!$this->tasks || $this->tasks->count() === 0) {
            return 0;
        }
        
        return round((count($this->checkResults) / $this->tasks->count()) * 100);
    }

    public function back()
    {
        return redirect()->route('production.start');
    }
}