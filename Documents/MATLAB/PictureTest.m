clear, close all, clc

im = im2double(imread('bee.jpg'));
im = rgb2gray(im);
imsz = size(im);
x = imresize(im,[size(im,1)/4 size(im,2)/4]);  % x = original signal 
imagesc(x)
x_size = size(x);
x = x(:);

n = length(x);

%___MEASUREMENT MATRIX___
m = 250; % number of samples, NOTE: small error still present after increasing m to 1500;
Phi = randn(m,n); % Phi = i.i.d. Gaussian variables
Psi = idct(eye(n));

%___COMPRESSION___
y = Phi*x;   % y = compressed signal 
Theta = Phi*Psi;

%___
lambda = 12;
t = 1;
h= 0.0001;
d =h/t;
D = Theta;

u = zeros(size(D,2),1);
for i=1:1000
    a = (u-sign(u).*(lambda)).*(abs(u)>(lambda));
    u= u+d*(D'*(y-D*a)-u-a);
end
s3 = a;

%___l2 NORM SOLUTION___ s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;  % s = sparse coefficient vector(to be determined)

%___BP SOLUTION___
s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox

%___IMAGE RECONSTRUCTIONS___
x1 = Psi*s1;
x2 = Psi*s2;
x3 = Psi*s3;


figure('name','Compressive sensing image reconstructions')
subplot(1,4,1), imagesc(reshape(x,x_size)), xlabel('original'), axis image
subplot(1,4,2), imagesc(reshape(x2,x_size)), xlabel('least squares'), axis image
subplot(1,4,3), imagesc(reshape(x1,x_size)), xlabel('basis pursuit'), axis image
subplot(1,4,4), imagesc(reshape(x3,x_size)), xlabel('lca'), axis image
colormap gray
set(gcf,'color','w')