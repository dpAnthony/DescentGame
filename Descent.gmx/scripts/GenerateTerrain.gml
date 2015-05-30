//text file
var file

//strings
var fileName;

//counters
var line, row, col, layerNum;

//arrays
var currentLevel, layer, pane;

//layer is an array of panes
//pane is an array of lines

fileName = argument0;

for (i = 0; i < 125; i++) {
    pane[i] = ""
}

file = file_text_open_read(working_directory+"\levels\"+fileName);


for (row = 0; row < 120; row++) {
    for (col = 0; col < 200; col++) {
    
        var str = string(file_text_read_string(file));
       
        if (str != "-") {
            pane[row] = string(pane[row]) + str
        } else {
            file_text_readln(file);
        }
    }
    show_debug_message("Pane " + string(row) + ": " + string(pane[row]))
    file_text_readln(file);
}



//there are 6 layers per currentLevel
for (layerNum = 0; layerNum < 6; layerNum++) {

}

file_text_close(file)
file_delete(file)




//read terrain file

//fill terrain array

//generate terrain blocks according to array
