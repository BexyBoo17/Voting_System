<?php

require_once "config.php";
 

$party_id = "";
$party_id_err = "";
$name = "";
$name_err = "";



if($_SERVER["REQUEST_METHOD"] == "POST"){
 


    if(empty(trim($_POST["code"]))){
        $first_name_err = "Please Enter Party Name";
    } else{
       
        $sql = "SELECT * FROM upper_municipality WHERE upper_muni_id = ?";
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $code);
            
            $code = trim($_POST["code"]);
            
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){
                    $code_err = "This name is already taken.";
                } else{
                    $code = trim($_POST["code"]);
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }

    if(empty(trim($_POST["name"]))){
        $first_name_err = "Please Enter  Name";
    } else{
        $name = trim($_POST["name"]);
    }

    

    
    
    if(empty($code_err)){
        
       
        $sql = "INSERT INTO upper_municipality(upper_muni_id, name, type) VALUES (?, ?, ?)";
        if($stmt = mysqli_prepare($conn, $sql)){
            $type = "district";
            mysqli_stmt_bind_param($stmt, "sss", $code, $name, $type);
            

            if(mysqli_stmt_execute($stmt)){
                http_response_code(200);
                echo json_encode("{}");
            } else{
                http_response_code(500);
            }


            
            mysqli_stmt_close($stmt);
        }
    
    }else{
        http_response_code(409);
    }
    
    
    mysqli_close($conn);
}
?>
 
