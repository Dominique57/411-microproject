#!/usr/bin/octave -qf
rows = @(x) size(x,1); 
cols = @(x) size(x,2);

M = [-3, 3 ; 5, -5];

if (rows(M) != cols(M))
    quit()
endif

Mdim = rows(M);
Melem = Mdim*Mdim;

start = 0;
count = 100;
step = 0.01;
x = [];
L = zeros(Melem,count);

for i = start:count
    x = [x, step * i];
    Mat = expm(M*(step*i));
    for j = 1:Melem
        coordi = 1 + idivide(int8(j-1), int8(Mdim), "fix");
        coordj = 1 + mod(j-1, Mdim);
        val = Mat(coordi, coordj);
        L(j, 1+i-start) = val;
    endfor
endfor



colors = ["b", "r", "g", "k", "m"];
hf = figure ();
hold on;
xlabel ("x-value");
ylabel ("y-value");
title ("Matrix exponential of given matrix");
for i = 1:Melem
    plot(x, L(i,:), colors(1 + idivide(int8(i-1), int8(Mdim), "fix")));
endfor


print uproj1.jpg
print uproj1.pdf