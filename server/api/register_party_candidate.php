<?php

require_once "config.php";
 

$party_id = "";
$party_id_err = "";
$name = "";
$name_err = "";
$ward_id = "";
$ward_id_err = ""; 
$candidate_id="";
$candidate_id_err=""; 



if($_SERVER["REQUEST_METHOD"] == "POST"){
 
   
    if(empty(trim($_POST["candidate_id"]))){
        $candidate_id_err = "Please enter candidate id.";
    } else{
       
        $sql = "SELECT candidate_id FROM ward_candidate WHERE candidate_id = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $candidate_id);
            
            
            $param_candidate_id = trim($_POST["candidate_id"]);
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){
                    $candidate_id_err = "This id number is already taken.";
                } else{
                    $candidate_id = trim($_POST["candidate_id"]);
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }

    if(empty(trim($_POST["name"]))){
        $candidate_name_err = "Please Enter Candidate Name";
    } else{
       
        $sql = "SELECT name FROM ward_candidate WHERE name = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            
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

    if(empty(trim($_POST["party_id"]))){
        $user_id_err = "Please enter a party id number.";
    } else{
       
        $sql = "SELECT party_id FROM ward_candidate WHERE party_id = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $param_party_id);
            
            
            $param_user_id = trim($_POST["party_id"]);
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
               
                $party_id = trim($_POST["party_id"]);
                
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }

    if(empty(trim($_POST["ward_id"]))){
        $user_id_err = "Please enter a ward id number.";
    } else{
       
        $sql = "SELECT ward_id FROM ward_candidate WHERE ward_id = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $param_ward_id);
            
            
            $param_user_id = trim($_POST["ward_id"]);
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
               
                    $party_id = trim($_POST["ward_id"]);
                
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }

    
    
    if(empty($candidate_id) && empty($party_id_err) && empty($name_err) && empty($ward_id_err)){
        
       
        $sql = "INSERT INTO ward_candidate (candidate_id, party_id, name, ward_id) VALUES (?,?, ?, ?)";
         
        if($stmt = mysqli_prepare($link, $sql)){
            
            mysqli_stmt_bind_param($stmt, "ss", $param_candidate_id);
            
           
            $param_candidate_id = $candidate_id;
           
            
            if(mysqli_stmt_execute($stmt)){
                
                header("location: login.php");
            } else{
                echo "Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }
    }
    
    
    mysqli_close($link);
}
?>
 
