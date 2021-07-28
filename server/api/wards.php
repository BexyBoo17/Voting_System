<?php

require_once "config.php";

$query = 'SELECT * FROM ward';

$result = mysqli_query($conn, $query );

$stack = array();
if($result){
    while( $row = mysqli_fetch_array($result, MYSQLI_ASSOC ) ) {
        array_push( $stack, $row );
    }
}

echo json_encode($stack);

?>