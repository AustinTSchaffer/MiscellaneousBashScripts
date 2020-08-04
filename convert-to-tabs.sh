FILE_EXTENSION=.py
CURRENT_TAB_WIDTH=4

# Keep running this until nothing changes
find -name "*$FILE_EXTENSION" | xargs sed -i -E "s/^(\\s*) {$CURRENT_TAB_WIDTH}/\\1\\t/g"
