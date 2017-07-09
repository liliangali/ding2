<?php

namespace App\Http\Middleware;

use Closure;
use JWTAuth;
class AuthUser
{
    /**
     *验证是否是渠道的请求
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $user = JWTAuth::parseToken()->authenticate();
        $response = ['error'=>'token_expired'];
        if($user->member_type == 0)
        {
            return response()->json($response)->setStatusCode(401);
        }
        return $next($request);
    }
}
