require 'compass/import-once/activate'
require 'bootstrap-sass'
require 'font-awesome-sass'

sourcemap= (environment == :development)? true : false
sass_dir= "src/scss"
images_dir= "theme/scss/img"
css_dir= "theme/css"
fonts_dir= "theme/vendor"
generated_images_dir= "theme/css/img"

#YOU MUST CHANGE THIS
if(environment == :development){
  http_images_dir= "wp-content/themes/theme/theme/css/img"
  http_fonts_dir= "wp-content/themes/theme/theme/vendor"
}

#YOU MUST CHANGE THIS
if(environment == :production){
  http_images_dir= "wp-content/themes/theme/theme/css/img"
  http_fonts_dir= "wp-content/themes/theme/theme/vendor"
}

output_style = (environment == :development)? :nested : :compressed
line_comments = (environment == :development)? true : false

if(environment == :development)
  on_stylesheet_saved do |filename|
      File.rename(filename, "#{File.dirname(filename)}/#{File.basename(filename, ".*")}-dev.css")
  end
end