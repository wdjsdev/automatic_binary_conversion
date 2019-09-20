projectToBinary()
{	
	#jsx to jsxbin compiler script
	compiler="~/automatic_binary_conversion/jsxbin_compiler.jsx"

	projectFolder=${PWD} &&
	mainScript=$projectFolder/*Dev.js* &&
	components=$projectFolder/components &&

	#make sure that there's a bin_comp folder in 
	#the project folder
	if [ ! -d "bin_comp" ]; then
		mkdir $projectFolder/bin_comp
		echo "made a bin_comp folder"
	fi
	binComp=$projectFolder/bin_comp

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
	echo "copied mainScript"

	cp $components/*.js $filesToConvert &&
	echo "copied components"

	osascript -e 'quit app "ExtendScript Toolkit"'

	/Volumes/Macintosh\ HD/Applications/Adobe\ ExtendScript\ Toolkit\ CC/ExtendScript\ Toolkit.app/Contents/MacOs/ExtendScript\ Toolkit -cmd $compiler >/dev/null 2>&1 &&

	mv $convertedFiles/*.jsx $projectFolder &&
	echo "Moved $(basename $projectFolder/*.jsx) binary file to project folder."

	mv $convertedFiles/*.jsxbin $binComp &&
	echo "Moved binary components to bin_comp"

	rm $filesToConvert/* &&
	echo "Successfully created binary files."
}