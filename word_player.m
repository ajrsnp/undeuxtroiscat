%%%This program will read back a list of words you've recorded. The
%%%recorded list of words must be given as a Struct


%%%*****Only change the following item*******%%%%%%
words_to_read = all_words1;
%%%******************************************%%%%%%


fs = 44100;
bits = 16;
recObj = audiorecorder(fs, bits, 1);
name_list = fieldnames(words_to_read);

for j = 1:length(name_list)


%# Store data in double-precision array.
sound(words_to_read.(name_list{j}), fs, bits);

pause(2)


end