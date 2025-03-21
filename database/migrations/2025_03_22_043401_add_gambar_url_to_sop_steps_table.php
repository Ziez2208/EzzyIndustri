<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('sop_steps', function (Blueprint $table) {
            if (!Schema::hasColumn('sop_steps', 'gambar_url')) {
                $table->string('gambar_url')->nullable();
            }
            // Drop old column if exists
            if (Schema::hasColumn('sop_steps', 'gambar_path')) {
                $table->dropColumn('gambar_path');
            }
        });
    }

    public function down()
    {
        Schema::table('sop_steps', function (Blueprint $table) {
            if (Schema::hasColumn('sop_steps', 'gambar_url')) {
                $table->dropColumn('gambar_url');
            }
        });
    }
};