<?php

namespace App\Livewire\Manajerial\Sop;

use Livewire\Component;
use Livewire\WithFileUploads;
use App\Models\Sop;
use App\Models\SopStep;
use Illuminate\Support\Facades\Storage;
use Livewire\Attributes\On;
use Illuminate\Support\Facades\Auth;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Support\Facades\Log;


class SopDetail extends Component
{
    use WithFileUploads;

    // Basic properties
    public $sop;
    public $judul;
    public $deskripsi;
    public $urutan;
    public $gambar;
    public $editId;
    public $isEditing = false;
    public $showModal = false;
    public $stepToDelete;

    // Quality check properties
    public $nilai_standar;
    public $toleransi_min;
    public $toleransi_max;
    public $measurement_type;  // Add this line
    public $measurement_unit;
    public $interval_value;
    public $interval_unit;

    // Measurement types
    public $measurementTypes = [
        'length' => ['mm', 'cm', 'm'],
        'diameter' => ['mm', 'cm'],
        'weight' => ['g', 'kg'],
        'temperature' => ['°C', '°F'],
        'pressure' => ['Bar', 'PSI'],
        'angle' => ['degree'],
        'time' => ['s', 'min', 'hour'],
        'other' => ['unit']
    ];

    public function updatedMeasurementType()
    {
        $this->measurement_unit = ''; // Reset unit when type changes
    }
    // Interval units untuk quality check
    public $intervalUnits = [
        'pcs' => 'Pieces',
        'set' => 'Set',
        'box' => 'Box',
        'batch' => 'Batch',
        'hour' => 'Hour',
        'shift' => 'Shift'
    ];

   

    public function mount($id)
    {
        if (!Auth::check()) {
            return redirect()->route('login');
        }
        $this->sop = Sop::with(['steps', 'machine', 'product'])->findOrFail($id);
    }

    public function render()
    {
        return view('livewire.manajerial.sop.sop-detail', [
            'steps' => $this->sop->steps()->orderBy('urutan')->get()
        ]);
    }
        // ... existing properties and mount/render methods ...

        protected function rules()
        {
            $rules = [
                'judul' => 'required',
                'deskripsi' => 'required',
                'urutan' => 'required|integer',
                'gambar' => 'nullable|image|max:2048',
            ];
    
            if ($this->sop->kategori === 'quality') {
                $rules = array_merge($rules, [
                    'nilai_standar' => 'required',
                    'toleransi_min' => 'required',
                    'toleransi_max' => 'required',
                    'measurement_unit' => 'required',
                    'interval_value' => 'required|integer|min:1',
                    'interval_unit' => 'required|in:pcs,set,box,batch,hour,shift',
                ]);
            }
    
            return $rules;
        }
    
