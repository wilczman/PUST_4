clear all;
%Dlugosc symulacji
kk=300;
%Ograniczenia
u_min=1;
u_max=2;
%Punkt Pracy
U_pp=0;
Y_pp=0;

U{1}=zeros(1, kk);
U{2}=zeros(1, kk);
U{3}=zeros(1, kk);
U{4}=zeros(1, kk);
U{1}(1:kk)=U_pp;
U{2}(1:kk)=U_pp;
U{3}(1:kk)=U_pp;
U{4}(1:kk)=U_pp;
Y{1}=zeros(1, kk);
Y{2}=zeros(1, kk);
Y{3}=zeros(1, kk);
Y{1}(1:11)=Y_pp;
Y{2}(1:11)=Y_pp;
Y{3}(1:11)=Y_pp;

matrice=zeros(1,kk)+1;
matrice(1:4)=0;

for i=1:4
    U{i}=matrice;
    for k=1:kk
       if k>4
            [Y{1}(k),Y{2}(k),Y{3}(k)] = symulacja_obiektu5( ...
            U{1}(k-1),U{1}(k-2),U{1}(k-3),U{1}(k-4),...
            U{2}(k-1),U{2}(k-2),U{2}(k-3),U{2}(k-4),...
            U{3}(k-1),U{3}(k-2),U{3}(k-3),U{3}(k-4),...
            U{4}(k-1),U{4}(k-2),U{4}(k-3),U{4}(k-4),...
            Y{1}(k-1),Y{1}(k-2),Y{1}(k-3),Y{1}(k-4),...
            Y{2}(k-1),Y{2}(k-2),Y{2}(k-3),Y{2}(k-4),...
            Y{3}(k-1),Y{3}(k-2),Y{3}(k-3),Y{3}(k-4));  
       end
    end
    odp_skok{i}{1} = Y{1}; Y{1} = zeros(1, kk);
    odp_skok{i}{2} = Y{2}; Y{2} = zeros(1, kk);
    odp_skok{i}{3} = Y{3}; Y{3} = zeros(1, kk);
    U{i} = zeros(1, kk);
end

%WYKRESY
    figure 
    hold on;
    for i=1:4
        subplot(4,3,i*3-2); stairs(odp_skok{i}{1});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y1(k)');
        subplot(4,3,i*3-1); stairs(odp_skok{i}{2});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y2(k)');
        subplot(4,3,i*3); stairs(odp_skok{i}{3});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y3(k)');
    end
 

    
    

% %%%ZAPIS DO PLIKU%%%%%%%
% j=0; k=0;
% numU=4;numY=;
% for k=1:kk       
%        j=j+1;
%        table_Y(1,k)=double(j);
% %        table_U(1,k)=double(j);
% end
% %macierze wykorzystane do zapisu
% table_Y(2,:)=odp_skok{numU}{numY};
% % table_U(2,:)=U;
% 
% fname_Y = sprintf('odp_skok_U%d_Y%d.txt',numU,numY);
% % fname_U = sprintf('odp_skok_U.txt');
% mkdir_status_Y=mkdir(sprintf('C:\\Users\\Kuba\\Desktop\\GIT\\PUST_4\\odp_skok_'));
% if mkdir_status_Y
%    savdir_Y = sprintf('C:\\Users\\Kuba\\Desktop\\GIT\\PUST_4\\odp_skok_\\');
% 
%    fileID = fopen([savdir_Y fname_Y],'w');
%    fprintf(fileID,'%6.3f %6.3f\r\n',table_Y);
%    fclose(fileID);
% %    fileID = fopen([savdir_Y fname_U],'w');
% %    fprintf(fileID,'%6.3f %6.3f\r\n',table_U);
% %    fclose(fileID);
%    
% else 
%    disp('Nie udalo sie stworzyc folderów')
% end
% warning('on','all') %wlaczenie warningow
% 
%    