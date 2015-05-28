
var str = "Projection#";

var a = matrix_get(matrix_projection);
for(var i=0; i< array_length_1d(a); i++){
    str+=string_format(a[i],6,8)+"  " 
    if((i+1)%4 == 0) str+="#"
}

str+="##View#";

var a = matrix_get(matrix_view);
for(var i=0; i< array_length_1d(a); i++){
    str+=string_format(a[i],6,8)+"  " 
    if((i+1)%4 == 0) str+="#"
}

show_message(str);