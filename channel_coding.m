function c=channel_coding(b,par_G,par_N_zeros,switch_off)

if switch_off==1          % channel coding is done
L=length(b);
N=L/4;                 % to use (7,4) hamming coding we are dividing data bits to 4 bits sequence 
b_new=reshape(b,4,N);     % Have to reshape b cause we have to multiply it with a 7*4 matrix 
                          % so we have to reshape b to 4*N matrix.b_new is a matrix of 7*N
c1=par_G*b_new;           % generating code matrix (encoding)
c2=mod(c1,2);             % making the output in binary form
 
N2=7*N;                   %length of sequence after coding
c_without_zeros=reshape(c2,N2,1);
           
c_add=zeros(par_N_zeros,1);
c=[c_without_zeros;c_add];
else                       %switch_off=0, no channel coding
    c_add=zeros(par_N_zeros,1);
    c=cat(1,b,c_add);      % concatinating input b and zero matrix in one column 
end
end
