<?php
header('Access-Control-Allow-Origin: http://wesselheringa.nl');

$array = array(
    "foo" => "bar",
    "bar" => "foo",
"d63fa5df7a53abeff3cae34c891ac38" => "toto@toto.invalid",
"cadee393aa6587ffaa599a6ad91a2578" => "tata@titi.invalid",
"782d82827aafef976516bf4ff4a38efd" => "titi@titi.invalid");

$users = array_flip($array);




if(!$_GET['username'] || !$_GET['password']){
	$result = "username ('" . $_GET['username'] . "') or password ('" .  $_GET['password'] . "') not set";
}
else{
    if(array_key_exists($_GET['username'],$users)){
        $result = "" . $users[$_GET['username']];
    }
    else{
	   $result = "user does not exists in crm"; //md5(md5($_GET['username']) . md5($_GET['password']));
    }
}



echo $result;

?>
