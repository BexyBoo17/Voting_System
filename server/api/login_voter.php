<?php
 
require_once "config.php";

session_start();
 

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
 
    
    if(empty(trim($_POST["voter_id_number"]))){
        $user_id_err = "Please enter ID Number.";
    } else{
        $user_id = trim($_POST["voter_id_number"]);
    }
    
   
    if(empty(trim($_POST["registration_code"]))){
        $password_err = "Please enter your registration code.";
    } else{
        $password = trim($_POST["registration_code"]);
    }
    
    
    if(empty($user_id_err) && empty($password_err)){
        
        $sql = "SELECT * FROM voter, ward WHERE voter_id_number = ? AND ward.ward_id = voter.ward_id" ;
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $user_id);
            
            if($result = mysqli_stmt_execute($stmt)){
                $result = $stmt->get_result(); // get the mysqli result
                $user = $result->fetch_assoc(); // fetch data
                
                if($user){

                    $regCode = $user["registration_code"];
                    $local_id = $user["local_muni_id"];
                    
                    if($regCode == $password){
                        http_response_code(200);
                        $user["upper_type"] = getUpperType($local_id, $conn);
                        $_SESSION["from_district"] = $user["upper_type"] == "district";
                        $_SESSION["voter_id_number"] = $user["voter_id_number"];
                        $_SESSION["voted"] = FALSE;

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
 
