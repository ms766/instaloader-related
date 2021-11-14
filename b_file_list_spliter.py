#!/usr/bin/env python3
import os, sys, os.path

#check for a cmarg of 1 / check if file exists
#incoming file that is broke into a list - the last index because its blank;
#note that the file is closed after the data is read in!
if (len(sys.argv) > 1):
    if (os.path.exists(sys.argv[1]) == True):
        f = open(sys.argv[1])
        global incoming_file
        incoming_file = f.read().split("\n")[:-1];f.close()



def chunks(inList,splitNum):
    count = 0
    for i in range(0,len(inList),splitNum):
        count += 1
        f = open("glistSplit{}.txt".format(count),"w")
        for word in inList[i:i+splitNum]:
            f.write(word+"\n")
    f.close()
chunks(incoming_file,len(incoming_file)//4)
