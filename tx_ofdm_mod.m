function z=tx_ofdm_mod(D,par_N_FFT,par_N_CP,switch_graph)
D_ifft=ifft(D);
a=par_N_FFT+par_N_CP;
b=par_N_FFT-par_N_CP;
[m,n]=size(D_ifft);   %%%%
CP=zeros(par_N_CP,n);  %%%% adding zeros of length of cp for every blks
for i=1:par_N_CP            %%% this loop is for adding CP in front of data blks
                          % CP=last 256 bits of 1024 lenth frame.this cp is added infront of the frame.
    CP(i,:)=D_ifft(b+i,:);
end
A=[CP;D_ifft]; % adding CP infront of data D that si stored in A
%%%% final frame=256bit CP+1024bit dataframe+256bit CP+1024bit dataframe+...
[p,q]=size(A);
z=reshape(A,1,p*q); % to change the ouptut as serial from parallel 

B=z(a+1:2*a); % plotting one ofdm blk 
[H W] = freqz(B,1,512);
if switch_graph==1
   figure;
    plot(real(B)); % have one frame B in time domain
    title('OFDM symbol in time domain');
    xlabel('OFDM symbol sequence');
    ylabel('Amplitude');
    
        figure;
        plot(W/pi,20*log10(abs(H))); 
        xlabel('\omega/pi');
        ylabel('H in DB');
        title('OFDM symbol in normalize frequency domain');
    
end