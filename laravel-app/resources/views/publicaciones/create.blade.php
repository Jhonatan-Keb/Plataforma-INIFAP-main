@extends('layouts.app')

@section('title','Crear publicación')

@section('content')
<main class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <h3 class="fw-bold text-gob mb-3">Nueva publicación</h3>

      <form action="{{ route('publicaciones.store') }}" method="post" enctype="multipart/form-data">
        @csrf

        <div class="mb-3">
          <label class="form-label">Título</label>
          <input type="text" name="titulo" class="form-control @error('titulo') is-invalid @enderror" value="{{ old('titulo') }}">
          @error('titulo') <div class="invalid-feedback">{{ $message }}</div> @enderror
        </div>

        <div class="mb-3">
          <label class="form-label">Año</label>
          <input type="text" name="ano" class="form-control @error('ano') is-invalid @enderror" value="{{ old('ano') }}">
          @error('ano') <div class="invalid-feedback">{{ $message }}</div> @enderror
        </div>

        <div class="mb-3">
          <label class="form-label">Categoría</label>
          <select name="categoria" class="form-select @error('categoria') is-invalid @enderror">
            <option value="">Seleccione una categoría</option>
            <option value="cientifica" {{ old('categoria') == 'cientifica' ? 'selected' : '' }}>Publicación Científica</option>
            <option value="tecnica" {{ old('categoria') == 'tecnica' ? 'selected' : '' }}>Publicación Técnica</option>
            <option value="ilustracion" {{ old('categoria') == 'ilustracion' ? 'selected' : '' }}>Ilustración</option>
          </select>
          @error('categoria') <div class="invalid-feedback">{{ $message }}</div> @enderror
        </div>

        <div class="mb-3">
          <label class="form-label">Descripción / Mensaje (opcional)</label>
          <textarea name="mensaje" class="form-control @error('mensaje') is-invalid @enderror" rows="4">{{ old('mensaje') }}</textarea>
          @error('mensaje') <div class="invalid-feedback">{{ $message }}</div> @enderror
        </div>

        <div class="mb-4">
          <label class="form-label fw-bold">Portada (JPG/PNG, max 5MB)</label>
          <div class="drop-zone @error('portada') border-danger @enderror">
              <input type="file" name="portada" id="portada" accept="image/*">
              <div class="drop-zone-text">
                  <i>📁</i>
                  <span>Arrastra y suelta la portada aquí o haz clic para seleccionar</span>
                  <span class="drop-zone-file-name"></span>
              </div>
          </div>
          @error('portada') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
        </div>

        <div class="mb-4">
          <label class="form-label fw-bold">Archivo (PDF/MP3/MP4/JPG/PNG)</label>
          <div class="drop-zone @error('archivo') border-danger @enderror" style="border-color: #0d6efd;">
              <input type="file" name="archivo" id="archivo">
              <div class="drop-zone-text">
                  <i style="color: #0d6efd;">📄</i>
                  <span>Arrastra y suelta tu archivo principal aquí o haz clic para seleccionar</span>
                  <span class="drop-zone-file-name" style="color: #0d6efd;"></span>
              </div>
          </div>
          @error('archivo') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
        </div>

        <div class="mb-3">
          <label class="form-label">Enlace externo (opcional)</label>
          <input type="url" name="external_url" class="form-control @error('external_url') is-invalid @enderror" value="{{ old('external_url') }}">
          @error('external_url') <div class="invalid-feedback">{{ $message }}</div> @enderror
        </div>

        <div class="mb-3 text-end pt-3">
          <a href="{{ route('publicaciones.index') }}" class="btn btn-outline-secondary me-2">Cancelar</a>
          <button class="btn btn-gob">Publicar</button>
        </div>
      </form>
    </div>
  </div>
</main>

@include('publicaciones._dropzone')
@endsection
