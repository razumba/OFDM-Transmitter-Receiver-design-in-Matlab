clc 
close all;
clear all;

par_G=[1,1,0,1;1,0,1,1;1,0,0,0;0,1,1,1;0,1,0,0;0,0,1,0;0,0,0,1;];
par_H=[1 0 1 0 1 0 1;0 1 1 0 0 1 1;0 0 0 1 1 1 1; 0 1 0 1 0 1 0];
M=4;   % Modulation technique 
par_N_FFT = 1024;  % FFT points
% ---------------------- TRANSMITTER ---------------------------
 

% --------------------- Digital source -------------------------
par_no =49152; % 1024*48
switch_graph =1;
b=digital_source(par_no, switch_graph);



% ------------------- Channel coding ---------------------------
switch_off=1;
par_N_zeros=0;
c=channel_coding(b,par_G,par_N_zeros,switch_off);
 

% ------------------- Modulation -------------------------------
switch_mod =0;
switch_graph =1;
%[d,hDemod]=modulation(c,M,switch_graph);
d=modulation(c,switch_mod,switch_graph);

% ----------------- Pilot insertion -----------------------------
par_N_block=length(d)/par_N_FFT; % 42 blocks
switch_graph =1;
D=pilot_insertion(d,par_N_FFT,par_N_block,switch_graph);

% --------------------- OFDM Tx ---------------------------------
par_N_CP= 256;
switch_graph = 1;
z=tx_ofdm_mod(D,par_N_FFT,par_N_CP,switch_graph);

% ------------------ Tx Filter ---------------------------------
par_tx_w=20;
switch_graph = 0;
switch_off=1;
s=tx_filter(z,par_tx_w,switch_graph,switch_off);

% --------------- Non-Linear Hardware --------------------------
par_txthresh=1;
switch_graph = 0;
[x]=tx_hardware(s,par_txthresh,switch_graph);



 SNR = 20:20:60;
 N_iter = 4;
 BER = zeros(length(SNR),N_iter);
 for k = 1 : N_iter
 for i= 1 : length(SNR)

% ------------------ CHANNEL -----------------------------------

y=Channel(x,SNR(i),'FSBF');

% ------------------ Reciever-----------------------------------

% ---------------- Non-Linear Hardware--------------------------
par_rxthresh=1;
if i==length(SNR)&&k==N_iter
    switch_graph = 1;
else
    switch_graph = 0;
end
s_tilde=rx_hardware(y,par_rxthresh,switch_graph);

% ------------------- RX-Filter --------------------------------
par_rx_w=20;
if i==length(SNR)&&k==N_iter
switch_graph = 1;
else
    switch_graph = 0;
end
switch_off=1;
z_tilde=rx_filter(s_tilde,par_rx_w,switch_graph,switch_off);


% ----------------- OFDM-Demodulation --------------------------

d_tilde=ofdm_demod(z_tilde,par_N_FFT,par_N_CP,switch_graph);
% DD=d_tilde';
%DD1 = matdeintrlv(DD,11,2)'; % De-Interleave
%DD1=randdeintrlv (DD,2)';
% ------------------ Equalizer ----------------------------------
switch_mod=1;
d_bar=equalizer(d_tilde,switch_mod,switch_graph);

% ----------------- Demodulation --------------------------------
 switch_mod = 0;
switch_graph=0;
%c_hat=demodulation(d_bar,hDemod,switch_graph);
c_hat=demodulation_mod(d_bar,switch_mod,switch_graph);
% ----------------- Channel Decoding ----------------------------
switch_off=1;
[counter,b_hat]=channel_decoding(c_hat,par_H,par_N_zeros,switch_off,i);

error= abs(b-b_hat);
BER(i,k)=sum(error)/length(b);
 end
 end
 switch_graph=1;
 figure
 subplot(3,1,1);
 stem((1:1:7),counter(1,:));
  subplot(3,1,2);
 stem((1:1:7),counter(2,:));
  subplot(3,1,3);
 stem((1:1:7),counter(3,:));
 title('Corrected errors')
 
 BER_loop = sum(BER,2)/N_iter;
 figure;
 semilogy(SNR,BER_loop);
 title('SNR vs BER');
 xlabel('SNR in dB');
 ylabel('BER');
 grid on
 