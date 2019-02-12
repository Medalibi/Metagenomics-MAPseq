#!/bin/bash

if [ -z "$1" ]; then echo "missing argument"; exit -1; fi

fname=$1
fext=${fname##*.}

CATBIN=cat
if [ "$fext" = "gz" ]; then
  CATBIN=zcat
fi

$CATBIN $fname | awk -F '\t' '
BEGIN {
  FS="\t";
  starti=-1;
}

/^#/{next;}

{
  if (starti==-1){
    for (starti=0; $starti!=""; ++starti);
    ++starti;
    for (; $starti!=""; ++starti);
    ++starti;
  }
  tax="";
  ++totalseqs;
  for (i=starti; $i!="" && i<=NF; i+=3) {
    ttype=0;
    taxtype[ttype]=1;
    if ($(i+1)<0.5) break;
    j=(i-starti)/3;
    tax=tax ";" $i;
    if (!(ttype SUBSEP j SUBSEP tax in taxvals)){
      taxvals[ttype SUBSEP j]=taxvals[ttype SUBSEP j] SUBSEP tax;
      taxvals[ttype SUBSEP j SUBSEP tax]=1; 
    }
#    print tax,$(i+1);
    ++taxcount[ttype SUBSEP tax];
    ++totalseqscf[j];
  }
}
END {
  ttype=0;
  split(taxvals[ttype SUBSEP 3],a,SUBSEP);
  OFS="\t";
  print ">usersample",totalseqs,totalseqscf[2];
  sortcmd="sort -k 2rn,2 -t \"	\""
  for(i=1;i in a;i++)
    print substr(a[i],2),taxcount[ttype SUBSEP a[i]] | sortcmd; 
  close(sortcmd);
}'
