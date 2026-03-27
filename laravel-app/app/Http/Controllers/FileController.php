<?php

namespace App\Http\Controllers;

use App\Models\File;
use App\Models\Publicacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\StreamedResponse;

class FileController extends Controller
{
    public function index()
    {
        $files = File::latest()->get();
        return view('files.index', compact('files'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'archivo'     => 'required|file|mimes:jpg,jpeg,png,gif,webp,svg,'
                           . 'pdf,doc,docx,xls,xlsx,ppt,pptx,'
                           . 'mp4,webm,avi,mov,mkv,ogv,'
                           . 'mp3,wav,ogg,aac,flac'
                           . '|max:204800',
            'titulo'      => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'file_type'   => 'required|string|in:PDF,Imagen,GIF,Video,Audio,Documento',
            'category'    => 'required|string|in:Publicación Científica,Publicación Técnica,Ilustración,Vídeo,Audio,Folleto',
        ]);

        $uploadedFile = $request->file('archivo');

        // Guardar en disco public para que sea accesible vía /storage/
        $path = $uploadedFile->store('uploads/archivos', 'public');

        // Registrar en tabla files (gestión de archivos)
        File::create([
            'name'        => $uploadedFile->getClientOriginalName(),
            'title'       => $request->input('titulo'),
            'description' => $request->input('descripcion'),
            'path'        => $path,
            'type'        => $uploadedFile->getMimeType(),
            'file_type'   => $request->input('file_type'),
            'category'    => $request->input('category'),
            'size'        => $uploadedFile->getSize(),
        ]);

        // Mapear categoría del formulario → enum de publicaciones
        $categoriaMap = [
            'Publicación Científica' => 'cientifica',
            'Publicación Técnica'    => 'tecnica',
            'Ilustración'            => 'ilustracion',
            'Vídeo'                  => 'ilustracion',
            'Audio'                  => 'ilustracion',
            'Folleto'                => 'tecnica',
        ];

        // Mapear tipo de archivo → campo tipo de publicaciones
        $tipoMap = [
            'PDF'       => 'pdf',
            'Imagen'    => 'imagen',
            'GIF'       => 'gif',
            'Video'     => 'video',
            'Audio'     => 'audio',
            'Documento' => 'documento',
        ];

        $fileType = $request->input('file_type');
        $category = $request->input('category');

        // Determinar si el archivo principal es portada o descarga
        $esImagen = in_array($fileType, ['Imagen', 'GIF']);

        Publicacion::create([
            'titulo'       => $request->input('titulo'),
            'titulo_en'    => null,
            'ano'          => (int) date('Y'),
            'categoria'    => $categoriaMap[$category] ?? 'ilustracion',
            'tipo'         => $tipoMap[$fileType] ?? 'documento',
            'portada_path' => $esImagen ? $path : null,
            'file_path'    => $esImagen ? null : $path,
            'external_url' => null,
            'mensaje'      => $request->input('descripcion'),
            'is_published' => true,
        ]);

        return redirect()->route('files.index')->with('success', 'Archivo subido correctamente.');
    }

    public function download(int $id): StreamedResponse
    {
        $file = File::findOrFail($id);

        // Primero intentar en disco public (nueva ubicación)
        if (Storage::disk('public')->exists($file->path)) {
            return Storage::disk('public')->download($file->path, $file->name);
        }

        // Fallback al disco uploads (ubicación anterior)
        return Storage::disk('uploads')->download($file->path, $file->name);
    }

    public function destroy(int $id)
    {
        $file = File::findOrFail($id);

        // Borrar el archivo físico
        if (Storage::disk('public')->exists($file->path)) {
            Storage::disk('public')->delete($file->path);
        } elseif (Storage::disk('uploads')->exists($file->path)) {
            Storage::disk('uploads')->delete($file->path);
        }

        $file->delete();

        return redirect()->route('files.index')->with('success', 'Archivo eliminado correctamente.');
    }
}
