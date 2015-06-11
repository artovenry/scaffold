require 'compass/import-once/activate'
require 'bootstrap-sass'
require 'font-awesome-sass'

sourcemap= true
sass_dir= "src/scss"
css_dir= "public/css"

images_dir= "src/img"
http_images_dir= "img"
fonts_dir= "public/vendor/fonts"
http_fonts_dir= "vendor/fonts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:

# FOR DEVELOPING
line_comments = true


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass
