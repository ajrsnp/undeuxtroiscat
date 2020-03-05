function ourCMap2 = customcolormap(varargin)
%Making a plus = red, minus = blue, white = neutral colormap
%French flag, basically.

R = linspace(0,1,256);
B = linspace(1,0,256);
G1 = linspace(0,1,128);
G2 = linspace(1,0,128);
G = [G1 G2];
R = R';
G = G';
B = B';
ourCMap = [R G B];

%colormap(ourCMap)

%%
ourCMap2 = [1 0 0;1 1 1;0 0 1];

%colormap(ourCMap2)


end