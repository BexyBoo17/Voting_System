<?php
 
require_once "config.php";
 

$user_id = $password = "";
$user_id_err = $password_err = "";
 
function getUpperType($local_id, $conne){
    $sql = "SELECT upper_municipality.type FROM upper_municipality , local_municipality WHERE  upper_municipality.upper_muni_id = local_municipality.upper_muni_id AND local_municipality.local_muni_id = ?";
    
    if($stmt = mysqli_prepare($conne, $sql)){
            
        mysqli_stmt_bind_param($stmt, "s", $local_id);
        
        if($result = mysqli_stmt_execute($stmt)){
            $result = $stmt->get_result(); // get the mysqli result
            $type = $result->fetch_assoc(); // fetch data
             if($type)
                return $type["type"];
            else
                return null;
            
        }
    }
    return null;
}
 

if($_SERVER["REQUEST_METHOD"] == "POST"){
 
    
    if(empty(trim($_POST["iec_number"]))){
        $user_id_err = "Please enter ID Number.";
    } else{
        $user_id = trim($_POST["iec_number"]);
    }
    
   
    if(empty(trim($_POST["password"]))){
        $password_err = "Please enter your registration code.";
    } else{
        $password = trim($_POST["password"]);
    }
    
    
    if(empty($user_id_err) && empty($password_err)){
        
        $sql = "SELECT * FROM iec_member WHERE iec_member_id_number = ?" ;
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $user_id);
            
            if($result = mysqli_stmt_execute($stmt)){
                $result = $stmt->get_result(); // get the mysqli result
                $user = $result->fetch_assoc(); // fetch data
                
                if($user){

                    $passwordHash = $user["password_hash"];
                    $valid = password_verify($password, $passwordHash);
                    
                    if($valid){
                        http_response_code(200);
                        echo json_encode($user);
                    }else{
                        http_response_code(401);
                        echo "pas";
                    }


                }else{
                    http_response_code(401);
                    echo "us";

                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }else{
        http_response_code(401);
     }
    
    
    mysqli_close($conn);
}
?>
 
