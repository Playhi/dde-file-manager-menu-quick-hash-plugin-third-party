#!/bin/bash

checkFileOrDir(){
    if [ -d $1 ]
    then
        for file in $1/*
        do
            checkFileOrDir $file
        done
    else
        filePaths[`expr ${#filePaths[*]} + 1`]=$1
    fi
}

# 跳过第一个用来设置模式的参数
jumpFirst=0

for item in $@
do
    if [ $jumpFirst -eq 0 ]
    then
        jumpFirst=1
    else
        checkFileOrDir $item
    fi
done

MODE=$1

case $MODE in
    "MD5")  md5sum ${filePaths[*]}
    ;;
    "SHA256")  sha256sum ${filePaths[*]}
    ;;
    "SHA1")  sha1sum ${filePaths[*]}
    ;;
    "SHA512")  sha512sum ${filePaths[*]}
    ;;
    "SHA224")  sha224sum ${filePaths[*]}
    ;;
    "SHA384")  sha384sum ${filePaths[*]}
    ;;
    "BLAKE2")  b2sum ${filePaths[*]}
    ;;
    "CRC")  cksum ${filePaths[*]}
    ;;
esac
