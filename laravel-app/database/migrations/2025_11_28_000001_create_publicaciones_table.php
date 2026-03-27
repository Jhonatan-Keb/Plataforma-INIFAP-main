<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('publicaciones', function (Blueprint $table) {
            $table->id();
            $table->string('titulo', 500);
            $table->string('titulo_en', 500)->nullable();
            $table->smallInteger('ano')->nullable();
            $table->enum('categoria', ['cientifica', 'tecnica', 'ilustracion']);
            // tipo: clase de archivo principal (pdf, video, imagen, folleto, audio, gif, documento)
            $table->string('tipo', 50)->default('pdf');
            $table->string('portada_path', 255)->nullable(); // imagen de portada
            $table->string('file_path', 255)->nullable();    // archivo descargable
            $table->string('external_url', 500)->nullable(); // enlace externo
            $table->string('mensaje', 500)->nullable();      // mensaje de contacto para pubs sin liga
            $table->smallInteger('cuenta')->default(0);      // contador de visitas legacy
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->boolean('is_published')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('publicaciones');
    }
};
