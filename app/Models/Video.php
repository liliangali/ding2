<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Video extends Model
{
    public  $table = "video";
    public  $timestamps = false;//去掉update_time等三个字段
    public static $vtype = [
      ''
    ];

}
