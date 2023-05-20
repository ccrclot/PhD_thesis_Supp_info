// Suplementary File 1: ImageJ macro pollen diameter extraction derived from Tello et al. (2018) 
// Function parameters
dirIn = "Choose tiff image input directory "
dirOut = "Choose data output directory"
dirOutPng = "Choose png output image directory"

// Function
function pollen(dirIn, dirOut, dirOutTif, fileName) {
open(dirIn + fileName);
run("Split Channels");
selectWindow(fileName + " (green)");
run("Subtract Background...", "rolling=50 light sliding");
setAutoThreshold("Default");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Close-");
run("Watershed");
run("Analyze Particles...", "size=200-1000 circularity=0.7-1.00 show=[Overlay Masks] display exclude add in_situ clear include summarize"); // to be adapted to your data
saveAs("png", dirOutPng + fileName + "_(green).png");
selectWindow ("Results");
saveAs("results", dirOut + fileName + ".csv");
run("Close All");
}

//Set scale and measurements;
open("Path to scale reference image")
run("Set Scale...", "distance=100 known=55 pixel=1 unit=μm global"); // to be adapted to your scale
run("Set Measurements...", "area perimeter shape feret's redirect=None decimal=3");
close();

//Run function
setBatchMode(true);
list = getFileList(dirIn);
for (i = 0; i < list.length; i++)
{
if (endsWith(list[i], ".tiff"))
pollen(dirIn, dirOut, dirOutTif, list[i]);}
run("Close All");
setBatchMode(false);