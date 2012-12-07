#------------------------------------------------------------------------------
# This script preprocesses the GeneRIF file. First, a symbolic link to the
# input file has to be created, e.g:
# 
#     $ ln -s generifs_basic generifs_input
#
#------------------------------------------------------------------------------

cat generifs_input \
  | grep -ve "^#" \
  | sed 's/|/\//g' \
  | sed 's/^\([0-9]*\)\s*\([0-9]*\)\s*\([0-9,]*\)\s*\([0-9\-]* [0-9:]*\)\s\(.*\)\s*$/\1|\2|\3|\4|\5/' \
  | sed 's/\s*\[.*\]\s*$//g' \
  | awk ' { i++; print i"|"$0 } ' \
  > generifs_preprocessed

