@extends('layouts.app')

@section('title', 'Publicaciones | INIFAP C.E. Zacatecas')

@section('content')
<main class="container-fluid mt-4 mb-5">
  <div class="row gx-4">
    <aside class="col-md-3 mb-4">
      <div class="card shadow-sm border-0">
        <div class="card-body">
          <h5 class="text-gob fw-bold mb-3">Filtrar publicaciones</h5>
          <form method="GET" action="{{ route('publicaciones.index') }}" id="filtros-form">
            <input name="buscar" type="text" class="form-control mb-3" placeholder="Buscar por palabra..." value="{{ request('buscar') }}">
            <select name="ambito" class="form-select mb-3" onchange="document.getElementById('filtros-form').submit();">
              <option value="todos" {{ request('ambito') == 'todos' ? 'selected' : '' }}>Todos las publicaciones</option>
              <option value="tecnicas" {{ request('ambito') == 'tecnicas' ? 'selected' : '' }}>Publicaciones técnicas</option>
              <option value="cientificas" {{ request('ambito') == 'cientificas' ? 'selected' : '' }}>Publicaciones científicas</option>
            </select>
            <select name="anio" class="form-select mb-3" onchange="document.getElementById('filtros-form').submit();">
              <option value="">Todos los años</option>
              @foreach(range(date('Y'), 2000) as $year)
                <option value="{{ $year }}" {{ request('anio') == $year ? 'selected' : '' }}>{{ $year }}</option>
              @endforeach
            </select>
            <select name="tipo" class="form-select mb-3" onchange="document.getElementById('filtros-form').submit();">
              <option value="">Todos los tipos</option>
              <option value="pdf" {{ request('tipo') == 'pdf' ? 'selected' : '' }}>PDF</option>
              <option value="video" {{ request('tipo') == 'video' ? 'selected' : '' }}>Video</option>
            </select>
            <button type="button" class="btn btn-gob w-100" onclick="window.location='{{ route('publicaciones.index') }}'">Limpiar filtros</button>
          </form>
        </div>
      </div>
    </aside>

    <section class="col-md-9">
      <h4 class="fw-bold text-gob mb-3">Publicaciones</h4>
      <div id="contenedor" class="row g-4" data-server-rendered="true">
        @forelse($publicaciones as $publicacion)
          <div class="col-md-4">
            <div class="card card-publicacion h-100">
              @php
                $portadaUrl = null;
                if (!empty($publicacion->portada_path)) {
                  $p = $publicacion->portada_path;
                  $portadaUrl = str_starts_with($p, 'imagenes/') ? url('/' . $p) : asset('storage/' . $p);
                }

                $link = $publicacion->external_url;
                if (empty($link) && !empty($publicacion->file_path)) {
                  $f = $publicacion->file_path;
                  $link = str_starts_with($f, 'http') ? $f : url('/' . ltrim($f, '/'));
                }
              @endphp

              @if($portadaUrl)
                <img src="{{ $portadaUrl }}" class="card-img-top" alt="{{ $publicacion->titulo }}">
              @endif
              <div class="card-body d-flex flex-column">
                <h6 class="card-title text-gob fw-bold">{{ $publicacion->titulo }}</h6>
                <p class="text-gob small mb-2">Año: {{ $publicacion->year }}</p>
                <p class="text-gob small mb-2">Ámbito: {{ $publicacion->ambito ?? '—' }}</p>
                @if(!empty($link))
                  <a href="{{ $link }}" target="_blank" rel="noopener" class="mt-auto btn btn-outline-gob btn-sm">Abrir</a>
                @else
                  <button class="mt-auto btn btn-outline-secondary btn-sm" disabled>Sin enlace</button>
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
@endsection
