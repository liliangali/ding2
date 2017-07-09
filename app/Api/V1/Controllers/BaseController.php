<?php

namespace  App\Api\V1\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use Dingo\Api\Routing\Helpers;
date_default_timezone_set('Asia/Shanghai');

class BaseController extends Controller {
    use Helpers;

    public $msg = "";
    /*
     * error resposne
     * @param message
     * @param status
     */

    protected function errorResponse($message = "", $status = 0) {
        if(!$message)
        {
            $message = $this->msg;
        }
        $response = array(
            'msg' => $message,
            'state' => $status,
        );
        return response()->json($response);
    }

    /*
     * success response
     * @param message
     * @param status
     */

    protected function successResponse($data = [],$message = "请求成功", $status = 1)
    {
        $response = array(
            'data' => $data,
            'state' => $status,
        );
        return response()->json($response);
    }

    /*
     * validate response
     * @param message
     * @param status
     */

    protected function validateResponse(Request $request,$validator = [],$data=[])
    {
        if(!$validator)
        {
            return false;
        }

        $validator = Validator::make($request->all(), $validator,$data);
        if ($validator->fails())
        {
            $this->msg = $validator->errors()->first();
            return true;
        }
        return false;

    }

    /*
     * validate response
     * @param message
     * @param status
     */
    protected function saveBT($data,$model)
    {
       return  $model->addT($data);
    }

}
