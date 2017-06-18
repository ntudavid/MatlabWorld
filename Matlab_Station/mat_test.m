

mat = [1 2; 3 4]
test(mat).check
mat

function [ check mat ]= test(mat)
    check = 1;
    mat = mat*2;
end