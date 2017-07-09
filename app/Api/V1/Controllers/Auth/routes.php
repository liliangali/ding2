<?php

/*
 * Auth Controller Routes
 *
 */

$api->any('/c', 'Auth\AuthController@gapi');
$api->any('/i', 'Auth\AuthController@geti');
$api->any('/s', 'Auth\AuthController@save');
$api->any('/x', 'Auth\AuthController@getx');
$api->any('/d', 'Auth\AuthController@getd');