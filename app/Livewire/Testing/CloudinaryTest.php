<?php

namespace App\Livewire\Testing;

use Livewire\Component;
use Livewire\WithFileUploads;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Support\Facades\Log;

class CloudinaryTest extends Component
{
    use WithFileUploads;

    public $image;
    public $uploadedImages = [];
    public $iteration = 0;

    public $logs = [];

    public function addLog($message, $type = 'info')
    {
        array_unshift($this->logs, [
            'message' => $message,
            'type' => $type,
            'timestamp' => now()->format('Y-m-d H:i:s')
        ]);
    }

    public function clearLogs()
    {
        $this->logs = [];
    }

    public function upload()
    {
        $this->validate([
            'image' => 'required|image|max:2048'
        ]);

        try {
            $this->addLog('Starting upload process...');
            
            // Tambah error handling dan logging lebih detail
            if (!$this->image) {
                throw new \Exception('No image file provided');
            }

            // Pastikan file bisa diakses
            $path = $this->image->getRealPath();
            if (!file_exists($path)) {
                throw new \Exception('Cannot access temporary file');
            }

            // Tambah konfigurasi lebih detail
            $result = Cloudinary::upload($path, [
                'folder' => 'testing',
                'resource_type' => 'image',
                'public_id' => 'test_' . time(),
                'overwrite' => true,
                'notification_url' => null,
                'transformation' => [
                    'quality' => 'auto',
                    'fetch_format' => 'auto'
                ]
            ]);

            // Validasi response
            if (!$result || !$result->getSecurePath()) {
                throw new \Exception('Invalid response from Cloudinary');
            }

            $this->uploadedImages[] = [
                'url' => $result->getSecurePath(),
                'public_id' => $result->getPublicId(),
                'created_at' => now()->toDateTimeString()
            ];

            $this->addLog('Image uploaded successfully: ' . $result->getPublicId());
            $this->addLog('URL: ' . $result->getSecurePath());
            
            $this->reset('image');
            $this->iteration++;
            session()->flash('success', 'Image uploaded successfully!');
        } catch (\Exception $e) {
            $this->addLog('Error details: ' . $e->getMessage(), 'error');
            $this->addLog('File info: ' . ($this->image ? 'File present' : 'No file'), 'error');
            Log::error('Upload failed', [
                'error' => $e->getMessage(),
                'file' => $this->image ? 'present' : 'null',
                'trace' => $e->getTraceAsString()
            ]);
            session()->flash('error', 'Upload failed: ' . $e->getMessage());
        }
    }

    public function delete($publicId)
    {
        try {
            $this->addLog('Attempting to delete image: ' . $publicId);
            
            Cloudinary::destroy($publicId);
            $this->uploadedImages = array_filter($this->uploadedImages, function($img) use ($publicId) {
                return $img['public_id'] !== $publicId;
            });

            $this->addLog('Image deleted successfully: ' . $publicId);
            session()->flash('success', 'Image deleted successfully!');
        } catch (\Exception $e) {
            $this->addLog($e->getMessage(), 'error');
            Log::error('Delete failed: ' . $e->getMessage());
            session()->flash('error', 'Delete failed: ' . $e->getMessage());
        }
    }

    public function render()
    {
        return view('livewire.testing.cloudinary-test');
    }
}