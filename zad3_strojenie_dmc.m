clear all
close all
save_flag=1; %1 jesli chcesz zapisac wykresy, 0 jesli nie

%%%% co chcesz stroiæ?
%D - strojony_parametr=1
%N - strojony_parametr=2
%Nu - strojony_parametr=3
strojony_parametr=3; %wybierz odpowiedni parametr

%parametry poczatkowe byly 100 70 50
parametry=[70 40 50];   %koncowe

switch strojony_parametr
    case 1
        max=100;
        min=5;
        krok=5;
        str_param_numer=1;
        str_param_nazwa='D';
    case 2
        max=70;
        min=5;
        krok=5;
        str_param_numer=2;
        str_param_nazwa='N';
    case 3
        max=50;
        min=2;
        krok=2;
        str_param_numer=3;
        str_param_nazwa='Nu';
end

e_table=zeros((max-min)/krok,4);

i=1;
for value=max:-krok:min
    parametry(str_param_numer)=value;
    e_table(i,2:4)=parametry;
    e_table(i,1)=DMC_mimo_fun_stroj_eksper(parametry, save_flag);
    i=i+1;
end
title1=sprintf('bledy_strojenie_%s', str_param_nazwa);
save(title1, 'e_table');