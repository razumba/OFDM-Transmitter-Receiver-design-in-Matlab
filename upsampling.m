z=[1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9];
z1=[];
for i=1:length(z)-1
m=(z(i+1)-z(i))/2;
for j=1:2-1
y(1,j)=z(i)+j*m;
end
z1=[z1 z(i) y];
end
z_oversampled=[z1 z(length(z))];
size(z_oversampled)