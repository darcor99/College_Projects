function yprime = rossler(t,y,a,b,c)

a = 0.2; b= 0.2; c= 2.5

yprime = [-y(2)-y(3);y(1)+a*y(2); b+y(3)*(y(1)-c)];
end
