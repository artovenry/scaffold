<?
define('ART_ENV', 'Development');

require TEMPLATEPATH . "/vendor/autoload.php";

define('ART_VIEW', TEMPLATEPATH . '/view');
define('ART_VERSION_YAML', TEMPLATEPATH . '/version.yml');

Artovenry\Wp\Version::run();
Artovenry\Wp\Helpers::run();
Artovenry\Haml::run();


remove_buildin_scripts();

add_theme_support( 'title-tag' );
if(ART_ENV !== "production"){
  add_action('init', function(){
    add_filter("redirect_canonical", function(){return false;});
  });
}
if(!is_page("contact")){
  remove_action( 'wp_enqueue_scripts', 'wpcf7_do_enqueue_scripts' );
}
