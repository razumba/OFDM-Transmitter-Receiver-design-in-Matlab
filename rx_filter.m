function [z_tilde]=rx_filter(s_tilde,par_rx_w,switch_graph,switch_off)

if switch_off==1
   F=rcosine(1,par_rx_w,'fir/sqrt');
   F_out = conv( F, s_tilde);
   z_tilde = F_out(1:par_rx_w:length(F_out)); % downsampling
   [H W] = freqz(F_out,1,512); %W =omega angular frequency
    
    if switch_graph==1
        figure;
        plot(W/pi,20*log10(abs(H)));
        xlabel('\omega/pi');
        ylabel('H in dB');
        title('Receiever filter output in normalize freq domain');
        hold on
   
    grid on
        figure
        hold off
        subplot(2,1,1)
        
        plot(real(F_out),'b');
        xlabel('Bits sequence');
        ylabel('Amplitude');
        title('receieve filter output in freq domain');
        ylabel('Real part of output of Rx filter')
        grid on
        subplot(2,1,2)
        plot(imag(F_out),'r');
        grid on
        xlabel('Bits sequence');
        ylabel('Amplitude');
        ylabel('Imaginary part of output of Rx filter')
        eyediagram(F_out,10000,'g'); 
        
       
        
    end
   
    

else
    z_tilde=s_tilde;
end



end