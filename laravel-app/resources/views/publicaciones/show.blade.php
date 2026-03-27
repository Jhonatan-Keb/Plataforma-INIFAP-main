@extends('layouts.app')

@section('title', $publicacion->titulo)

@section('content')
<main class="container mt-4">
  <div class="row">
    <div class="col-md-8">
      <h3 class="fw-bold text-gob">{{ $publicacion->titulo }}</h3>
      <p class="text-muted">Año: {{ $publicacion->ano ?? '—' }} &middot; Tipo: {{ $publicacion->tipo }}</p>

      @if($publicacion->portada_path)
        <img src="{{ asset('storage/' . $publicacion->portada_path) }}" class="img-fluid mb-3" alt="Portada">
      @endif

      @php
        $tipo = $publicacion->tipo ?? '';
        $fileUrl = null;
        $rawFile = trim((string) ($publicacion->file_path ?? ''));
        if (!empty($rawFile)) {
            if (str_starts_with($rawFile, 'http')) {
                $fileUrl = $rawFile;
            } elseif (str_starts_with($rawFile, 'uploads/')) {
                $fileUrl = asset('storage/' . $rawFile);
            }
        }
      @endphp

      @if($tipo === 'video' && $fileUrl)
        <div class="mb-3">
          <video controls class="w-100" style="max-height:500px;">
            <source src="{{ $fileUrl }}" type="video/mp4">
            Tu navegador no soporta reproducción de video.
          </video>
        </div>
      @elseif($tipo === 'audio' && $fileUrl)
        <div class="mb-3">
          <audio controls class="w-100">
            <source src="{{ $fileUrl }}" type="audio/mpeg">
            Tu navegador no soporta reproducción de audio.
          </audio>
        </div>
      @endif

      @if($publicacion->file_path)
        <div class="mb-3">
          <a href="{{ $fileUrl }}" class="btn btn-gob" target="_blank">Abrir archivo</a>
          <a href="{{ $fileUrl }}" class="btn btn-outline-gob" download>Descargar</a>
        </div>
      @endif

      @if($publicacion->external_url)
        <p>Enlace externo: <a href="{{ $publicacion->external_url }}" target="_blank">Abrir recurso</a></p>
      @endif

      @if($publicacion->mensaje)
        <div class="mt-4">
          <p>{{ $publicacion->mensaje }}</p>
        </div>
      @endif
    </div>
    <div class="col-md-4">
      <div class="card">
        <div class="card-body">
          <p class="mb-1"><strong>Subido por</strong></p>
          <p class="small mb-2">{{ optional($publicacion->user)->name ?? 'Anónimo' }}</p>
          <p class="mb-1"><strong>Publicado</strong></p>
          <p class="small">{{ $publicacion->created_at->format('d M Y') }}</p>
        </div>
      </div>
    </div>
  </div>
</main>
@endsection
