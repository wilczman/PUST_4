clear all
kk=350;
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
matrice(1:49)=0;

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
    odp_skok_rw{i}{1} = Y{1}(50:kk); Y{1} = zeros(1, kk);
    odp_skok_rw{i}{2} = Y{2}(50:kk); Y{2} = zeros(1, kk);
    odp_skok_rw{i}{3} = Y{3}(50:kk); Y{3} = zeros(1, kk);
    U{i} = zeros(1, kk);
end

figure 
    hold on;
    for i=1:4
        subplot(4,3,i*3-2); stairs(odp_skok_rw{i}{1});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y1(k)');
        xlim([0 300])
        subplot(4,3,i*3-1); stairs(odp_skok_rw{i}{2});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y2(k)');
        xlim([0 300])
        subplot(4,3,i*3); stairs(odp_skok_rw{i}{3});title(sprintf('Skok sygna³u steruj¹cego u%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u y3(k)');
        xlim([0 300])
    end