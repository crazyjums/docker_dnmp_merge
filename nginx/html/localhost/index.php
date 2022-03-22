<?php
// phpinfo();

var_dump(date('Y-m-d H:i:s'));

$redis = new Redis();
$redis->connect('127.0.0.1', 6380);

var_dump($redis->keys('*'));