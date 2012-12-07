#------------------------------------------------------------------------------
# This script extracts GeneRIFs with AIDA-compliant sentences. Run
# preprocess.sh before running this script.
#------------------------------------------------------------------------------

INIT='\|(here|taken together|together|collectively|altogether|taken collectively|all|therefore|thus|in conclusion|however)?,?'
SUBJ='(the|these|this|our)? ?(present|further)? ?(it|we|this|data|results?|findings?|study|studies|reviews?|authors?|observations?|experiments?|publications?|papers?|analysis|analyses|evidence|research|assays?|manuscripts?|work)? ?((of|from|in) (the|this|these|our) (present)? ?(study?(ies)?|work))? ?((presented|shown)( here)?|herein)?'
COP='(is|are|was|have|has|(can|should|must|could|may) be)?'
ADV='(strongly|clearly|collectively|thus|therefore|taken together|further|unambiguously|also)?'
VERB='(suggests?(ed)?|shows?n?(ed)?|indicates?d?|demoni?strates?d?|illustrates?d?|describes?d?|concludes?d?|reports?(ed)?|proposes?d?|provides?d?|supports?(ed)?|summariz?s?es?d?|reveals?(ed)?|postulates?d?|finds?|found|demonstrates?d?|confirms?(ed)?|establishe?s?d?|imply?(ie)?s?d?|implicates?d?|documents?(ed)?|presents?(ed)?|hypothesizes?d?|argues?d?|appears|proves?d?|identify?(ie)?s?d?|evidences?d?|believes?d?|substantiates?d?|observes?d?|determines?d?|emphasizes?d?|highlights(ed)?)?'
ADJ='(conceivable|possible|consistent with)?'
OBJ='(the|our)? ?(first|novel|new|conclusive|convincing)? ?(data|demonstration|report|study|evidence|model|conclusion|hypothesis|notion|idea|possibility|contention|view)?'
MOD='(here|for the first time)?'

STARTPATTERN="$INIT ?$SUBJ ?$COP ?$ADV ?$VERB ?$ADV ?$ADJ ?$OBJ ?$MOD ?that,? "

NOT_ATOMIC='; |: |\.  |, wh| and that| and also| but | while |however|whereas|on the other hand|in addition to|respectively|as well as|, and |thereby|though | thus,? | hence | therefore | yet | including | in contrast| contrary to | \(ii\) '
NOT_ATOMIC_CS='\. [A-Z]'
NOT_INDEPENDENT=' we | our | author| this ([^ ]+ )?(protein|gene|enzyme|subunit|peptide|species|organism|work)'
NOT_DECLARATIVE='\? |[^.]$'
NOT_ABSOLUTE='probabl|perhaps|potential|putative|maybe|plausible|possibl|likely|clearly|known|presumably|surprising| may,? | might,? | could,? | seem| appears? to | suggest| indicat| identif| determin| describ| emphasi| evaluat| interpret| discuss| conclu| show| confirm| was,? | were,? | had,? | have been,? | has been,? | did,? |ed the |ed a |ed no | result| data | finding| insight| evidence| stud| experiment| paper| observ| simulation| model| cohort| specification| illustrat| discover| presented| report| assay| highlight| identif| review| summar| understand| propos| hypothes| notion |statistic| characteri| qualif| analy| novel | new '
NEGPATTERN="$NOT_ATOMIC|$NOT_INDEPENDENT|$NOT_DECLARATIVE|$NOT_ABSOLUTE"
NEGPATTERN_CS="$NOT_ATOMIC_CS"

CAPITALIZE_FIRST='s/|\([a-z]\)\([a-z]*[ -\/,.;]\)/|\U\1\E\2/'

cat generifs_preprocessed \
  | egrep -i "$STARTPATTERN" \
  | perl -pe 's/\|([^|]*? )?that (.*)$/\|\2/i' \
  | egrep -vi "$NEGPATTERN" \
  | egrep -v "$NEGPATTERN_CS" \
  | sed 's/|\s*/|/g' \
  | sed "$CAPITALIZE_FIRST" \
  > generifs_extracted_1

cat generifs_preprocessed \
  | egrep -vi "$STARTPATTERN" \
  | sed 's/|\([^|]*\)$/| \1/' \
  | egrep -vi "$NEGPATTERN" \
  | egrep -v "$NEGPATTERN_CS" \
  | sed 's/|\s*/|/g' \
  | sed "$CAPITALIZE_FIRST" \
  > generifs_extracted_2

