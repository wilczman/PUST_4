% x0 = [1, 1, 1];
% lb = [0.0001 0.0001 0.0001];
x0 = [1, 1, 1, 1, 1, 1, 1];
lb = [0 0 0 1 1 1 1];
ub = [20 20 20 5 20 20 20];

[nastawy_DMC_psilambda_fmincon,E]=fmincon((@(parameters) DMC_mimo_fun_stroj_psi_lambda(parameters,0)),x0,[],[],[],[],lb,ub);
%[nastawy_DMC_psilambda_ga, ~, ~] = ga((@(parameters) DMC_mimo_fun_stroj_psi_lambda(parameters)), 7, [], [], [], [], lb, ub);
%save('optymalne_psi_lambda_DMC_zad4.mat', 'nastawy_DMC_psilambda_fmincon');
%options = gaoptimset('StallGenLimit', 10, 'PopulationSize', 30);
%[nastawy_DMC_psilambda_ga, fval] = ga(@DMC_mimo_fun_stroj_psi_lambda, 7, [], [], [], [], lb, ub, [], [], options);


wskaznik=DMC_mimo_fun_stroj_psi_lambda(nastawy_DMC_psilambda_fmincon,1);
%load('zad4_dane_optym_psilambda.mat', 'Y','U','yzadCell');
%    figure
%     for i=1:3
%         subplot(3,1,i); stairs(Y{i});title(sprintf('Wartoœæ wyjœcia Y%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u');%ylim([-5,5]);
%         hold on;stairs(yzadCell{i});
%         legend('Sygna³ wyjœciowy','Wartoœæ zadana','Location','southeast');
%         %matlab2tikz(    sprintf('DMC_Y%d_D=%d_N=%d_Nu=%d.tex', i,D, N, Nu)    ,'showInfo',false);
%     end
%     hold off
%     
%     figure
%     for i=1:4
%         subplot(4,1,i); stairs(U{i}); hold on;title(sprintf('Wartoœæ wejœcia U%d(k)',i));xlabel('k');ylabel('wartoœæ sygna³u');%ylim([-5,5]);
%         legend('Sygna³ steruj¹cy','Location','southeast');
%         %matlab2tikz(    sprintf('DMC_U%d_D=%d_N=%d_Nu=%d.tex', i,D, N, Nu)    ,'showInfo',false);
%     end
%     hold off
% 
% 
% 
% 
