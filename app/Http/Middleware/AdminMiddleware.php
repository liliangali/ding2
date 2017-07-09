<?php

namespace App\Http\Middleware;

use Closure;
use JWTAuth;
class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $user = JWTAuth::parseToken()->authenticate();
        $response = ['error'=>'token_expired'];
        if($user->user_id != 1)
        {
            return response()->json($response)->setStatusCode(401);
        }
        return $next($request);
    }
}
