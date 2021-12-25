<?php
require('functions.php');
require('headers.php');

try {
    $db = openDB();
    selectAsJson($db, "SELECT * FROM Tarantino_movies");

    // SQL Lauseke Viewin luomiseen löytyy sql_lausekkeet.sql tiedostosta
}catch(PDOException $e){
    echo "Error: " . $e->getMessage();
}