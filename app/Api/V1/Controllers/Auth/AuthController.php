<?php

namespace App\Api\V1\Controllers\Auth;
use App\Models\Article;
use App\Models\Video;
use Illuminate\Support\Facades\DB;
use Validator;
use App\Api\V1\Controllers\BaseController;
use Carbon\Carbon;
use EasyWeChat\Foundation\Application;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Storage;
use Illuminate\Support\Str;
use Intervention\Image\ImageManager;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\User;
use EasyWeChat\Message\Material;
use Cache;
class AuthController extends BaseController {
    
    
    public function gapi(Request $request)
    {
        $today_time = strtotime(date("Y-m-d"));
        if(isset($request->r) && $request->r == 1)
        {
            Cache::store('file')->forget("get_tody_data");
        }
        $video = Video::orderBy("id","DESC")->first();
        if(!$video || ($video->add_time < strtotime(date("Y-m-d"))))
        {
            Cache::store('file')->forget("get_tody_data");
        }
        if(!(Cache::store('file')->get('get_tody_data')))
        {
            $jiucai_api = "http://zywz33.com/api/index.asp?ac=videolist&rid=1&h=24&pg=1";
            $xianfeng_api = "http://www.00lsn.com/xfplay.php?ac=videolist&rid=2&h=24&pg=1";
            $jres = $this->getContent($jiucai_api);
            $xres = $this->getContent($xianfeng_api);
            if(isset($jres['list']['video']))
            {
                $this->addV($jres['list']['video'],'久草');
            }
            if(isset($xres['list']['video']))
            {
                $this->addV($xres['list']['video'],'先锋');
            }
            $ctime = 24*60*60 -(time()-$today_time);
            if($ctime <= 0)
            {
                $ctime = 1;
            }
            Cache::store('file')->put('get_tody_data',1,$ctime);
        }
        $video = Video::where("add_time",'>',$today_time)->orderBy("id","DESC")->paginate(60);
        $list = $video->toArray();
        $data = $list['data'];
        $list['data'] = collect($data)->map(function ($item,$key){
            $item['content'] = json_decode($item['content'],1);
            return $item;
        })->toArray();
        return $this->successResponse($list);
    }
    
    public function getx(Request $request)
    {
        $today_time = strtotime(date("Y-m-d"));
        $video = Video::where("add_time",'>',$today_time)->orderBy("id","DESC")->paginate(60);
        $list = $video->toArray();
        $data = $list['data'];
        $type = collect($data)->keyBy("ttid")->map(function ($item){
            return $item['type'];
        })->sort()->all();
        ksort($type);

        //拼接xml
        $xml = '<?xml version="1.0" encoding="utf-8"?><rss version="4.0">';
        $class = '<class>';
        foreach ($type as $index => $item)
        {
            // <ty id="1">亚洲无码</ty>
            $ty = '<ty id="'.$index.'">'.$item.'</ty>';
            $class .= $ty;
        }
        $class .= '</class>';

        $xml .= $class;
        $xml .= '<list page="1" pagecount="1" pagesize="20" recordcount="13">';
        $videol = '';
        foreach ($data as $key=>$val)
        {
            $content = json_decode($val['content'],1);
            $video = '<video>';//$val['last']
            $video .= '<last>'.$val['last'].'</last>';
            $video  .= '<id>'.$val['tid'].'</id>';
            $video  .= '<tid>'.$val['ttid'].'</tid>';
            $mname = $val['mname'];
            $name = $val['name'];
            if($mname)
            {
                $mname_arr = explode("\n",$mname);
                $mname_arr[] = $val['name'];
                $name = collect($mname_arr)->random();
            }
            $video  .= '<name><![CDATA['.$name.']]></name>';
            $video  .= '<type>'.$val['type'].'</type>';
            $video  .= '<pic>'.$val['pic'].'</pic>';
            $video  .= '<lang></lang>';
            $video  .= '<area></area>';
            $video  .= '<year>0</year>';
            $video  .= '<state>0</state>';
            $video  .= '<note><![CDATA[]]></note>';
            $video  .= ' <actor><![CDATA[]]></actor>';
            $video  .= '<director><![CDATA[]]></director>';
            $video  .= '<dl><dd flag="ckplayer"><![CDATA['.$val['dd'].']]></dd></dl>';
            $video  .= '<des><![CDATA[]]></des>';
            $video .= '</video>';
            $videol .= $video;
        }
        $xml .= $videol;


        //增加图片和文章
        $article = $this->getd();
        $art =  [];
        $img = [];
        if($article['art'])
        {
            $art = collect($article['img'])->random(5)->all();
        }
        if($article['img'])
        {
            $img = collect($article['img'])->random(5)->all();
        }
        $c_arr = array_merge($art,$img);
echo '<pre>';print_r(count($c_arr));exit;
        $articlel = "";
        foreach ((array)$c_arr as $i => $item)
        {
            $article = '<article>';//$val['last']
            $article .= '<last>'.date("Y-m-d H-i-s").'</last>';
            $article  .= '<tid>'.$item['tid'].'</tid>';
            $article  .= '<name><![CDATA['.$item['title'].']]></name>';
            $article  .= '<content><![CDATA['.$item['content'].']]></content>';
            $article  .= '</article>';
            $articlel .= $article;
        }
//echo '<pre>';print_r($articlel);exit;
        $xml .= $articlel;
        $xml .= '</list>';
        $xml.="</rss>";
        return $xml;
    }

