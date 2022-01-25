function d_tilde=ofdm_demod(z_tilde,par_N_FFT,par_N_CP,swich_graph)

L= length(z_tilde);
X=reshape(z_tilde,1,L); % L number of columns needed ( 
m=par_N_FFT+par_N_CP; % 1024+ 256 lenth of ofdm blk with CP
n=(L-mod(L,m))/m;%to make  length of z_tilde dividable by 'par_N_FFT+par_N_CP'
A= X(1:m*n); % bringing the serial blk of X into m*n matrix 
A1=reshape(A,m,n);  %serial to parallel
A2=A1(1+par_N_CP:m,:);    % remove cp
d_tilde=fft(A2);       %

if swich_graph==1;
    K=reshape(d_tilde,par_N_FFT*n,1);
    scatterplot(K);
    title('Constellation diagram after OFDM demodulation')
end
end
    
    


