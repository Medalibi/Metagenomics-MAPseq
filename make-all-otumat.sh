#!/bin/bash

awk -F '\t' '
/^>/ {
  f=FILENAME;
  gsub("^.*/","",f);
  gsub("\\..*$","",f);

  id=T "_" f;
  samples[id]=1;
  next;
}

{
  arr[id SUBSEP $1]=$2;
  otus[$1]=1;
}

END {
  str="";
  for (j in otus)
    str=str "\t" j;
  print "sampleid" str;
  for (i in samples) {
    str="";
    for (j in otus)
      str=str "\t" (i SUBSEP j in arr?arr[i SUBSEP j]:0);
    print i str;
  }
}' $*
