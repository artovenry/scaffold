require 'compass/import-once/activate'
require 'bootstrap-sass'
require 'font-awesome-sass'

sourcemap= true 
sass_dir= "src/scss"
images_dir= "src/scss/img"
css_dir= "theme/assets/css"
fonts_dir= "theme/assets/vendor"
generated_images_dir= "theme/assets/css/img"

#FIXME
http_images_dir= "wp-content/themes/theme/theme/css/img"
#FIXME
http_fonts_dir= "wp-content/themes/theme/theme/vendor"

output_style = :nested
line_comments =  true

on_stylesheet_saved do |filename|
    File.rename(filename, "#{File.dirname(filename)}/#{File.basename(filename, ".*")}-dev.css")
end
