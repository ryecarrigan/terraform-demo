<?php
$hostname = $_ENV['BACKEND_HOST'];

echo http_get($hostname);
