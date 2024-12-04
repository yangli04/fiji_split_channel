// Define the input .lif file and output folder
// inputFile = File.openDialog("Choose .lif File");
// outputDir = getDirectory("Choose Output Directory");
inputFile = "Project.lif";
outputDir = "./";


// Load the .lif file using Bio-Formats without splitting channels during import
run("Bio-Formats Importer", "open=[" + inputFile + "] open_all_series color_mode=Colorized view=Hyperstack");
// Load only one of the series: 
//run("Bio-Formats Importer", "open=[" + inputFile + "] color_mode=Colorized view=Hyperstack");

imageTitles = getList("image.titles");
numImages = lengthOf(imageTitles);
print("Number of Images:", numImages);

for (i = 0; i < numImages; i++) {
    imageName = imageTitles[i];
    print(imageName);
    selectWindow(imageName);
    imageTitle = getTitle();

    run("Split Channels");

    close(imageName);

    allImageTitles = getList("image.titles");
    numAllImages = lengthOf(allImageTitles);

    colors = newArray("Blue", "Green", "Red"); 
    numChannels = lengthOf(colors);

    channelTitles = Array.slice(allImageTitles, numAllImages - numChannels, numAllImages);

    coloredChannelTitles = newArray();

		for (j = 0; j < numChannels; j++) {
		    selectWindow(channelTitles[j]);
		    run("Grays"); 

		    // Apply the color LUT
		    run(colors[j] + "");
		    // DO NOT convert to RGB here
		    // Save the colored channel image with LUT applied (still grayscale)
		    channelTitle = imageTitle + "_channel" + (j+1) + "_" + colors[j] + ".tif";
		    saveAs("Tiff", outputDir + channelTitle);
		    coloredChannelTitles = Array.concat(coloredChannelTitles, getTitle());
		}
		
		mergeCommand = "";
		for (k = 0; k < numChannels; k++) {
		    mergeCommand += " c" + (k+1) + "=[" + coloredChannelTitles[k] + "]";
		}
		mergeCommand += " create";
		
		run("Merge Channels...", mergeCommand);
		overlayTitle = getTitle();
		selectWindow(overlayTitle);
		run("RGB Color");
		saveAs("Tiff", outputDir + imageTitle + "_overlay.tif");
		close(overlayTitle);
}
run("Close All");
