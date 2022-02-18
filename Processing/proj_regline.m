
function projs = proj_regline(x,y,show)

if show ==1 
figure
end

[alfa, beta,r, tcrit, tcalc, p, ~] = slinearwithpear(x,y, 0.05, 0);

if show ==1 
subplot(1,3,1)
plot(x,y,'.')
hold on
plot(x,alfa+beta*x,'r')

text((max(x)-min(x))/40 + min(x), (max(y)-min(y))/2 + min(y), [num2str(alfa,'%.2f') '+' num2str(beta,'%.2f') '*x (r = ' num2str(r,'%.2f') ', p = ' num2str(p,'%.2f') ')'] );
end

yc = y - alfa;
[alfa, beta,r, tcrit, tcalc, p, ~] = slinearwithpear(x,yc, 0.05, 0);

if show ==1 
subplot(1,3,2)
plot(x,yc,'.')
hold on
plot(x,alfa+beta*x,'r')

M = [x ;
     yc];
plotv(M,'b-')

end

xpaxis = max(x);
paxis = beta*xpaxis;
norm_kct = sqrt(xpaxis^2+paxis^2);
xpaxis = xpaxis/norm_kct;
paxis = paxis/norm_kct;

if show ==1 
plot([0 xpaxis], [0 paxis],'k')
end


projs = zeros(length(x),1);

for a = 1:length(x)
   projs(a) = dot([x(a); yc(a)], [xpaxis; paxis]); 
end

if show == 1
    subplot(1,3,3)
    boxplot(projs) 
end

end