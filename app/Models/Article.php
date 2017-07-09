<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    public  $table = "article";
    public  $timestamps = false;//去掉update_time等三个字段

}
