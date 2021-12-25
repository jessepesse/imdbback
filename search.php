<?php
require('functions.php');
require('headers.php');

//Näyttelijä haku
$input = json_decode(file_get_contents('php://input'));

$uri = parse_url(filter_input(INPUT_SERVER, 'PATH_INFO'),PHP_URL_PATH);

$parameters = explode('/', $uri);
$phrase = $parameters[1];

// Palauttaa haetut näyttelijät fronttiin
try {
    $db = openDB();
    $sql = "CALL SearchActors('$phrase')";
    selectAsJson($db, $sql);
    
}
catch (PDOException $pdoex) {
    returnError($pdoex);
}