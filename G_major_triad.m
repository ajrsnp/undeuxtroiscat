%This .m file plots a Major G chord in the time domain

%Major G triad is composed of G (391.995 Hz), B (493.883), and D (587.33)

t = linspace(0,2,2*44100);

g = sin(2*pi*391.995*t);
b = sin(2*pi*493.883*t);
d = sin(2*pi*587.33*t);

all = g + b + d;

figure(1)
subplot(4,1,1)
plot(1000*t,g)
xlim([0 10])
ylim([-3 3])


subplot(4,1,2)
plot(1000*t,b)
xlim([0 10])
ylim([-3 3])

subplot(4,1,3)
plot(1000*t,d)
xlim([0 10])
ylim([-3 3])

subplot(4,1,4)
plot(1000*t,all)
xlim([0 10])
ylim([-3 3])
xlabel('Time (ms)')


spectrogram(g)


%sound(all,44100)