<?php

$pass = md5("dma_bootcamp_2016");//3cabbd82cce40dd0207e6301ac195599

    
if(isset($_GET[$pass])){
    //echo "tracked";
    if(isset($_GET['crm_id'])){        
        $d = date("Y/m/d h:i:s");
        $g = "";
        
        foreach($_GET as $key => $value){
            if($key!=$pass){
                $g .= " - [" . $key . "=" . $value . "]";
            }
        }
        $message = "Tracked call at " . $d . " with parameters " . $g;
        
        
       $file = 'tracked.txt';
        // Open the file to get existing content
        $current = file_get_contents($file);
        
        $lines = split("\n",$current);
        $newlines = array();
        $newlines[] = $message;
        
        for($i=0;$i<count($lines);$i++){
            if($i>200){
                break;
            }
            $newlines[] = $lines[$i];    
        }
        
        // Append a new person to the file
        $result = implode ($newlines, "\n");
        
        // Write the contents back to the file
        file_put_contents($file, $result);
        
        //echo "<br/>" . str_replace("\n","<br/>",$result);
        echo $message;
    }
}
else{
    echo "unknown error";
}


    

?>