% Defining the tree

alphal = 3;

% tau 1
tau1 = {0, [0 1], [1 1], 2};
ind1 = [1,2; 2,2; 2,3; 3,1; 4,1];
pind1 = [1, 0.25, 0.75, 1, 1];

% tau 2
tau2 = {0, 2, [0 0 1], [1 0 1], [2 0 1], [1 1]};
ind2 = [1,1; 1,2 ;2,1 ; 3,1 ; 4,2 ; 5, 2 ; 6,3];
pind2 = [0.25, 0.75, 1, 1, 1, 1, 1];

% tau 3
tau3 = {[0 0], [1 0], [2 0], [1], [0 2], [1 2], [2 2]};
ind3 = [1,2; 2,3; 3,1; 4,1; 4,3; 5, 3; 6,1; 7,2 ];
pind3 = [1, 1, 1, 0.75, 0.25, 1, 1, 1];


% tau 4
tau4 = {0, [0 1], [2 1], 2};
ind4 = [1,1; 1,2; 2,3; 3,1; 4,2; 4,3];
pind4 = [0.75, 0.25, 1, 1, 0.25, 0.75];

% tau 5

tau5 = {2, [2 1], [2 0], [1 0], [0 1], [2 0 0], [1 0 0], [0 0 0]};
ind5 = [1,1;1,2 ;2,1 ;3,1 ;4,1 ;4,2 ;5,3 ;6,1 ;6,2 ; 7,3; 8,3];
pind5 = [0.25, 0.75, 1, 1, 0.25 , 0.75, 1, 0.25 , 0.75 , 1, 1];

% tau 6
tau6 = {2, [2 1], [2 0], [1 1], [1 0], [0 1], [0 0]};
ind6 = [1,1; 1,2;2,1 ;2,2 ;3,1 ;3,2 ;4,3; 5,3; 6,3; 7,3];
pind6 = [0.25,0.75 ,0.25 ,0.75 ,0.25 , 0.75 , 1,1,1,1];


n_trialsv = 25:25:1000;
prop_est = zeros(6,length(n_trialsv));
snum_forn = 10;
time_of_each = zeros(1,length(n_trialsv));
f = waitbar(0,'Please wait...');
tmt_par = [0 1 0 0 1 0];

for j = 1:6
    eval(['tau = tau' num2str(j) ';'])
    eval(['ind = ind' num2str(j) ';'])
    eval(['pind = pind' num2str(j) ';'])
    for a = 1:length(n_trialsv)
        for b = 1:snum_forn
        [rt, chain] = data_for_simulation(tau, alphal, ind, pind, n_trialsv(a),tmt_par(j));
        [tau_est] = tauest_RT(alphal, rt, chain, 0);
        aux = is_thetau(tau,tau_est);
            if aux == 1
               prop_est(j,a) = prop_est(j,a)+1;
            end
        end
        waitbar(a/length(n_trialsv),f, ['Processing tau' num2str(j)]);
    end
end

close all
figure


prop_estf = zeros(size(prop_est,1), size(prop_est,2));
beta_coef = zeros(6,2);

color = 'rmbgyc';
for j = 1:6
   subplot(3,3,j)
   plot(n_trialsv, prop_est(j,:),'ko', 'MarkerFace', color(j))
%    hold on
   [beta_coef(j,1), beta_coef(j,2) , prop_estf(j,:)] = regression_to_logit(n_trialsv, prop_est(j,:), 100);
   legend(['\tau_{' num2str(j) '}'],'Location', 'southeast');
   xlabel('sample size (n)')
   ylabel('Correct Id.')
%    plot(n_trialsv, max(prop_est(j,:))*prop_estf(j,:),color(j))
end

set(0,'defaultfigurecolor',[1 1 1])
set(0, 'DefaultFigureRenderer', 'painters');

figure
x = 0:0.1:1000;
for j = 1:6
   plot(x, (1./(1+exp(-(beta_coef(j,1)+beta_coef(j,2).*x)))), color(j))
   hold on
end
legend('\tau_{1}','\tau_{2}','\tau_{3}','\tau_{4}','\tau_{5}','\tau_{6}','Location', 'southeast');
xlabel('sample size (n)')
ylabel('P (s)')

for j = 1:6
   thres = find(prop_est(j,:)~= 0,1);
   h = plot(ones(1)*x(find(x == n_trialsv(1,thres))),(1./(1+exp(-(beta_coef(j,1)+beta_coef(j,2).*x(find(x == n_trialsv(1,thres))))))),[color(j) 's']);
   set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end