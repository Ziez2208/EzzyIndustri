<div class="container py-4">
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h3>Cloudinary Upload Test</h3>
                </div>
                <div class="card-body">
                    @if (session()->has('success'))
                        <div class="alert alert-success">
                            {{ session('success') }}
                        </div>
                    @endif

                    @if (session()->has('error'))
                        <div class="alert alert-danger">
                            {{ session('error') }}
                        </div>
                    @endif

                    <form wire:submit="upload">
                        <div class="mb-3">
                            <label class="form-label">Test Upload Image</label>
                            <input type="file" 
                                class="form-control" 
                                wire:model="image" 
                                id="image-{{ $iteration }}"
                                accept="image/*">
                            @error('image') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>

                        <div wire:loading wire:target="image">
                            <div class="spinner-border spinner-border-sm text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <span class="text-muted">Uploading...</span>
                        </div>

                        @if($image)
                            <div class="mt-2">
                                <img src="{{ $image->temporaryUrl() }}" class="img-thumbnail" style="max-height: 200px">
                            </div>
                        @endif

                        <button type="submit" class="btn btn-primary" 
                            wire:loading.attr="disabled" 
                            wire:target="upload">
                            Upload Image
                        </button>
                    </form>

                    <hr>

                    <h4>Uploaded Images</h4>
                    <div class="row g-3">
                        @foreach($uploadedImages as $img)
                            <div class="col-md-4">
                                <div class="card">
                                    <img src="{{ $img['url'] }}" class="card-img-top">
                                    <div class="card-body">
                                        <button class="btn btn-danger btn-sm" 
                                            wire:click="delete('{{ $img['public_id'] }}')"
                                            wire:confirm="Are you sure you want to delete this image?">
                                            Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Upload Logs</h5>
                    <button class="btn btn-sm btn-outline-secondary" wire:click="clearLogs">
                        Clear Logs
                    </button>
                </div>
                <div class="card-body" style="max-height: 500px; overflow-y: auto;">
                    @foreach($logs as $log)
                        <div class="log-entry mb-2 p-2 border-bottom">
                            <small class="text-muted d-block">{{ $log['timestamp'] }}</small>
                            <div class="badge bg-{{ $log['type'] === 'error' ? 'danger' : 'info' }} mb-1">
                                {{ $log['type'] }}
                            </div>
                            <div class="log-message">{{ $log['message'] }}</div>
                        </div>
                    @endforeach

                    @if(empty($logs))
                        <div class="text-muted text-center">No logs available</div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>