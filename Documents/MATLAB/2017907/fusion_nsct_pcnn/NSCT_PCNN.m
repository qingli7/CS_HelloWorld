clc;
clear all;
close all;
%%
pfilter = '9-7';
dfilter = 'pkva';
nlevels = [2,2,3,4]; 

im=imread('A.tif');
im1=imread('B.tif');
im=im2double(im);
im1=im2double(im1);

y1 = nsctdec(im, nlevels, dfilter, pfilter);
y2 = nsctdec(im1, nlevels, dfilter, pfilter);

%%
link_arrange=5;
iteration_times=20;
%%
y{1}=PCNN_large_arrange3(y1{1},y2{1},link_arrange,iteration_times);
for m1=1:4;
   y{2}{m1}=PCNN_large_arrange3(y1{2}{m1},y2{2}{m1},link_arrange,iteration_times);
end;
for m2=1:4;
   y{3}{m2}=PCNN_large_arrange3(y1{3}{m2},y2{3}{m2},link_arrange,iteration_times);
end;
for m3=1:8;
   y{4}{m3}=PCNN_large_arrange3(y1{4}{m3},y2{4}{m3},link_arrange,iteration_times);
end;
for m4=1:16;
   y{5}{m4}=PCNN_large_arrange3(y1{5}{m4},y2{5}{m4},link_arrange,iteration_times);
end;
F=nsctrec(y,dfilter, pfilter);
%%
figure,imshow(im,[]);
figure,imshow(im1,[]);
figure,imshow(F,[]);
%信息熵，越大，就表示图像融合的效果越好
y=entropy(F)
%平均梯度，越大，就表示图像融合的效果越好
AVEGRAD=avegrad(F)