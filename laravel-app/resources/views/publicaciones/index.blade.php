@extends('layouts.app')

@section('title', '| INIFAP C.E. Zacatecas')

@section('content')
<main class="container-fluid mt-4 mb-5">
  <div class="row gx-4">
    {{-- ── FILTROS ── --}}
    <aside class="col-md-3 mb-4">
      <div class="card shadow-sm border-0">
        <div class="card-body">
          <h5 class="text-gob fw-bold mb-3">Filtrar publicaciones</h5>
          <form method="GET" action="{{ route('publicaciones.index') }}" id="filtros-form">

            <input name="buscar" type="text" class="form-control mb-3"
                   placeholder="Buscar por palabra..."
                   value="{{ request('buscar') }}">

            {{-- Categoría --}}
            <label class="form-label small fw-semibold mb-1">Categoría</label>
            <select name="categoria" class="form-select mb-3"
                    onchange="document.getElementById('filtros-form').submit();">
              <option value="todas"       {{ request('categoria','todas') == 'todas'       ? 'selected' : '' }}>Todas las publicaciones</option>
              <option value="cientifica"  {{ request('categoria') == 'cientifica'          ? 'selected' : '' }}>Publicaciones científicas</option>
              <option value="tecnica"     {{ request('categoria') == 'tecnica'             ? 'selected' : '' }}>Publicaciones técnicas</option>
              <option value="ilustracion" {{ request('categoria') == 'ilustracion'         ? 'selected' : '' }}>Ilustraciones</option>
            </select>

            {{-- Tipo de archivo --}}
            <label class="form-label small fw-semibold mb-1">Tipo de archivo</label>
            <select name="tipo" class="form-select mb-3"
                    onchange="document.getElementById('filtros-form').submit();">
              <option value="">Todos los tipos</option>
              <option value="pdf"       {{ request('tipo') == 'pdf'       ? 'selected' : '' }}>PDF / Documento</option>
              <option value="imagen"    {{ request('tipo') == 'imagen'    ? 'selected' : '' }}>Imagen</option>
              <option value="gif"       {{ request('tipo') == 'gif'       ? 'selected' : '' }}>GIF</option>
              <option value="video"     {{ request('tipo') == 'video'     ? 'selected' : '' }}>Video</option>
              <option value="audio"     {{ request('tipo') == 'audio'     ? 'selected' : '' }}>Audio</option>
              <option value="folleto"   {{ request('tipo') == 'folleto'   ? 'selected' : '' }}>Folleto</option>
              <option value="documento" {{ request('tipo') == 'documento' ? 'selected' : '' }}>Otro documento</option>
            </select>

            {{-- Año --}}
            <label class="form-label small fw-semibold mb-1">Año</label>
            <select name="anio" class="form-select mb-3"
                    onchange="document.getElementById('filtros-form').submit();">
              <option value="">Todos los años</option>
              @foreach(range(date('Y'), 1985) as $year)
                <option value="{{ $year }}" {{ request('anio') == $year ? 'selected' : '' }}>{{ $year }}</option>
              @endforeach
            </select>

            {{-- Orden --}}
            <label class="form-label small fw-semibold mb-1">Ordenar por</label>
            <select name="orden" class="form-select mb-3"
                    onchange="document.getElementById('filtros-form').submit();">
              <option value="reciente" {{ request('orden','reciente') == 'reciente' ? 'selected' : '' }}>Más recientes primero</option>
              <option value="antiguo"  {{ request('orden') == 'antiguo'             ? 'selected' : '' }}>Más antiguos primero</option>
            </select>

            <button type="button" class="btn btn-gob w-100"
                    onclick="window.location='{{ route('publicaciones.index') }}'">
              Limpiar filtros
            </button>
          </form>
        </div>
      </div>
    </aside>

    {{-- ── RESULTADOS ── --}}
    <section class="col-md-9">
      <div class="mb-3">
        <span class="fw-bold">Resultados: {{ $publicaciones->total() }}</span>
      </div>

      <div id="contenedor" class="row g-4">
        @forelse($publicaciones as $publicacion)
          <div class="col-md-4">
            <div class="card card-publicacion h-100">
              @php
                $tipo      = $publicacion->tipo ?? '';
                $categoria = $publicacion->categoria ?? '';

                // ── Icono/portada ──
                $iconos = [
                  'video'     => 'imagenes/youtube.png',
                  'audio'     => 'imagenes/icoaudio.png',
                  'gif'       => null,   // se usa la propia imagen
                  'imagen'    => null,
                  'pdf'       => 'imagenes/icopdf.png',
                  'folleto'   => 'imagenes/icopdf.png',
                  'documento' => 'imagenes/icopdf.png',
                ];
                $fallback   = 'imagenes/icopdf.png';
                $portadaUrl = null;

                $rawPortada = trim((string) ($publicacion->portada_path ?? ''));
                $rawFile    = trim((string) ($publicacion->file_path    ?? ''));

                // Determinar URL de portada
                if (!empty($rawPortada)) {
                  if (str_starts_with($rawPortada, 'http')) {
                    $portadaUrl = $rawPortada;
                  } elseif (str_starts_with($rawPortada, 'uploads/')) {
                    // Archivo subido vía formulario → disco public
                    $portadaUrl = asset('storage/' . $rawPortada);
                  } else {
                    $p = ltrim($rawPortada, '/');
                    $p = str_starts_with($p, 'imagenes/') ? $p : 'imagenes/' . $p;
                    $portadaUrl = file_exists(public_path($p)) ? url('/' . implode('/', array_map('rawurlencode', explode('/', $p)))) : null;
                  }
                }

                // Si es imagen/gif y el file_path es la imagen, usarlo como portada
                if (empty($portadaUrl) && in_array($tipo, ['imagen','gif']) && !empty($rawFile)) {
                  if (str_starts_with($rawFile, 'uploads/')) {
                    $portadaUrl = asset('storage/' . $rawFile);
                  }
                }

                // Icono por defecto según tipo
                if (empty($portadaUrl)) {
                  $ico = $iconos[$tipo] ?? $fallback;
                  $portadaUrl = url('/' . implode('/', array_map('rawurlencode', explode('/', $ico))));
                }

                // ── URL de acción (abrir/reproducir) ──
                $link = null;
                if (!empty($publicacion->external_url)) {
                  $link = $publicacion->external_url;
                } elseif (!empty($rawFile)) {
                  if (str_starts_with($rawFile, 'http')) {
                    $link = $rawFile;
                  } elseif (str_starts_with($rawFile, 'uploads/')) {
                    $link = asset('storage/' . $rawFile);
                  } else {
                    $candidate = ltrim($rawFile, '/');
                    $link = file_exists(public_path($candidate)) ? url('/' . $candidate) : null;
                  }
                }
                // Ilustraciones/imágenes sin archivo → usar portada como enlace
                if (empty($link) && in_array($tipo, ['imagen','gif']) && !empty($portadaUrl)) {
                  $link = $portadaUrl;
                }

                // Etiqueta del botón
                $btnLabel = match($tipo) {
                  'video'     => 'Ver video',
                  'audio'     => 'Escuchar',
                  'imagen', 'gif' => 'Ver imagen',
                  default     => 'Abrir',
                };

                // Badge de tipo
                $badgeClass = match($tipo) {
                  'video'     => 'bg-danger',
                  'audio'     => 'bg-success',
                  'gif'       => 'bg-warning text-dark',
                  'imagen'    => 'bg-info text-dark',
                  'pdf'       => 'bg-primary',
                  'folleto'   => 'bg-secondary',
                  default     => 'bg-dark',
                };
              @endphp

              <div class="position-relative">
                <img src="{{ $portadaUrl }}" class="card-img-top portada-img"
                     alt="{{ $publicacion->titulo }}"
                     onerror="this.src='{{ url('/imagenes/icopdf.png') }}'">
                <span class="badge {{ $badgeClass }} position-absolute top-0 end-0 m-2"
                      style="font-size:0.7rem;">
                  {{ strtoupper($tipo) }}
                </span>
              </div>

              <div class="card-body d-flex flex-column">
                <h6 class="card-title text-gob fw-bold">{{ $publicacion->titulo }}</h6>
                <p class="text-muted small mb-1">
                  Año: {{ $publicacion->ano ?? '—' }}
                  &nbsp;·&nbsp;
                  {{ ucfirst($publicacion->categoria ?? '—') }}
                </p>

                @if(!empty($publicacion->mensaje))
                  <p class="small text-muted fst-italic mb-2">{{ $publicacion->mensaje }}</p>
                @endif

                @if(!empty($link))
                  @if(in_array($tipo, ['imagen','gif']))
                    <a href="{{ $link }}" class="mt-auto btn btn-outline-gob btn-sm js-image-preview"
                       data-image="{{ $link }}">{{ $btnLabel }}</a>
                  @elseif($tipo === 'video')
                    <a href="{{ $link }}" target="_blank" rel="noopener"
                       class="mt-auto btn btn-outline-gob btn-sm js-video-preview"
                       data-src="{{ $link }}">{{ $btnLabel }}</a>
                  @elseif($tipo === 'audio')
                    <button class="mt-auto btn btn-outline-gob btn-sm js-audio-preview"
                            data-src="{{ $link }}">{{ $btnLabel }}</button>
                  @else
                    <a href="{{ $link }}" target="_blank" rel="noopener"
                       class="mt-auto btn btn-outline-gob btn-sm">{{ $btnLabel }}</a>
                  @endif
                @else
                  <button class="mt-auto btn btn-outline-secondary btn-sm" disabled>
                    Archivo no disponible
                  </button>
                @endif
              </div>
            </div>
          </div>
        @empty
          <p class="text-muted">No hay publicaciones disponibles.</p>
        @endforelse
      </div>

      <div class="mt-4 publicaciones-paginacion">
        {{ $publicaciones->onEachSide(1)->links('pagination::simple-bootstrap-5') }}
      </div>
    </section>
  </div>
