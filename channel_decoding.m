function [counter,b_hat]=channel_decoding(c_hat,par_H,par_N_zeros,switch_off,i)
persistent count;
if i==1
    count = [];
end
ctr1=0;
ctr2=0;
ctr3=0;
ctr4=0;
ctr5=0;
ctr6=0;
ctr7=0;
if switch_off==1
    
L=length(c_hat);
M=L/7;
b1=reshape(c_hat,7,M);
E=par_H*b1;% syndrome (parity* codeword)
E1=mod(E,2);% syndrome should be in 0s& 1s so we are using mod
[m,n]=size(E1); 


a=0;
% correction of one bit error
for i=1:n
    
    if E1(:,i)==par_H(:,1) 
        c_hat(1+a)=xor(c_hat(1+a),1);
        ctr1=ctr1+1;
    elseif E1(:,i)==par_H(:,2) 
        c_hat(2+a)=xor(c_hat(2+a),1);  
        ctr2=ctr2+1;
     elseif E1(:,i)==par_H(:,3) 
        c_hat(3+a)=xor(c_hat(3+a),1);   
      ctr3=ctr3+1;
        elseif E1(:,i)==par_H(:,4) 
        c_hat(4+a)=xor(c_hat(4+a),1);
        ctr4=ctr4+1;
        elseif E1(:,i)==par_H(:,5) 
        c_hat(5+a)=xor(c_hat(5+a),1);
        ctr5=ctr5+1;
        elseif E1(:,i)==par_H(:,6) 
        c_hat(6+a)=xor(c_hat(6+a),1);
        ctr6=ctr6+1;
        elseif E1(:,i)==par_H(:,7) 
        c_hat(7+a)=xor(c_hat(7+a),1);
        ctr7=ctr7+1;
    end
    a=a+7;
end
Decoder=[0 0 1 0 0 0 0;0 0 0 0 1 0 0;0 0 0 0 0 1 0;0 0 0 0 0 0 1];
b=1;
for j=1:7:L
    b_hat(b:b+3,1)=Decoder*c_hat(j:j+6,1);
    b=b+4;
end
b=b(1:length(b)-par_N_zeros,1);%delete added zeros
else 
    b_hat=c_hat;
end
count = [count;[ctr1 ctr2 ctr3 ctr4 ctr5 ctr6 ctr7]];
counter = count;
end