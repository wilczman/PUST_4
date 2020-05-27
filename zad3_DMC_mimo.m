clear all
close all
    
    
    ny=3;
    nu=4;
    Ypp=0;
    Upp=0;
%     u_max=100;
%     u_min=0;
    
    load('odp_skok.mat')
    
    D=80; N=35; Nu=15;
    
    
    u_max=100-Upp;
    u_min=0-Upp;
    
    
    kk=400; %d³ugoœæ symulacji

    %deklaracja wektorów sygna³ów oraz b³êdów
    U{1}=zeros(1, kk);
    U{2}=zeros(1, kk);
    U{3}=zeros(1, kk);
    U{4}=zeros(1, kk);
    U{1}(1:kk)=Upp;
    U{2}(1:kk)=Upp;
    U{3}(1:kk)=Upp;
    U{4}(1:kk)=Upp;
    Y{1}=zeros(1, kk);
    Y{2}=zeros(1, kk);
    Y{3}=zeros(1, kk);
    y=zeros(kk,3);
    Y{1}(1:11)=Ypp;
    Y{2}(1:11)=Ypp;
    Y{3}(1:11)=Ypp;

    e=zeros(kk, ny);
    e_quad_sum=zeros(kk,1);
    yzadCell{1}=zeros(1, kk);
    yzadCell{2}=zeros(1, kk);
    yzadCell{3}=zeros(1, kk);
    u=zeros(kk,nu);


    % yzadCell{1}(2*kk/5:3*kk/5)=1;
    % yzadCell{1}(4*kk/5:5*kk/5)=2;
    % yzadCell{2}(2*kk/5:3*kk/5)=3;
    % yzadCell{2}(4*kk/5:5*kk/5)=4;
    % yzadCell{3}(1*kk/5:2*kk/5)=-1;
    % yzadCell{3}(3*kk/5:5*kk/5)=-2;
    yzadCell{1}(2*kk/5:3*kk/5)=-1;
    yzadCell{1}(4*kk/5:5*kk/5)=-5;
    yzadCell{2}(2*kk/5:3*kk/5)=2;
    yzadCell{2}(4*kk/5:5*kk/5)=1;
    yzadCell{3}(1*kk/5:2*kk/5)=-5;
    yzadCell{3}(3*kk/5:5*kk/5)=3;

    yzadCell{1}=yzadCell{1}-Ypp;
    yzadCell{2}=yzadCell{2}-Ypp;
    yzadCell{3}=yzadCell{3}-Ypp;

    yzad(:,1)=yzadCell{1};
    yzad(:,2)=yzadCell{2};
    yzad(:,3)=yzadCell{3};
    
    S=cell(N+D-1,1);
    for i=1:N+D-1
        S{i}=[odp_skok{1}{1}(i), odp_skok{2}{1}(i), odp_skok{3}{1}(i), odp_skok{4}{1}(i);...
              odp_skok{1}{2}(i), odp_skok{2}{2}(i), odp_skok{3}{2}(i), odp_skok{4}{2}(i);...   
              odp_skok{1}{3}(i), odp_skok{2}{3}(i), odp_skok{3}{3}(i), odp_skok{4}{3}(i)];
    end
    
    Mcell=cell(N, Nu);
    for i=1:N
        for j=1:Nu
            Mcell{i,j}=zeros(ny,nu);
        end
    end
    i=0;
    for j=1:Nu  %wypelnianie macierzy trojkatnej dolnej M
       Mcell(j:N,j)=S(1:N-i);  
       i=i+1;
    end
    M=cell2mat(Mcell);
    
    
    Mpcell=cell(N,(D-1));     
    for j=1:N %wypelnianie macierzy Mp
       for i=1:D-1
           Mpcell{j, i}=cell2mat(S(j+i))-cell2mat(S(i));    
       end
    end
    Mp=cell2mat(Mpcell);
    
    psi=[1 1 1];
    
    idx_end=0;
    for i=1:N
      idx_beg=idx_end+1;
      idx_end=idx_beg+(ny-1);
      psiVector(idx_beg:idx_end)=psi;     
    end
    bigPsi=diag(psiVector);
    
    lambda=[5 5 5 5];
    idx_end=0;
    for i=1:Nu
      idx_beg=idx_end+1;
      idx_end=idx_beg+(nu-1);
      lambdaVector(idx_beg:idx_end)=lambda;     
    end
    bigLambda=diag(lambdaVector);
    
  
    
    Yzad=zeros(N*ny,1);
    Y_ptak=zeros(N*ny,1);
    deltaU=zeros(Nu*nu,1);
    deltaUP=zeros((D-1)*nu,1);
    K=inv(M'*bigPsi*M+bigLambda)*M'*bigPsi;
    K1=K(1:nu,:);
    
    
    for k=5:kk
        [Y{1}(k),Y{2}(k),Y{3}(k)] = symulacja_obiektu5( ...
            U{1}(k-1),U{1}(k-2),U{1}(k-3),U{1}(k-4),...
            U{2}(k-1),U{2}(k-2),U{2}(k-3),U{2}(k-4),...
            U{3}(k-1),U{3}(k-2),U{3}(k-3),U{3}(k-4),...
            U{4}(k-1),U{4}(k-2),U{4}(k-3),U{4}(k-4),...
            Y{1}(k-1),Y{1}(k-2),Y{1}(k-3),Y{1}(k-4),...
            Y{2}(k-1),Y{2}(k-2),Y{2}(k-3),Y{2}(k-4),...
            Y{3}(k-1),Y{3}(k-2),Y{3}(k-3),Y{3}(k-4)); 
        
        
        for i=1:ny
            y(k,i)=Y{i}(k)-Ypp;
        end
        e(k,:)=yzad(k,:)-y(k,:);
        e_quad_sum(k,:)=sum(e(k,:).^2);
        Yzad=repmat(yzad(k,:)',N, 1);
        Y_wek=repmat(y(k,:)',N,1);


        deltaUP((nu+1):nu*(D-1), 1)=deltaUP(1:nu*(D-1)-nu, 1);
        deltaUP(1:nu,1) = u(k-1,:)'-u(k-2,:)';
        

        Y0=Y_wek+Mp*deltaUP;
        deltaU=K*(Yzad-Y0);
        deltaY=M*deltaU;
        
        Y_ptak=Y0+deltaY;
        
        delta_u=K1*(Yzad-Y_wek-Mp*deltaUP);
        
        
        u(k,:)=u(k-1,:)+delta_u';
        
        
%         if u(k,1)>u_max(1,1)
%             u(k,1)=u_max(1,1);
%         elseif u(k,1)<u_min(1,1)
%             u(k,1)=u_min(1,1);
%         end
%         
%         if u(k,2)>u_max(1,2)
%             u(k,2)=u_max(1,2);
%         elseif u(k,2)<u_min(1,2)
%             u(k,2)=u_min(1,2);
%         end
        
        for i=1:nu
            U{i}(k)=u(k,i)+Upp;
        end
        yzad(k,:)=yzad(k,:)+Ypp;        
    end

wskaznik_jakosci=sum(e_quad_sum);
figure
for i=1:3
    subplot(3,1,i); stairs(Y{i});title(sprintf('Wartoœæ wyjœcia Y%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u');ylim([-5,5]);
    hold on;stairs(yzadCell{i});
end
hold off

figure

for i=1:4
    subplot(4,1,i); stairs(U{i}); hold on;title(sprintf('Wartoœæ wejœcia U%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u');ylim([-5,5]);
end
hold off