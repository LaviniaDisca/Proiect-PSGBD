<?php
require_once 'app/core/App.php';
require_once 'app/core/Controller.php';
require_once 'app/core/Model.php';
/**
 * Configuration for: Error reporting
 * Useful to show every little problem during development, but only show hard errors in production
 */
error_reporting(E_ALL);
ini_set("display_errors", 1);
/**
 * Configuration for: Project URL
 * Put your URL here, for local development "127.0.0.1" or "localhost" (plus sub-folder) is fine
 */
define('URL', 'http://localhost/PSGBD/');
/**
 * Configuration for: Database
 * This is the place where you define your database credentials, database type etc.
 */
define('DB_USER', "admin");
define('DB_PASS', "ADMIN");
define('DB_NAME', "localhost/XE");