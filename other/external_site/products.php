<?php
header('Content-Type: application/json');

//$produts = http_get("http://wesbites.com/products/products.txt");
//$response = http_get("http://wesbites.com/products/products.txt", array("timeout"=>1), $info);

//echo $info;

$curl = curl_init();
    curl_setopt ($curl, CURLOPT_URL, "http://wesbites.com/msg/products.txt");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

    $result = curl_exec ($curl);
    curl_close ($curl);
$products = json_decode($result,true);

if(!isset($_GET['id'])){

    echo "[";

    $numproducts = count($products);
    for ($i = 0; $i < $numproducts; $i++) {

        $product = $products[$i];

        echo json_encode($product);   
        if(($i+1) != $numproducts){
            echo ",";
        }
    }

    echo "]";
}
else{
    $id = $_GET['id'];
    $numproducts = count($products);
    $found=false;
     for ($i = 0; $i < $numproducts; $i++) {
         $product = $products[$i];
          
         if($product['productid']==$id){
            echo json_encode($products[$i]);   
             $found = true;
             return;
         }
    }
    if(!$found){
        echo "Product not found";   
    }
    
}



?>