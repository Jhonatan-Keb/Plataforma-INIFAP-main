@extends('layouts.app')

@section('title', 'Subir Publicación | INIFAP')

@section('content')
<div class="container d-flex flex-column justify-content-center align-items-center text-center" style="min-height:60vh;">
    <div class="w-100" style="max-width: 500px;">
        <h1 class="mb-4">Subir nueva publicación</h1>
        <form method="POST" action="#" enctype="multipart/form-data" class="text-start">
            <div class="mb-3">
                <label for="titulo" class="form-label fw-bold">Título</label>
                <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Escribe el título">
            </div>
            <div class="mb-3">
                <label for="descripcion" class="form-label fw-bold">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" placeholder="Escribe una descripción"></textarea>
            </div>
            <div class="mb-4">
                <label class="form-label fw-bold">Archivo</label>
                <div class="drop-zone @error('file') border-danger @enderror" style="border-color: #0d6efd;">
                    <input type="file" id="file" name="file">
                    <div class="drop-zone-text">
                        <i style="color: #0d6efd;">📄</i>
                        <span>Arrastra y suelta tu archivo aquí o haz clic para seleccionar</span>
                        <span class="drop-zone-file-name" style="color: #0d6efd;"></span>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-gob w-100">Subir publicación</button>
        </form>
    </div>
</div>
@include('publicaciones._dropzone')
@endsection
