require 'compass/import-once/activate'
require 'bootstrap-sass'
require 'font-awesome-sass'

sourcemap= false
sass_dir= "src/scss"
images_dir= "src/scss/img"
css_dir= "theme/assets/css"
fonts_dir= "theme/assets/vendor"
generated_images_dir= "theme/assets/css/img"
ASSET_HOST= "example.com:30000"
#DEVELOPMENT
asset_host= proc { |source|  ASSET_HOST}
http_images_dir= "wp-content/themes/theme/assets/css/img"
http_fonts_dir= "wp-content/themes/theme/assets/vendor"


#PRODUCTION
#http_path= "./"
#http_images_dir= "img"

output_style = :nested
line_comments =  true
