data = load('tide_data');
fftdata = fft(data(2,:));
N = length(data);

close all;
h = figure;

subplot(2,3,1);
plot(data(1,:),data(2,:));
title('Original Data');

subplot(2,3,2);
plot(fftdata/N,'r*');
title(sprintf('Original, # points = %d',N));

hold on;plot([0 0],ylim,'k');hold on;plot(xlim,[0 0],'k');


subplot(2,3,3);
% NN=40; plot(0:NN-1,abs(fftdata(1:NN))/N);
%plot(0:N-1,abs(fftdata(1:N))/N);
plot(-N/2:(N/2-1),abs(fftshift(fftdata))/N,'r');
title('ABS(Fourier Transform)');

% return
x = linspace(0,N,1000);
cutoff = 0.2;
maxfft = max(abs(fftdata(2:end)));
filter = cutoff*maxfft;
compressed = zeros(1,length(fftdata));
filtered_points = 1;
compressed_index = [];
for n = 1:length(fftdata)
    if (abs(fftdata(n))>filter)
        compressed(n) = fftdata(n);
        compressed_index = [compressed_index n]
        filtered_points = filtered_points +1;
    end
end

subplot(2,3,4);
plot(data(1,:),real(ifft(compressed)));
title('Reconstructed Data');

subplot(2,3,5);
plot(compressed/N,'r*');
title(sprintf('Filtered, # points = %d',filtered_points));

subplot(2,3,6);
% NN=40; plot(0:NN-1,abs(fftdata(1:NN))/NN);
plot(-N/2:(N/2-1),abs(fftshift(compressed))/N,'r');
title('ABS(Fourier Transform)');
height = max(abs(compressed))/N+0.25;
text(-0.6*N,height,sprintf('Compression: %2.1f%%',100*(1-filtered_points/N)));

save_results = 0;
if ( save_results == 1)
    save_dir = '~/m/r/talks/pics/';
    plot_title = 'tide_fft';
    print(h,'-djpeg',[save_dir plot_title '.jpg']);
%     print(h,'-depsc',[save_dir plot_title '.eps']);
    print(h,'-dpng',[save_dir plot_title '.png']);
end
