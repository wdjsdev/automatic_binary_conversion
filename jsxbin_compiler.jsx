#target estoolkit#dbg
function compileBinary()
{
	var batchFolder = new Folder("~/automatic_binary_conversion/convert_to_binary");
	var destFolder = new Folder("~/automatic_binary_conversion/binary_converted");

	var logFile = File("~/automatic_binary_conversion/bin_conversion_log.txt");
	var logTxt = "";

	function log(msg)
	{
		logTxt += msg + "\n\n";
	}
	function writeLog()
	{
		logFile.open("w");
		logFile.write(logTxt);
		logFile.close();
	}

	var files = batchFolder.getFiles();
	log("batch folder files:\n\t" + files.join("\n\t"));
	var compFiles;
	var contents,compiledString,outFile;

	var devPat = /_Dev\.js[x]?/;

	function compileAndWrite(file)
	{
		log("beginning of compileAndWrite(" + file.name + ")");

		if(file.name.indexOf(".DS")>-1)
		{
			log("found a .DS_Store file. skip it");
			return;
		}
		file.open("r");
		contents = file.read();
		file.close();

		log("contents of file: " + contents);
		compiledString = app.compile(contents);
		log("compiledString = " + compiledString);
		compiledString = compiledString.replace(/\s/g,"");
		compiledString = "eval(\"" + compiledString + "\")";
		log("after formatting:");
		log("compiledString = " + compiledString);

		if(devPat.test(file.name))
		{
			log("file is a dev file.")
			outFile = new File(destFolder + "/" + file.name.replace(devPat,".jsx"))
		}
		else
		{
			log("file is a component file");
			outFile = new File(destFolder + "/" + file.name.replace(/\.js/,".jsxbin") );
		}

		log("outFile = " + outFile.fullName);

		outFile.open("w");
		outFile.write(compiledString);
		outFile.close();
		
		log("wrote the data to outFile");
	}


	for(var x=0,len=files.length;x<len;x++)
	{
		compileAndWrite(files[x]);  
	}

	log("End of compiler script..");

	writeLog();
}
compileBinary();