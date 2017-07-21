<?php
$hostname = $_ENV['BACKEND_HOST'];

echo "<input type=\"button\" onlick=\"location.href='http://${hostname}';\" value=\"Check Backend\" />";
