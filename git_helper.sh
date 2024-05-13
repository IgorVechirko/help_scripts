#!/bin/bash

#unstage file. Doesn't revert changes but just move stage file to unstage area
git restore --staged file-to-unstage.txt

#remove remote branch
git push origin -d branch_name
