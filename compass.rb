require 'compass/import-once/activate'
require 'bootstrap-sass'
require 'font-awesome-sass'

sourcemap= (environment == :development)? true : false
sass_dir= "theme/scss"
images_dir= "theme/img"
css_dir= "theme/css"
fonts_dir= "theme/vendor"
generated_images_dir= "theme/img"

http_images_dir= "img"
http_fonts_dir= "vendor"
output_style = (environment == :development)? :nested : :compressed
line_comments = (environment == :development)? true : false

if(environment == :development)
  on_stylesheet_saved do |filename|
      File.rename(filename, "#{File.dirname(filename)}/#{File.basename(filename, ".*")}-dev.css")
  end
end