<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MediaArchivo extends Model
{
    protected $table = 'media_archivos';

    protected $fillable = [
        'publicacion_id', 'nombre_original', 'ruta',
        'tipo_mime', 'tipo_medio', 'extension',
        'tamanio', 'es_portada', 'descripcion',
    ];

    // Tipos MIME permitidos por categoría
    public const TIPOS_IMAGEN    = ['image/jpeg', 'image/png', 'image/webp', 'image/svg+xml'];
    public const TIPOS_GIF       = ['image/gif'];
    public const TIPOS_VIDEO     = ['video/mp4', 'video/webm', 'video/ogg', 'video/avi', 'video/quicktime'];
    public const TIPOS_AUDIO     = ['audio/mpeg', 'audio/ogg', 'audio/wav', 'audio/aac', 'audio/flac'];
    public const TIPOS_DOCUMENTO = ['application/pdf', 'application/msword',
                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                    'application/vnd.ms-excel',
                                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                    'application/vnd.ms-powerpoint',
                                    'application/vnd.openxmlformats-officedocument.presentationml.presentation'];

    public static function resolverTipoMedio(string $mime): string
    {
        if (in_array($mime, self::TIPOS_GIF))       return 'gif';
        if (in_array($mime, self::TIPOS_IMAGEN))    return 'imagen';
        if (in_array($mime, self::TIPOS_VIDEO))     return 'video';
        if (in_array($mime, self::TIPOS_AUDIO))     return 'audio';
        return 'documento';
    }

    public function publicacion(): BelongsTo
    {
        return $this->belongsTo(Publicacion::class, 'publicacion_id');
    }
}
