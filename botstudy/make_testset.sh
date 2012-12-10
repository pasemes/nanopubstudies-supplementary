#------------------------------------------------------------------------------
# This script generates the test set, i.e. the new GeneRIF entries of 26 Nov
# 2012 as compared to 20 Sep 2012.
#------------------------------------------------------------------------------

diff generifs_basic_2012-09-20 generifs_basic_2012-11-26 \
  | egrep "^> " \
  | sed 's/^> //' \
  > generifs_testing
