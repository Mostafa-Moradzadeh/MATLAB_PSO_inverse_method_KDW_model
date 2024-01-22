function y=Ui(t)
global Rainfallduration Intensity
if t<=Rainfallduration && t>0
    y=Intensity;
else y=0;
end