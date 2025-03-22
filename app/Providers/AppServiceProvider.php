<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot()
    {
        Paginator::useBootstrap();
        
        if(config('app.env') === 'production') {
            URL::forceScheme('https');
        }

        Schema::defaultStringLength(191);

        // Add error handling for pagination views
        View::share('paginationError', function ($e) {
            Log::error('Pagination error:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
        });
    }
}