function output = LOP(FileName,Scale) 
[s,fs] = audioread(FileName); 
y = (s(:,1)+s(:,2)); 
N = length(y); 
Y = fft(y); 
P2 = abs(Y/N); 
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N/2)/N;
L = length(P1);
fref = 261.63;
x1 = round(12*log2(f/fref)); 
x = mod(x1,12);
figure(1)
plot(f,P1)
title('Fourier Transform')
xlabel('Frequency(Hz)')
ylabel('Amplitude')
grid on
C = 0;
Csharp = 0;
D = 0;
Dsharp = 0;
E = 0;
F = 0;
Fsharp = 0;
G = 0;
Gsharp = 0;
A = 0;
Asharp = 0;
B = 0;
for i = 1:L
    if x(i) == 0
        C = C + abs(P1(i))*abs(P1(i));
    elseif x(i) == 1
        Csharp = Csharp + abs(P1(i))*abs(P1(i));
    elseif x(i) == 2
        D = D + abs(P1(i))*abs(P1(i));
    elseif x(i) == 3
        Dsharp = Dsharp + abs(P1(i))*abs(P1(i));
    elseif x(i) == 4
        E = E + abs(P1(i))*abs(P1(i));
    elseif x(i) == 5
        F = F + abs(P1(i))*abs(P1(i));
    elseif x(i) == 6
        Fsharp = Fsharp + abs(P1(i))*abs(P1(i));
    elseif x(i) == 7
        G = G + abs(P1(i))*abs(P1(i));
    elseif x(i) == 8
        Gsharp = Gsharp + abs(P1(i))*abs(P1(i));
    elseif x(i) == 9
        A = A + abs(P1(i))*abs(P1(i));
    elseif x(i) == 10
        Asharp = Asharp + abs(P1(i))*abs(P1(i));
    elseif x(i) == 11
        B = B + abs(P1(i))*abs(P1(i));
    end

end

if Scale == 'C'
    key = 0;
elseif Scale == 'C#'
    key = 1;
elseif Scale == 'D'
    key = 2;
elseif Scale == 'D#'
    key = 3;
elseif Scale == 'E'
    key = 4;
elseif Scale == 'F'
    key = 5;
elseif Scale == 'F#'
    key = 6;
elseif Scale == 'G'
    key = 7;
elseif Scale == 'G#'
    key = 8;
elseif Scale == 'A'
    key = 9;
elseif Scale == 'A#'
    key = 10;
elseif Scale == 'B'
    key = 11;
end
Amplitude = [C,Csharp,D,Dsharp,E,F,Fsharp,G,Gsharp,A,Asharp,B];
figure(2)
plot([1,2,3,4,5,6,7,8,9,10,11,12],Amplitude)
title('Chromagram')
xlabel('Bins')
ylabel('Magnitude')
grid on
Amplitude = circshift(Amplitude,[0,12-key]);

amp = Amplitude;
[~,I1] = min(amp);
amp(I1) = max(amp);
[~,I2] = min(amp);
amp(I2) = max(amp);
[~,I3] = min(amp);
amp(I3) = max(amp);
[~,I4] = min(amp);
amp(I4) = max(amp);
[~,I5] = min(amp);

identifier = [I1,I2,I3,I4,I5];
identifier = sort(identifier);

tf1 = isequaln(identifier,[2,4,7,9,11]);
tf2 = isequaln(identifier,[3,4,7,10,11]);
tf3 = isequaln(identifier,[2,4,6,9,11]);
tf4 = isequaln(identifier,[2,5,7,10,12]);
tf5 = isequaln(identifier,[2,5,7,9,12]);
tf6 = isequaln(identifier,[2,4,7,9,12]);
tf7 = isequaln(identifier,[3,4,6,9,10]);

if tf1 == 1
    raagam = 'Sankarabharanam';
elseif tf2 == 1
    raagam = 'Mayamalavagowla';
elseif tf3 == 1
    raagam = 'Kalyani';
elseif tf4 == 1
    raagam = 'Natabhairavi';
elseif tf5 == 1
    raagam = 'Kharaharipriya';
elseif tf6 == 1
    raagam = 'Harikhamboji';
elseif tf7 == 1
    raagam = 'Vishwambari';
end
 output = raagam;



