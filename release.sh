#!/bin/bash
###
 # @Author: Vincent Young
 # @Date: 2023-03-05 20:29:43
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-04-10 03:31:01
 # @FilePath: /bob-plugin-deeplx/release.sh
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 
version=${1#refs/tags/v}
zip -r -j bob-plugin-deeplx-$version.bobplugin src/*

sha256_deeplx=$(sha256sum bob-plugin-deeplx-$version.bobplugin | cut -d ' ' -f 1)
echo $sha256_deeplx

download_link="https://github.com/char8x/bob-plugin-deeplx/releases/download/v$version/bob-plugin-deeplx-$version.bobplugin"

new_version="{\"version\": \"$version\", \"desc\": \"Fix some prompt errors.\", \"sha256\": \"$sha256_deeplx\", \"url\": \"$download_link\", \"minBobVersion\": \"0.5.0\"}"

json_file='appcast.json'
json_data=$(cat $json_file)

updated_json=$(echo $json_data | jq --argjson new_version "$new_version" '.versions += [$new_version]')

echo $updated_json > $json_file
mkdir dist
mv *.bobplugin dist
