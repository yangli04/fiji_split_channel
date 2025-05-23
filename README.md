# fiji_split_channel

This is a short macro for Fiji to split the channels and create merged image in .lif file from immunofluorescence experiments. There are three default colors: Blue, Red and Green. Please modify that before you use the macro to make sure the sequences in `colors` variable is correct.

## How to use
1. Open Fiji software.
2. Clik "Plugins -> New -> Macro".
3. Paste the code from split_channel.ijm to the text editer opened by last step.
4. Motify the path and color if necessary. The default input file is "./Project.lif" and the default output path is "./"
5. Run the code by click "Run" or use command + r. 


All output files will be saved to the output directory as .tif files. 
