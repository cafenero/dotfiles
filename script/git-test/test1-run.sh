#!/bin/bash -x


rm -rf git-test

mkdir git-test
cd git-test
git init

echo init > README.md
git add README.md
git commit -m "initial commit"


#
git co -b 1-br
echo 1 hoge >> README.md
git commit -am "1 hoge"

echo 2 hoge >> README.md
git commit -am "2 hoge"

echo 3 hoge >> README.md
git commit -am "3 hoge"


#
git co master

echo 4 >> file.txt
git add file.txt
git commit -am "4 file"

echo 5 >> file.txt
git commit -am "5 file"

echo 6 >> file.txt
git commit -am "6 file"

echo 7 >> file.txt
git commit -am "7 file"



# tig --all

# git co 1-br
# git rebase master
# git co master

# tig --all

# echo 8 >> file.txt
# git commit -am "8 file"

# tig --all

# git co 1-br
# git rebase master
# git co master

# tig --all


# git merge 1-br
# or
# git merge -m "message" --no-ff 1-br


# tig --all

# git br -d 1-br

# tig --all
