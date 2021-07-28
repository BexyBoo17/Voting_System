<?php

session_start();

 require_once "config.php";




if
if($_POST['submit']=='Change')
{
    $err = array();
    if(!$_POST['physical_address'] || !$_POST['physical_address_new'])
        $err[] = 'All the fields must be filled in!';

    if(!count($err))
    {
        $_POST['physical_address'] = mysql_real_escape_string($_POST['physical_address']);
        $_POST['physical_address_new'] = mysql_real_escape_string($_POST['physical_address_new']);
        $row = mysql_fetch_assoc(mysql_query("SELECT voter_id_number,first_name FROM voter WHERE voter_id_number='{$_SESSION['username']}' AND physical_address='".md5($_POST['physical_address'])."'"));
        
        if($row['username'])
    {
        $querynewpass = "UPDATE voter SET physical_address='".md5($_POST['physical_address_new'])."' WHERE voter_id_number='{$_SESSION['username']}'";
        $result = mysql_query($querynewpass) or die(mysql_error());
        $_SESSION['msg']['addresschange-success']='* You have successfully changed your password!';
    }
        else $err[]='Wrong address!';
    }
    if($err)
    $_SESSION['msg']['addresschange-err'] = implode('<br />',$err);
    header("Location: login.php?id=" . $_SESSION['username']);
    exit;
}