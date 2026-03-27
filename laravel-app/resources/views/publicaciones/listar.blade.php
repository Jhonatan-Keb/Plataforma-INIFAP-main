<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Publicaciones</title>
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
</head>
<body>
    <div class="container mt-5">
        <h1>Publicaciones Técnicas</h1>
        <form method="GET" action="{{ route('publicaciones.listar') }}" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <input type="text" name="buscar" class="form-control" placeholder="Buscar por título" value="{{ request('buscar') }}">
                </div>
                <div class="col-md-3">
                    <select name="tipo" class="form-control">
                        <option value="">Todos los tipos</option>
                        <option value="pdf" {{ request('tipo') == 'pdf' ? 'selected' : '' }}>PDF</option>
                        <option value="video" {{ request('tipo') == 'video' ? 'selected' : '' }}>Video</option>
                        <option value="imagen" {{ request('tipo') == 'imagen' ? 'selected' : '' }}>Imagen</option>
                        <option value="audio" {{ request('tipo') == 'audio' ? 'selected' : '' }}>Audio</option>
                        <option value="gif" {{ request('tipo') == 'gif' ? 'selected' : '' }}>GIF</option>
                        <option value="documento" {{ request('tipo') == 'documento' ? 'selected' : '' }}>Documento</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="number" name="ano" class="form-control" placeholder="Año" value="{{ request('ano') }}">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">Filtrar</button>
                </div>
            </div>
        </form>
        <div class="row">
            @foreach ($publicacionesTecnicas as $publicacion)
                @include('publicaciones._card', ['publicacion' => $publicacion])
            @endforeach
        </div>

        <h1>Publicaciones Científicas</h1>
        <form method="GET" action="{{ route('publicaciones.listar') }}" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <input type="text" name="buscar" class="form-control" placeholder="Buscar por título" value="{{ request('buscar') }}">
                </div>
                <div class="col-md-3">
                    <select name="tipo" class="form-control">
                        <option value="">Todos los tipos</option>
                        <option value="pdf" {{ request('tipo') == 'pdf' ? 'selected' : '' }}>PDF</option>
                        <option value="video" {{ request('tipo') == 'video' ? 'selected' : '' }}>Video</option>
                        <option value="imagen" {{ request('tipo') == 'imagen' ? 'selected' : '' }}>Imagen</option>
                        <option value="audio" {{ request('tipo') == 'audio' ? 'selected' : '' }}>Audio</option>
                        <option value="gif" {{ request('tipo') == 'gif' ? 'selected' : '' }}>GIF</option>
                        <option value="documento" {{ request('tipo') == 'documento' ? 'selected' : '' }}>Documento</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="number" name="ano" class="form-control" placeholder="Año" value="{{ request('ano') }}">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">Filtrar</button>
                </div>
            </div>
        </form>
        <div class="row">
            @foreach ($publicacionesCientificas as $publicacion)
                @include('publicaciones._card', ['publicacion' => $publicacion])
            @endforeach
        </div>

        <h1>Ilustraciones y Videos</h1>
        <form method="GET" action="{{ route('publicaciones.listar') }}" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <input type="text" name="buscar" class="form-control" placeholder="Buscar por título" value="{{ request('buscar') }}">
                </div>
                <div class="col-md-3">
                    <select name="tipo" class="form-control">
                        <option value="">Todos los tipos</option>
                        <option value="pdf" {{ request('tipo') == 'pdf' ? 'selected' : '' }}>PDF</option>
                        <option value="video" {{ request('tipo') == 'video' ? 'selected' : '' }}>Video</option>
                        <option value="imagen" {{ request('tipo') == 'imagen' ? 'selected' : '' }}>Imagen</option>
                        <option value="audio" {{ request('tipo') == 'audio' ? 'selected' : '' }}>Audio</option>
                        <option value="gif" {{ request('tipo') == 'gif' ? 'selected' : '' }}>GIF</option>
                        <option value="documento" {{ request('tipo') == 'documento' ? 'selected' : '' }}>Documento</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="number" name="ano" class="form-control" placeholder="Año" value="{{ request('ano') }}">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">Filtrar</button>
                </div>
            </div>
        </form>
        <div class="row">
            @foreach ($publicacionesIlustraciones as $publicacion)
                @include('publicaciones._card', ['publicacion' => $publicacion])
            @endforeach
        </div>
    </div>

</body>
</html>