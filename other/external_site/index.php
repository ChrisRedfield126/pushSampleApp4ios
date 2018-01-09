<?php
header('Access-Control-Allow-Origin: http://wesselheringa.nl');

$array = array(
    "foo" => "bar",
    "bar" => "foo",
"d463fa5df7a53abeff3cae34c891ac38" => "kjenkins@adobe.com",
"78ded9ea7be8a49e9e47fb620a9c92d4" => "scjung@adobe.com",
"373e02d21ff9c94088f345f3576301f0" => "surbhit@adobe.com",
"181c724c4a9a030ee708ca4b6d9b51b4" => "jaiswal.tarun@gmail.com",
"daa0fdb6f331449bdcc5fa1c866e407c" => "bachiary@adobe.com",
"9d05ab365e58025c1e37eac4206f8d37" => "rgiles@adobe.com",
"0efaa1a485bcffdaa76736eb7cd00ada" => "courtnes@adobe.com",
"b119433b380c3061bf56697a0e844a09" => "romsharm@adobe.com",
"cbdb97a5c03742d789db0dc653130b4f" => "kducey@adobe.com",
"d9b3cd2ad2efe5982e4320c429e3e596" => "corby@adobe.com",
"bc6353182def4ae8ac8ff6d2e6768485" => "marquese@adobe.com",
"5d551a8c78802e0e97a575f7afbcc2f3" => "jahodges@adobe.com",
"ad6be20fc5ddedeb4b9fc149a94bf31d" => "rulewis@adobe.com",
"23aa40190bda35fe8ab312ec7abbfa24" => "heringa@adobe.com",
"1290ba09f6462aea6ad73710157a4a70" => "gorla@adobe.com",
"d9053a3bd16e224b71ec8d41d37f237e" => "sanmarti@adobe.com",
"cbd06cf98841f764ca205d1db52012cb" => "velu@adobe.com",
"0c9903f2fc9db1092a26f71dd226bc4f" => "jocummin@adobe.com",
"fe203ef166aca05390e1d2d5fe67fc68" => "tjaiswal@adobe.com",
"3f8792a0a5f36b3cc7ad9d0c07f484e1" => "emoreno@adobe.com",
"250d89bc078858ee61d7443f3db15fa0" => "fvisser@adobe.com",
"11908decdccf74a594099cb925b6a556" => "sbrownin@adobe.com",
"64b33e298add20cf069c0846f0960e21" => "sunghee@adobe.com",
"dfc0a3b019492bcc8002fd9022d8645a" => "zech@adobe.com",
"88c4d9c6e4dae7d2beb303f500ba1f3c" => "barrack@adobe.com",
"162b911fb1cca50e3ac81bf1b00a0def" => "sanaik@adobe.com",
"f81a7f1b2d9c97704968e3f1594175ba" => "stai@adobe.com",
"69b4928c51dcd7299131e32fb38ce62b" => "cguerrer@adobe.com",
"2785df99e8817b93e210d8d37dd34c6b" => "schwedle@adobe.com",
"851502b47aff555a8955b7d709afbb5a" => "sroesing@adobe.com",
"eff7344535520005b6c32847020dcaea" => "ararat@adobe.com",
"0674cb5cd5dff09eab975fb58b2d387d" => "dirkwybe@gmail.com",
"6b7982e7fab14000c36a660016f198a7" => "sedickso@adobe.com",
"afed6b92e74276ded53e4ab2d5c845c9" => "somanath@adobe.com",
"d2f9a05ee4b28c615d73353b2821650f" => "badgandi@adobe.com",
"03c1dc3b60096bea0076718bb7a798df" => "ddejong@adobe.com",
"acc83b3e38369dc114694938afad3a07" => "mblanch@adobe.com",
"e144074d76c39586babada06d12786aa" => "dwoolsey@adobe.com",
"2f93deef6640e6c80408ef89e1089ec4" => "gstoyano@adobe.com",
"9d53c5ac9e823b01057a962fe24c54dc" => "jtalbot@adobe.com",
"61243f647d38350559c7b1b6081ec336" => "david.woolsey@adobe.com",
"cadee393aa6587ffaa599a6ad91a2578" => "maffia@adobe.com",
"782d82827aafef976516bf4ff4a38efd" => "monjo@adobe.com");

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