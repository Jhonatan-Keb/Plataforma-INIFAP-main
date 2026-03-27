<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('media_archivos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('publicacion_id')
                  ->nullable()
                  ->constrained('publicaciones')
                  ->cascadeOnDelete();

            $table->string('nombre_original', 255);  // nombre con que el usuario subió el archivo
            $table->string('ruta', 500);             // ruta en storage (disco local o public)

            // Tipo MIME completo: image/jpeg, image/gif, video/mp4, audio/mpeg, application/pdf, etc.
            $table->string('tipo_mime', 100);

            // Categoría general del medio
            $table->enum('tipo_medio', ['imagen', 'gif', 'video', 'audio', 'documento']);

            $table->string('extension', 15)->nullable();
            $table->unsignedBigInteger('tamanio')->nullable(); // bytes
            $table->boolean('es_portada')->default(false);     // true = esta imagen es la portada
            $table->text('descripcion')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('media_archivos');
    }
};
