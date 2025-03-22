<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('productions', function (Blueprint $table) {
            // Drop existing id column if exists
            $table->dropColumn('id');
        });

        Schema::table('productions', function (Blueprint $table) {
            // Recreate id column properly
            $table->bigIncrements('id')->first();
        });
    }

    public function down()
    {
        Schema::table('productions', function (Blueprint $table) {
            $table->dropColumn('id');
            $table->bigInteger('id')->unsigned()->first();
        });
    }
};