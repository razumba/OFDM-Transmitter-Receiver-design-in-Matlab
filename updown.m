% clc
% x = [ 4 9 3 4 5 6 7 8 9 10 11 12]
% k = input('Enter downsampling factor = ');
% z=[];
% for i=1:length(x)-1
% m=(x(i+1)-x(i))/k;
% for j=1:k-1
% y(1,j)=x(i)+j*m;
% end
% z=[z x(i) y];
% end
% upsampling1=[z x(length(x))]
% downsampling1= upsampling1(1:k:length(upsampling1));

x = [ 9 2 3 4 5 6 7 8 9 10 11 12]
k = input('Enter downsampling factor = ');
x1=[];
x2=[];
for i=1:length(x)
    x1=[x(i) zeros(1,k-1)];
    x2= [x2 x1];
end
x2