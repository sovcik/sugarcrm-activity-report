#!/bin/sh
echo "Copying files from source to build folder..."
cp source/* build/

echo "Calculating MD5 hash..."
mfiles=`ls -1 source/*`
for file in $mfiles; do
  md5h=`md5sum $file`
  echo "  > ${file##*/}"
  sed -i -e "/${file##*/}/s|=>.*$|=> \'${md5h:0:32}\',|" build/ActivitiesReports_files.md5 
done

echo "Creating package..."
pkg="SugarCRM_6.x.x_Activities-Reports.zip"
pushd build
zip ../$pkg *
popd

echo "Cleaning up...."
rm -R build/*

echo "Package $pkg created."

