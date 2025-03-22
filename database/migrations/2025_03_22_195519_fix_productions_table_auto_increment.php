<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('productions', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('machine_id');
            $table->string('machine');
            $table->unsignedBigInteger('product_id');
            $table->string('product');
            $table->integer('target_per_shift');
            $table->decimal('cycle_time', 8, 2)->default(0.00);
            $table->integer('downtime_problems')->default(0);
            $table->integer('downtime_maintenance')->default(0);
            $table->integer('total_production')->default(0);
            $table->string('defect_type')->nullable();
            $table->text('notes')->nullable();
            $table->integer('defect_count')->default(0)->nullable();
            $table->unsignedBigInteger('shift_id');
            $table->integer('planned_production_time')->default(0);
            $table->enum('status', ['waiting_approval', 'running', 'problem', 'finished', 'paused'])->default('waiting_approval');
            $table->timestamp('start_time')->nullable();
            $table->timestamp('end_time')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('productions');
    }
};