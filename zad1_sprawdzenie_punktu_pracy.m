clear all;
%Dlugosc symulacji
kk=300;
%Ograniczenia
u_min=1;
u_max=2;
%Punkt Pracy
U_pp=0;
Y_pp=0;

U1=zeros(1, kk);
U2=zeros(1, kk);
U3=zeros(1, kk);
U4=zeros(1, kk);
U1(1:kk)=U_pp;
U2(1:kk)=U_pp;
U3(1:kk)=U_pp;
U4(1:kk)=U_pp;
Y1=zeros(1, kk);
Y2=zeros(1, kk);
Y3=zeros(1, kk);
Y1(1:11)=Y_pp;
Y2(1:11)=Y_pp;
Y3(1:11)=Y_pp;

for k=1:kk
   if k>4
        [Y1(k),Y2(k),Y3(k)] = symulacja_obiektu5( ...
        U1(k-1),U1(k-2),U1(k-3),U1(k-4),...
        U2(k-1),U2(k-2),U2(k-3),U2(k-4),...
        U3(k-1),U3(k-2),U3(k-3),U3(k-4),...
        U4(k-1),U4(k-2),U4(k-3),U4(k-4),...
        Y1(k-1),Y1(k-2),Y1(k-3),Y1(k-4),...
        Y2(k-1),Y2(k-2),Y2(k-3),Y2(k-4),...
        Y3(k-1),Y3(k-2),Y3(k-3),Y3(k-4));  
   end
end

%WYKRESY
    figure 
    hold on;
    subplot(7,1,1);
    stairs(Y1);
    title('Wyj�cie y1(k)');xlabel('k');ylabel('warto�� sygna�u');
    subplot(7,1,2);
    stairs(Y2);
    title('Wyj�cie y2(k)');xlabel('k');ylabel('warto�� sygna�u');
    subplot(7,1,3);
    stairs(Y3);
    title('Wyj�cie y3(k)');xlabel('k');ylabel('warto�� sygna�u');
    
    
    
    subplot(7,1,4);
    stairs(U1);
    title('Sygna� steruj�cy u1(k)');xlabel('k');ylabel('warto�� sygna�u');
    subplot(7,1,5);
    stairs(U2);
    title('Sygna� steruj�cy u2(k)');xlabel('k');ylabel('warto�� sygna�u');
    subplot(7,1,6);
    stairs(U3);
    title('Sygna� steruj�cy u3(k)');xlabel('k');ylabel('warto�� sygna�u');
    subplot(7,1,7);
    stairs(U4);
    title('Sygna� steruj�cy u4(k)');xlabel('k');ylabel('warto�� sygna�u');
    

%%%ZAPIS DO PLIKU%%%%%%%
% j=0; k=0;
% for k=1:kk       
%        j=j+1;
%        table_Y(1,k)=double(j);
%        table_U(1,k)=double(j);
% end
% %macierze wykorzystane do zapisu
% table_Y(2,:)=Y;
% table_U(2,:)=U;
% 
% fname_Y = sprintf('ppY.txt');
% fname_U = sprintf('ppU.txt');
% mkdir_status_Y=mkdir(sprintf('C:\\Users\\Kuba\\Desktop\\GIT\\PUST_3\\wykres_punkt_pracy'));
% if mkdir_status_Y
%    savdir_Y = sprintf('C:\\Users\\Kuba\\Desktop\\GIT\\PUST_3\\wykres_punkt_pracy\\');
% 
%    fileID = fopen([savdir_Y fname_Y],'w');
%    fprintf(fileID,'%6.3f %6.3f\r\n',table_Y);
%    fclose(fileID);
%    fileID = fopen([savdir_Y fname_U],'w');
%    fprintf(fileID,'%6.3f %6.3f\r\n',table_U);
%    fclose(fileID);
%    
% else 
%    disp('Nie udalo sie stworzyc folder�w')
% end
% warning('on','all') %wlaczenie warningow

   