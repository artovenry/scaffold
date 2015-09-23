<?
require "php/vendor/autoload.php";

define("ART_ENV", "development");
define("ART_VIEW", __DIR__ . "/view");

Artovenry\Haml::run();
