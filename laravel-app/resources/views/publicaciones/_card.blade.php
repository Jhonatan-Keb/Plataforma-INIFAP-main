@php
    $tipo      = $publicacion->tipo ?? '';
    $rawFile   = trim((string) ($publicacion->file_path ?? ''));
    $rawPortada = trim((string) ($publicacion->portada_path ?? ''));

    // Build file URL
    $fileUrl = null;
    if (!empty($rawFile)) {
        if (str_starts_with($rawFile, 'http')) {
            $fileUrl = $rawFile;
        } elseif (str_starts_with($rawFile, 'uploads/')) {
            $fileUrl = asset('storage/' . $rawFile);
        }
    }

    // Build portada URL
    $portadaUrl = null;
    if (!empty($rawPortada)) {
        if (str_starts_with($rawPortada, 'http')) {
            $portadaUrl = $rawPortada;
        } elseif (str_starts_with($rawPortada, 'uploads/')) {
            $portadaUrl = asset('storage/' . $rawPortada);
        }
    }

    // Link to open
    $link = $publicacion->external_url ?? $fileUrl;
@endphp

<div class="col-md-4 mb-4">
    <div class="card h-100">
        @if($tipo === 'video' && $fileUrl)
            <video controls class="card-img-top" style="max-height:220px;object-fit:cover;">
                <source src="{{ $fileUrl }}" type="video/mp4">
                Tu navegador no soporta video.
            </video>
        @elseif($tipo === 'audio' && $fileUrl)
            @if($portadaUrl)
                <img src="{{ $portadaUrl }}" class="card-img-top" alt="{{ $publicacion->titulo }}" style="max-height:220px;object-fit:cover;">
            @endif
            <div class="p-2">
                <audio controls class="w-100">
                    <source src="{{ $fileUrl }}" type="audio/mpeg">
                    Tu navegador no soporta audio.
                </audio>
            </div>
        @elseif(in_array($tipo, ['imagen', 'gif']) && $fileUrl)
            <img src="{{ $fileUrl }}" class="card-img-top" alt="{{ $publicacion->titulo }}" style="max-height:220px;object-fit:cover;">
        @elseif($portadaUrl)
            <img src="{{ $portadaUrl }}" class="card-img-top" alt="{{ $publicacion->titulo }}" style="max-height:220px;object-fit:cover;">
        @endif

        <div class="card-body d-flex flex-column">
            <h5 class="card-title">{{ $publicacion->titulo }}</h5>
            <p class="card-text text-muted small">Año: {{ $publicacion->ano ?? '—' }}</p>
            @if(!empty($publicacion->mensaje))
                <p class="card-text small">{{ $publicacion->mensaje }}</p>
            @endif

            @if($link)
                <a href="{{ $link }}" class="btn btn-primary btn-sm mt-auto" target="_blank">
                    @if($tipo === 'video') Ver video
                    @elseif($tipo === 'audio') Escuchar
                    @elseif(in_array($tipo, ['imagen', 'gif'])) Ver imagen
                    @else Abrir
                    @endif
                </a>
            @else
                <button class="btn btn-outline-secondary btn-sm mt-auto" disabled>Archivo no disponible</button>
            @endif
        </div>
    </div>
</div>
