#!/bin/bash

git branch -r | grep dev.ha. | xargs -n1 git log -n1 --first-parent --pretty=format:%d","%cs | xargs -n1 echo  > branches.txt

sort -t ',' -k 2,2 -r branches.txt

