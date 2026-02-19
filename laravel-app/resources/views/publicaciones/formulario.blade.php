@extends('layouts.app')

@section('title', 'Formulario de Carga | INIFAP')

@section('content')
<div class="container py-5">
    <h1 class="mb-4">Formulario de Carga de Contenido</h1>
    <form>
        <div class="mb-3">
            <label for="titulo" class="form-label">Título</label>
            <input type="text" id="titulo" name="titulo" class="form-control" placeholder="Ingrese el título">
        </div>

        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea id="descripcion" name="descripcion" class="form-control" rows="4" placeholder="Ingrese la descripción"></textarea>
        </div>

        <div class="mb-3">
            <label for="archivo" class="form-label">Archivo</label>
            <input type="file" id="archivo" name="archivo" class="form-control">
        </div>

        <button type="submit" class="btn btn-primary">Subir</button>
    </form>

    <div class="mt-4">
        <a href="{{ route('publicaciones.index') }}" class="btn btn-secondary">Regresar al inicio de publicaciones</a>
    </div>
</div>
@endsection