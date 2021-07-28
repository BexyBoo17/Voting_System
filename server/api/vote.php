<?php

require_once "config.php";

    session_start();

    $voted = FALSE;
    if(isset($_SESSION["voted"])){
        $voted = $_SESSION["voted"];
    }else{
        $voted = TRUE;
    }
   

    function recordWard($candidateId, $conne){
        $sql  = "INSERT INTO vote_ward(vote_id, candidate_id) VALUES(?,?);";

        if($stmt = mysqli_prepare($conne, $sql)){
            $id = $candidateId;
            
            mysqli_stmt_bind_param($stmt, "ss", rand(0, 1000000), $id);        
            if(mysqli_stmt_execute($stmt)){
    
            } else{
                echo "Oops! Something went wrong. Please try again later.".$stmt->error;
            }

            
            mysqli_stmt_close($stmt);
        }

        return null;
    }

    function recordLocal($localId, $partyId, $conne){
        $sql  = "INSERT INTO vote_local_municipality(vote_id, local_muni_id, party_id) VALUES(?,?,?);";

        if($stmt = mysqli_prepare($conne, $sql)){
            
            mysqli_stmt_bind_param($stmt, "sss", rand(0, 1000000), $localId, $partyId);        
            if(mysqli_stmt_execute($stmt)){
    
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }

        return null;
    }


    function recordDistrict($upper_id, $partyId, $conne){
        $sql  = "INSERT INTO vote_local_municipality(vote_id, party_party_id, upper_municipality_upper_muni_id) VALUES(?,?,?);";

        if($stmt = mysqli_prepare($conne, $sql)){
            
            mysqli_stmt_bind_param($stmt, "sss", rand(0, 1000000), $partyId, $upper_id);        
            if(mysqli_stmt_execute($stmt)){
    
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            
            mysqli_stmt_close($stmt);
        }

        return null;
    }

    function updateVoter($voterIdNumber, $conne){
        $sql = "UPDATE voter SET voted=1 WHERE voter_id_number= ?";

 
        if($stmt = mysqli_prepare($conne, $sql)){
            
            mysqli_stmt_bind_param($stmt, "s", $voterIdNumber);        
            if(mysqli_stmt_execute($stmt)){
    
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }            
            mysqli_stmt_close($stmt);
        }

        return null;
    }

    if(!$voted){
        if($_SERVER["REQUEST_METHOD"] == "POST"){
            $error = FALSE;

     
            if(isset($_POST["vote-ward"])){
                $candidateId = trim($_POST["vote-ward"]);
            }else{
                $error = TRUE;
            }
    
            if(isset($_POST["vote-local-id"])){
                $idLocal = trim($_POST["vote-local-id"]);
                $idPartyLocal = trim($_POST["vote-local-party"]);
            }else{
                $error = TRUE;
            }
    
            if(isset($_POST["vote-district-id"])){
                $idDistrict  = trim($_POST["vote-district-id"]);
                $idDistrictParty  = trim($_POST["vote-district-party"]);
            }else{
                $idDistrict = null;
                $idDistrictParty = null;
            }
    
    
            if(error){
                 recordWard($candidateId, $conn);
                recordLocal($idLocal, $idPartyLocal, $conn);
                $valid = $_SESSION["from_district"];
    
                if($valid && $idDistrict){
                    recordDistrict($idDistrict, $idDistrictParty, $conn);
                }

                updateVoter($_SESSION["voter_id_number"], $conn);    
            }

            $_SESSION["voted"] = TRUE;
        }
    }





?>