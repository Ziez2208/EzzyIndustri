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
            
            $result = Cloudinary::upload($this->image->getRealPath(), [
                'folder' => 'testing',
                'resource_type' => 'image'
            ]);

            $this->uploadedImages[] = [
                'url' => $result->getSecurePath(),
                'public_id' => $result->getPublicId()
            ];

            $this->addLog('Image uploaded successfully: ' . $result->getPublicId());
            
            $this->reset('image');
            $this->iteration++;
            session()->flash('success', 'Image uploaded successfully!');
        } catch (\Exception $e) {
            $this->addLog($e->getMessage(), 'error');
            Log::error('Upload failed: ' . $e->getMessage());
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