%%This program is used to record long lists of words into a Struct (default
%name - found on the second to last line of code- is 'all_words'). If a
%word is repeated, it will overwrite the previous instance of that word.
%If you want to play back the word use the fuction 'sound' i.e. type:
% sound(all_words.taco, 44100, 16)


%%%*******This is the list of words you want to record *******%%%
list_of_words = last_20_words;
%%%***********************************************************%%%


fs = 44100;
bits = 16;
recObj = audiorecorder(fs, bits, 1);

pause(1)

for j = 1:length(list_of_words)

%# Collect a sample of your speech with a microphone
recObj = audiorecorder(fs, bits, 1);

disp('Say the following word:')
disp(list_of_words(j))
recordblocking(recObj, 2);

disp('pause')
pause(2);


%# Store data in double-precision array.
all_words1.(list_of_words{j}) = getaudiodata(recObj);
end
