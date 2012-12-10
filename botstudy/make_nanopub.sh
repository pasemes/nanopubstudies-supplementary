#------------------------------------------------------------------------------
# This script generates a nanopublication for a sentence extracted from a
# GeneRIF record. It is called by make_nanopubs.sh and should not be executed
# directly.
#------------------------------------------------------------------------------

enc="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' -- "$6")"
enc=`echo "$enc" | sed s/%20/+/g`
id=`printf "GeneRIF%06d" $1`

mkdir -p nanopub-files

cat generif.template.trig \
  | sed "s/@NPID@/$id/g" \
  | sed 's/@DATETIME@/2012-11-28T15:23:00/g' \
  | sed "s/@SENTENCE@/$enc/g" \
  | sed "s/@TAXON@/$2/g" \
  | sed "s/@GENE@/$3/g" \
  | sed "s/@PMID@/$4/g" \
  > nanopub-files/$id.trig
