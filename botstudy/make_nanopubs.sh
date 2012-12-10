#------------------------------------------------------------------------------
# This script generates nanopublications for sentences extracted from GeneRIF.
# It reads the extracted sentences from standard input, for example:
#
#     $ head -100 generifs_extracted | ./make_nanopubs.sh
#
# The resulting files are placed in a subdirectory called 'nanopub-files'.
#------------------------------------------------------------------------------

sed 's/\\/\\\\/g' \
  | sed 's/"/\\"/g' \
  | awk -F '|' '{
    print "./make_nanopub.sh "$1" "$2" "$3" "$4" \""$5"\" \""$6"\"";
  }' \
  | bash
