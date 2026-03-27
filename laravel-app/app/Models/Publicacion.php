<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Publicacion extends Model
{
    protected $table = 'publicaciones';

    protected $fillable = [
        'titulo', 'titulo_en', 'ano', 'categoria', 'tipo',
        'portada_path', 'file_path', 'external_url',
        'mensaje', 'cuenta', 'created_by', 'is_published',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function medios(): HasMany
    {
        return $this->hasMany(MediaArchivo::class, 'publicacion_id');
    }
}
