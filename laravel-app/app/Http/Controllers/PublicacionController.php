<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use App\Models\Publicacion;
use App\Models\MediaArchivo;
use Illuminate\Support\Facades\Log;

class PublicacionController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth')->only(['create', 'store', 'edit', 'update', 'destroy']);
    }

    public function index(Request $request)
    {
        $buscar   = $request->input('buscar');
        $categoria = $request->input('categoria', 'todas'); // cientifica|tecnica|ilustracion|todas
        $anio     = $request->input('anio');
        $tipo     = $request->input('tipo');
        $orden    = $request->input('orden', 'reciente');

        $query = Publicacion::where('is_published', true);

        if (!empty($buscar)) {
            $query->where('titulo', 'ilike', '%' . $buscar . '%');
        }
        if (!empty($anio)) {
            $query->where('ano', (int) $anio);
        }
        if (!empty($tipo)) {
            $query->where('tipo', $tipo);
        }
        if ($categoria !== 'todas') {
            $query->where('categoria', $categoria);
        }

        $query->orderBy('ano', $orden === 'antiguo' ? 'asc' : 'desc')
              ->orderBy('titulo');

        $publicaciones = $query->paginate(12)->appends($request->query());

        return view('publicaciones.index', compact('publicaciones'));
    }

    public function show(Publicacion $publicacion)
    {
        return view('publicaciones.show', compact('publicacion'));
    }

    public function create()
    {
        return view('publicaciones.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'titulo'       => 'required|string|max:500',
            'titulo_en'    => 'nullable|string|max:500',
            'ano'          => 'nullable|integer|min:1900|max:2100',
            'categoria'    => 'required|in:cientifica,tecnica,ilustracion',
            'tipo'         => 'nullable|string|max:50',
            'external_url' => 'nullable|url',
            'mensaje'      => 'nullable|string|max:500',
            'portada'      => 'nullable|image|max:5120',   // 5 MB
            'archivo'      => 'nullable|file|max:204800',  // 200 MB
        ]);

        $portadaPath = null;
        $filePath    = null;

        if ($request->hasFile('portada')) {
            $portadaPath = $request->file('portada')->store('uploads/portadas', 'public');
        }

        if ($request->hasFile('archivo')) {
            $file = $request->file('archivo');
            $ext  = strtolower($file->getClientOriginalExtension());
            $mime = $file->getMimeType();

            $limites = [
                'pdf'  => 20 * 1024 * 1024,
                'mp3'  => 50 * 1024 * 1024,
                'mp4'  => 200 * 1024 * 1024,
                'webm' => 200 * 1024 * 1024,
                'avi'  => 200 * 1024 * 1024,
                'mov'  => 200 * 1024 * 1024,
                'jpg'  => 5 * 1024 * 1024,
                'jpeg' => 5 * 1024 * 1024,
                'png'  => 5 * 1024 * 1024,
                'gif'  => 10 * 1024 * 1024,
                'webp' => 5 * 1024 * 1024,
                'wav'  => 50 * 1024 * 1024,
                'ogg'  => 50 * 1024 * 1024,
                'aac'  => 50 * 1024 * 1024,
                'doc'  => 20 * 1024 * 1024,
                'docx' => 20 * 1024 * 1024,
                'xls'  => 20 * 1024 * 1024,
                'xlsx' => 20 * 1024 * 1024,
                'ppt'  => 30 * 1024 * 1024,
                'pptx' => 30 * 1024 * 1024,
            ];

            if (!array_key_exists($ext, $limites)) {
                return back()->withInput()->withErrors(['archivo' => 'Tipo de archivo no permitido.']);
            }
            if ($file->getSize() > $limites[$ext]) {
                return back()->withInput()->withErrors(['archivo' => 'El archivo excede el tamaño máximo permitido.']);
            }

            $filePath = $file->store('uploads/archivos', 'public');

            // Registrar también en media_archivos para soporte multimedia completo
            $tipoMedio = MediaArchivo::resolverTipoMedio($mime);
        }

        // Use media category (video, imagen, audio, gif, documento) instead of raw extension
        $tipo = $request->input('tipo');
        if (empty($tipo) && isset($tipoMedio)) {
            $tipo = $tipoMedio;
        } elseif (empty($tipo)) {
            $tipo = $ext ?? 'pdf';
        }

        $publicacion = Publicacion::create([
            'titulo'       => $request->input('titulo'),
            'titulo_en'    => $request->input('titulo_en'),
            'ano'          => $request->input('ano'),
            'categoria'    => $request->input('categoria'),
            'tipo'         => $tipo,
            'portada_path' => $portadaPath,
            'file_path'    => $filePath,
            'external_url' => $request->input('external_url'),
            'mensaje'      => $request->input('mensaje'),
            'created_by'   => Auth::id(),
            'is_published' => true,
        ]);

        // Si se subió un archivo, guardarlo también en media_archivos
        if ($request->hasFile('archivo') && $filePath) {
            $file = $request->file('archivo');
            MediaArchivo::create([
                'publicacion_id'  => $publicacion->id,
                'nombre_original' => $file->getClientOriginalName(),
                'ruta'            => $filePath,
                'tipo_mime'       => $file->getMimeType(),
                'tipo_medio'      => $tipoMedio ?? 'documento',
                'extension'       => strtolower($file->getClientOriginalExtension()),
                'tamanio'         => $file->getSize(),
                'es_portada'      => false,
            ]);
        }

        return redirect()->route('publicaciones.index')
                         ->with('status', 'Publicación creada correctamente.');
    }

    public function listarTodas(Request $request)
    {
        $query = Publicacion::query();

        if ($request->filled('buscar')) {
            $query->where('titulo', 'ilike', '%' . $request->input('buscar') . '%');
        }
        if ($request->filled('tipo')) {
            $query->where('tipo', $request->input('tipo'));
        }
        if ($request->filled('ano') || $request->filled('year')) {
            $query->where('ano', $request->input('ano') ?? $request->input('year'));
        }

        $publicaciones = $query->orderBy('ano', 'desc')->get();

        $publicacionesTecnicas      = $publicaciones->where('categoria', 'tecnica');
        $publicacionesCientificas   = $publicaciones->where('categoria', 'cientifica');
        $publicacionesIlustraciones = $publicaciones->where('categoria', 'ilustracion');

        return view('publicaciones.listar', compact('publicacionesTecnicas', 'publicacionesCientificas', 'publicacionesIlustraciones'));
    }
}
