#function for converting a single file to binary instead
#of a whole project (like the evalBin function)

if [[ -z "$1" ]];then
	echo "please call out a file for conversion"
	return
fi

#jsx to jsxbin compiler script
compiler=~/automatic_binary_conversion/jsxbin_compiler.jsx

projectFolder=${PWD} &&
mainScript=$projectFolder/$1 &&

#make sure there's a convert_to_binary folder
if [ ! -d ~/automatic_binary_conversion/convert_to_binary ]; then
	mkdir ~/automatic_binary_conversion/convert_to_binary
	echo "made a convert_to_binary folder"
fi
convertedFiles=~/automatic_binary_conversion/binary_converted &&

#make sure there's a binary_converted folder
if [ ! -d ~/automatic_binary_conversion/binary_converted ]; then
	mkdir ~/automatic_binary_conversion/binary_converted
	echo "made a binary_converted folder"
fi
filesToConvert=~/automatic_binary_conversion/convert_to_binary

cp $mainScript $filesToConvert &&
echo "copied $mainScript"

echo "the following files have been copied to filesToConvert"
ls $filesToConvert

osascript -e 'quit app "ExtendScript Toolkit"'

#it's not an error if i don't get a message about it.
/Volumes/Macintosh\ HD/Applications/Adobe\ ExtendScript\ Toolkit\ CC/ExtendScript\ Toolkit.app/Contents/MacOs/ExtendScript\ Toolkit -cmd $compiler >/dev/null 2>&1 &&

#noisy version..
# /Volumes/Macintosh\ HD/Applications/Adobe\ ExtendScript\ Toolkit\ CC/ExtendScript\ Toolkit.app/Contents/MacOs/ExtendScript\ Toolkit -cmd $compiler &&

mv $convertedFiles/*.jsx* $projectFolder &&

rm $filesToConvert/* &&
echo "Successfully created binary files."