        public function store()
        {
            Log::info('Starting store method');
            $this->validate($this->rules());
    
            try {
                $gambar_url = null;
                if ($this->gambar) {
                    Log::info('File details:', [
                        'name' => $this->gambar->getClientOriginalName(),
                        'size' => $this->gambar->getSize(),
                        'mime' => $this->gambar->getMimeType(),
                        'temp_path' => $this->gambar->getRealPath()
                    ]);
    
                    try {
                        Log::info('Cloudinary config:', [
                            'cloud_name' => config('cloudinary.cloud_name'),
                            'api_key' => config('cloudinary.api_key'),
                            'url' => config('cloudinary.url')
                        ]);
    
                        $result = Cloudinary::upload($this->gambar->getRealPath(), [
                            'folder' => 'sop-images',
                            'resource_type' => 'auto',
                            'public_id' => 'sop_' . time()
                        ]);
                        
                        $gambar_url = $result->getSecurePath();
                        Log::info('Upload success:', ['url' => $gambar_url]);
                    } catch (\Exception $e) {
                        Log::error('Cloudinary upload error:', [
                            'message' => $e->getMessage(),
                            'code' => $e->getCode(),
                            'file' => $e->getFile(),
                            'line' => $e->getLine(),
                            'trace' => $e->getTraceAsString()
                        ]);
                        throw $e;
                    }
                }
    
                $data = [
                    'judul' => $this->judul,
                    'urutan' => $this->urutan,
                    'deskripsi' => $this->deskripsi,
                    'gambar_url' => $gambar_url // ganti gambar_path jadi gambar_url
                ];
    
                // Add quality parameters if SOP type is quality
                if ($this->sop->kategori === 'quality') {
                    $data = array_merge($data, [
                        'needs_standard' => true,
                        'nilai_standar' => $this->nilai_standar,
                        'toleransi_min' => $this->toleransi_min,
                        'toleransi_max' => $this->toleransi_max,
                        'measurement_type' => $this->measurement_type,
                        'measurement_unit' => $this->measurement_unit,
                        'interval_value' => $this->interval_value,
                        'interval_unit' => $this->interval_unit
                    ]);
                }
    
                $this->sop->steps()->create($data);
    
                $this->reset(['judul', 'urutan', 'deskripsi', 'gambar', 
                             'nilai_standar', 'toleransi_min', 'toleransi_max',
                             'measurement_type', 'measurement_unit', 
                             'interval_value', 'interval_unit']);
                $this->closeModal();
                session()->flash('success', 'Step berhasil ditambahkan');
            } catch (\Exception $e) {
                Log::error('Store method failed', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                session()->flash('error', 'Gagal menyimpan data: ' . $e->getMessage());
            }
        }
        
        public function openModal()
        {
            $this->reset(['judul', 'deskripsi', 'urutan', 'gambar', 'nilai_standar', 
                         'toleransi_min', 'toleransi_max', 'measurement_unit',
                         'interval_value', 'interval_unit']);
            $this->showModal = true;
            $this->isEditing = false;
        }
    
        public function closeModal()
        {
            $this->showModal = false;
            $this->isEditing = false;
        }
        public function edit($id)
        {
            $step = SopStep::find($id);
            $this->editId = $id;
            $this->judul = $step->judul;
            $this->deskripsi = $step->deskripsi;
            $this->urutan = $step->urutan;
            
            if ($this->sop->kategori === 'quality') {
                $this->nilai_standar = $step->nilai_standar;
                $this->toleransi_min = $step->toleransi_min;
                $this->toleransi_max = $step->toleransi_max;
                $this->measurement_unit = $step->measurement_unit;
                $this->interval_value = $step->interval_value;
                $this->interval_unit = $step->interval_unit;
            }
            
            $this->isEditing = true;
            $this->showModal = true;
        }
    
        public function update()
        {
            Log::info('Starting update method');
    $this->validate($this->rules());

    try {
        $step = $this->sop->steps()->find($this->editId);
        
        $gambar_url = $step->gambar_url;
        if ($this->gambar) {
            Log::info('Update file details:', [
                'name' => $this->gambar->getClientOriginalName(),
                'size' => $this->gambar->getSize(),
                'mime' => $this->gambar->getMimeType(),
                'temp_path' => $this->gambar->getRealPath()
            ]);

            try {
                Log::info('Cloudinary config for update:', [
                    'cloud_name' => config('cloudinary.cloud_name'),
                    'api_key' => config('cloudinary.api_key'),
                    'url' => config('cloudinary.url')
                ]);

                $result = Cloudinary::upload($this->gambar->getRealPath(), [
                    'folder' => 'sop-images',
                    'resource_type' => 'auto',
                    'public_id' => 'sop_update_' . time()
                ]);
                
                $gambar_url = $result->getSecurePath();
                Log::info('Update upload success:', ['url' => $gambar_url]);
            } catch (\Exception $e) {
                Log::error('Cloudinary update error:', [
                    'message' => $e->getMessage(),
                    'code' => $e->getCode(),
                    'file' => $e->getFile(),
                    'line' => $e->getLine(),
                    'trace' => $e->getTraceAsString()
                ]);
                throw $e;
                    }
                }
    
                $data = [
                    'judul' => $this->judul,
                    'urutan' => $this->urutan,
                    'deskripsi' => $this->deskripsi,
                    'gambar_url' => $gambar_url // ganti gambar_path jadi gambar_url
                ];
    
                // Add quality parameters if SOP type is quality
                if ($this->sop->kategori === 'quality') {
                    $data = array_merge($data, [
                        'needs_standard' => true,
                        'nilai_standar' => $this->nilai_standar,
                        'toleransi_min' => $this->toleransi_min,
                        'toleransi_max' => $this->toleransi_max,
                        'measurement_type' => $this->measurement_type,
                        'measurement_unit' => $this->measurement_unit,
                        'interval_value' => $this->interval_value,
                        'interval_unit' => $this->interval_unit
                    ]);
                }
    
                $step->update($data);
    
                $this->reset(['judul', 'urutan', 'deskripsi', 'gambar', 'editId',
                             'nilai_standar', 'toleransi_min', 'toleransi_max',
                             'measurement_type', 'measurement_unit', 
                             'interval_value', 'interval_unit']);
                $this->closeModal();
                session()->flash('success', 'Step berhasil diupdate');
            } catch (\Exception $e) {
                Log::error('Update method failed', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                session()->flash('error', 'Gagal mengupdate data: ' . $e->getMessage());
            }
        }

    
        public function confirmDelete($id)
        {
            $this->stepToDelete = $id;
            $this->dispatch('show-delete-confirmation');
        }
    
        #[On('deleteConfirmed')]
        public function delete()
        {
            $step = SopStep::find($this->stepToDelete);
            
            if ($step->gambar_path) {
                Storage::disk('public')->delete($step->gambar_path);
            }
            
            $step->delete();
            $this->stepToDelete = null;
            
            $this->dispatch('deleted');
            session()->flash('success', 'Langkah SOP berhasil dihapus');
        }

    public function submitForApproval()
        {
            if ($this->sop->steps->isEmpty()) {
                session()->flash('error', 'Tidak dapat submit SOP tanpa langkah-langkah');
                return;
            }
    
            $this->sop->update([
                'approval_status' => 'pending',
                'submitted_at' => now(),
                'submitted_by' => Auth::user()
            ]);
    
            session()->flash('success', 'SOP berhasil diajukan untuk persetujuan');
        }
    public function toggleActive()
    {
        $this->sop->update([
            'is_active' => !$this->sop->is_active
        ]);
    
        $status = $this->sop->is_active ? 'diaktifkan' : 'dinonaktifkan';
        session()->flash('success', "SOP berhasil {$status}");
    }
}