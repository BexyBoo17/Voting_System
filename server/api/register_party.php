<?php

require_once "config.php";
 

$party_id = "";
$party_id_err = "";
$name = "";
$name_err = "";



if($_SERVER["REQUEST_METHOD"] == "POST"){
 


    if(empty(trim($_POST["name"]))){
        $first_name_err = "Please Enter Party Name";
    } else{
       
        $sql = "SELECT name FROM party WHERE name = ?";
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $param_name);
            
            $param_name = trim($_POST["name"]);
            
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){
                    $name_err = "This name is already taken.";
                } else{
                    $name = trim($_POST["name"]);
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }

    
    
    if(empty($name_err)){
        
       
        $sql = "INSERT INTO party(party_id, name) VALUES (?, ?)";
         
        if($stmt = mysqli_prepare($conn, $sql)){
            $id = rand(0, 1000000);
            
            mysqli_stmt_bind_param($stmt, "is", $id, $name);
                
            if(mysqli_stmt_execute($stmt)){
                http_response_code(200);
                echo json_encode("{}");
            } else{
                http_response_code(500);
                echo json_encode("{}");
            }

            
            mysqli_stmt_close($stmt);
        }
    }else{
        http_response_code(409);
    }
    
    
    mysqli_close($conn);
}
?>
 
