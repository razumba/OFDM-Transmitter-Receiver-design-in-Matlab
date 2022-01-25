function b = digital_source(par_no, switch_graph)
b 	= randi([0 1],par_no,1); % arrange 49152 values of 0 and 1 randonmly in one column by 49152 rows

if switch_graph ==1
    figure(1)
    stem(b); % to show discrete data values 
    title('Information/ Input bits')
end