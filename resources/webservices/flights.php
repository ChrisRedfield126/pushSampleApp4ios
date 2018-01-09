<?php
header('Content-Type: application/json');

$curl = curl_init();
    curl_setopt ($curl, CURLOPT_URL, "http://wesbites.com/msg/flights.txt");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

    $result = curl_exec ($curl);
    curl_close ($curl);
$flights = json_decode($result,true);

if(!isset($_GET['id'])){

    echo "[";

    $numflights = count($flights);
    for ($i = 0; $i < $numflights; $i++) {

        $flight = $flights[$i];

        echo json_encode($flight);   
        if(($i+1) != $numflights){
            echo ",";
        }
    }

    echo "]";
}
else{
    $id = $_GET['id'];
    $numflights = count($flights);
    $found=false;
     for ($i = 0; $i < $numflights; $i++) {
         $flight = $flights[$i];
          
         if($flight['flightid']==$id){
            echo json_encode($flights[$i]);   
             $found = true;
             return;
         }
    }
    if(!$found){
        echo "Product not found";   
    }
    
}



?>