    public function getd()
    {
//        echo '<pre>';print_r(storage_path('app/public/art/2017-07-06'));exit;
        $date = date("Y-m-d");
        $date = "2017-07-06";
        $art = 'public/art/'.$date;
        $img = 'public/img/'.$date;
        $art_arr = $this->getFileList($art);
        $img_arr = $this->getFileList($img);
        $all = array_merge($art_arr,$img_arr);
        foreach ((array)$all as $index => $item)
        {
            $title = $item['title'];
            $article = Article::where("title",$title)->first();
            if(!$article)
            {
                Article::insert(['title'=>$title,'fiel_dir'=>$item['file_dir']]);
                continue;
            }
        }
        $all['art'] = $art_arr;
        $all['img'] = $img_arr;
        return $all;
//        echo '<pre>';print_r($all);exit;
//        return $all;

//        echo '<pre>';print_r($all);exit;
    }
    
    public function getFileList($dir)
    {
        $files = Storage::files($dir);
        $all = [];
        foreach ((array)$files as $index => $item)
        {
            $c = [];
            $content = Storage::get($item);
            preg_match('/<title>([\S\s\d]*?)<\/title>/', $content, $titleArr);
            if(!isset($titleArr[1]))
            {
                continue;
            }
            $c['title'] = isset($titleArr[1]) ? $titleArr[1] : '';
            $article = Article::where("title",$c['title'])->where("fiel_dir",'!=',$item)->first();
            if($article)//删除文章
            {
                Storage::delete($item);
                continue;
            }

            preg_match('/<tid>([\S\s\d]*?)<tid>/', $content, $tidArr);
            $c['tid'] = isset($tidArr[1]) ? $tidArr[1] : '';

            preg_match('/<content>([\S\s\d]*?)<\/content>/', $content, $contentArr);
            $c['content'] = isset($contentArr[1]) ? $contentArr[1] : '';
            $c['file_dir'] = $item;
            $all[] = $c;
        }
        return $all;
    }
    public function getContent($url)
    {
        $client = new Client([
            // Base URI is used with relative requests
            // You can set any number of default request options.
            'timeout'         => 0,
        ]);
        $res = $client->request("GET",$url,['connect_timeout' => 30]);
        $body = $res->getBody();
        //将XML转为array
        //禁止引用外部xml实体
        libxml_disable_entity_loader(true);
        $xml= json_decode(json_encode(simplexml_load_string($body, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        return $xml;
    }

    public function addV($jvideo,$vtype)
    {
        $time = time();
        $data['vtype'] = $vtype;
        foreach ((array)$jvideo as $index => $item)
        {
            //=====  根据ID和来源排除重复抓取  =====
            if(Video::where("tid",$item['id'])->where("vtype",$vtype)->first())
            {
                continue;
            }
            $data['tid'] = $item['id'];
            $data['ttid'] = $item['tid'];
            $data['last'] = $item['last'];
            $data['name'] = $item['name'];
            $data['type'] = $item['type'];
            $data['pic'] = $item['pic'];
            $data['dd'] = $item['dl']['dd'];
            $data['add_time'] = $time;
            $data['content'] = json_encode($item);
            Video::insert($data);
        }
    }

    public function geti(Request $request)
    {
        $id = $request->id;
        return $this->successResponse(Video::find($id)->toArray());
    }
    public function save(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id'=>"required|integer",
        ]);
        if($validator->fails())
        {
            return $this->errorResponse($validator->errors()->first());
        }
        Video::where("id",$request->id)->update(['mname'=>$request->mname]);
        return $this->successResponse();
    }


}
