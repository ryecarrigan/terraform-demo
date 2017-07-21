<?php
$hostname = $_ENV['BACKEND_HOST'];

echo file_get_contents("http://${hostname}");