</main>

{{-- Botón colaborador --}}
<a href="{{ route('colaborador') }}" class="btn btn-gob"
   style="position:fixed;bottom:20px;left:20px;z-index:1000;box-shadow:0 4px 6px rgba(0,0,0,.2);">
  Hacerme colaborador
</a>

{{-- Modal imagen --}}
<div class="modal fade" id="imagenModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header border-0 pb-0">
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-2">
        <img id="imagenModalImg" src="" alt="Imagen" class="img-fluid w-100">
      </div>
    </div>
  </div>
</div>

{{-- Modal video --}}
<div class="modal fade" id="videoModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content bg-black">
      <div class="modal-header border-0 pb-0">
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-2">
        <video id="videoModalPlayer" controls class="w-100" style="max-height:70vh;">
          <source src="" type="video/mp4">
          Tu navegador no soporta reproducción de video.
        </video>
      </div>
    </div>
  </div>
</div>

{{-- Modal audio --}}
<div class="modal fade" id="audioModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header border-0 pb-0">
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-3">
        <audio id="audioModalPlayer" controls class="w-100">
          <source src="" type="audio/mpeg">
          Tu navegador no soporta reproducción de audio.
        </audio>
      </div>
    </div>
  </div>
</div>

@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', () => {
  // ── Imagen ──
  const imgModal  = new bootstrap.Modal(document.getElementById('imagenModal'));
  const imgEl     = document.getElementById('imagenModalImg');
  document.querySelectorAll('.js-image-preview').forEach(btn => {
    btn.addEventListener('click', e => {
      e.preventDefault();
      imgEl.src = btn.dataset.image;
      imgModal.show();
    });
  });

  // ── Video ──
  const vidModalEl = document.getElementById('videoModal');
  const vidPlayer  = document.getElementById('videoModalPlayer');
  const vidModal   = new bootstrap.Modal(vidModalEl);
  document.querySelectorAll('.js-video-preview').forEach(btn => {
    btn.addEventListener('click', e => {
      e.preventDefault();
      const src = btn.dataset.src;
      vidPlayer.querySelector('source').src = src;
      vidPlayer.load();
      vidModal.show();
    });
  });
  vidModalEl.addEventListener('hidden.bs.modal', () => {
    vidPlayer.pause();
    vidPlayer.querySelector('source').src = '';
    vidPlayer.load();
  });

  // ── Audio ──
  const audModalEl = document.getElementById('audioModal');
  const audPlayer  = document.getElementById('audioModalPlayer');
  const audModal   = new bootstrap.Modal(audModalEl);
  document.querySelectorAll('.js-audio-preview').forEach(btn => {
    btn.addEventListener('click', () => {
      const src = btn.dataset.src;
      audPlayer.querySelector('source').src = src;
      audPlayer.load();
      audModal.show();
    });
  });
  audModalEl.addEventListener('hidden.bs.modal', () => {
    audPlayer.pause();
    audPlayer.querySelector('source').src = '';
    audPlayer.load();
  });
});
</script>
@endpush
