<?php

require_once "config.php";
 

$user_id = $password = $confirm_password = "";
$user_id_err = $password_err = $confirm_password_err = "";
$first_name = $password = $confirm_password = "";
$first_name_err = $password_err = $confirm_password_err = "";
$last_name = $password = $confirm_password = "";
$last_name_err = $password_err = $confirm_password_err = "";
$physical_address = $password = $confirm_password = "";
$physical_address_err = $password_err = $confirm_password_err = "";
$ward_id = $password = $confirm_password = "";
$ward_id_err = $password_err = $confirm_password_err = "";


if($_SERVER["REQUEST_METHOD"] == "POST"){
 
   
    if(empty(trim($_POST["voter_id_number"]))){
        $user_id_err = "Please enter a voter id number.";
    } else{
       
        $sql = "SELECT voter_id_number FROM voter WHERE voter_id_number = ?";
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $param_user_id);
            
            
            $param_user_id = trim($_POST["voter_id_number"]);
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){
                    $user_id_err = "This id number is already taken.";
                } else{
                    $user_id = trim($_POST["voter_id_number"]);
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }


    if(empty(trim($_POST["first_name"]))){
        $first_name_err = "Please Enter Voter Last Name";
    } else{
        $first_name = trim($_POST["first_name"]);
    }
    if(empty(trim($_POST["last_name"]))){
        $first_name_err = "Please Enter Voter Last Name";
    } else{
        $last_name = trim($_POST["last_name"]);
    }

    if(empty(trim($_POST["physical_address"]))){
        $first_name_err = "Please Enter Voter Last Name";
    } else{
        $physical_address = trim($_POST["physical_address"]);
    }

    if(empty(trim($_POST["ward_id"]))){
        $first_name_err = "Please Enter Voter Last Name";
    } else{
        $ward_id = trim($_POST["ward_id"]);
    }

    if(empty(trim($_POST["iec_member_registrant_id"]))){
        $first_name_err = "Please Enter Voter Last Name";
    } else{
        $iec_member_registrant_id = trim($_POST["iec_member_registrant_id"]);
    }

    

    $registrationCode = rand(0, 1000);
    
    
    
    if(empty($user_id_err)){
        
       
        $sql = "INSERT INTO voter (voter_id_number, registration_code, first_name, last_name, physical_address, ward_id, iec_member_registrant_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
         
        if($stmt = mysqli_prepare($conn, $sql)){
            mysqli_stmt_bind_param($stmt, "sssssss", $user_id, $registrationCode, $first_name, $last_name, $physical_address, $ward_id, $iec_member_registrant_id);

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