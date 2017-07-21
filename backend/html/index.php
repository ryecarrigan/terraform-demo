<?php
$hostname   = $_ENV['POSTGRES_HOST'];
$database   = $_ENV['POSTGRES_DB'];
$username   = $_ENV['POSTGRES_USER'];
$password   = $_ENV['POSTGRES_PASSWORD'];
$connection = new PDO("pgsql:host=${hostname};dbname=${database}", $username, $password);

echo $connection->getAttribute(PDO::ATTR_CONNECTION_STATUS);
