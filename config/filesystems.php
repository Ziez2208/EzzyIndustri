<?php

use Illuminate\Support\Facades\Storage;

return [
    'default' => env('FILESYSTEM_DISK', 'local'),

    'disks' => [
        'local' => [
            'driver' => 'local',
            'root' => storage_path('app'),
            'throw' => false,
        ],

        'public' => [
            'driver' => 'local',
            'root' => storage_path('app/public'),
            'url' => env('APP_URL').'/storage',
            'visibility' => 'public',
            'throw' => false,
        ],

        'excel' => [
            'driver' => 'local',
            'root' => storage_path('app/excel'),
            'throw' => false,
        ],
    
        'cloudinary' => [
            'driver' => 'cloudinary',
            'api_key' => env('CLOUDINARY_API_KEY', '752562542316518'),
            'api_secret' => env('CLOUDINARY_API_SECRET', 'fLMSNG_K3Xq3fz7pzmW7AXs72R0'),
            'cloud_name' => env('CLOUDINARY_CLOUD_NAME', 'dncabigef'),
        ],
    ],

    'links' => [
        public_path('storage') => storage_path('app/public'),
    ],
];