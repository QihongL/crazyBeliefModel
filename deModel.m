function deModel()
% set the DE you want to plot 
f = @(t,y) - .3* (y-2)*(1-y)*(3-y);

% plotting parameters
range = 5;
interval = 1; 
s_interval = .1;

% plot the direction field
dirfield(f,-range:interval:range, -range:interval:range)

% plot the solution curves
hold on 
for y0 = -range:s_interval:range 
  [ts,ys] = ode45(f,[-range,range],y0); 
  plot(ts,ys) 
end 
hold off

end


%% helper function 
% given a function and ranges on 2 dimensions, 
% plot the direction fields
% credit to Tobias von Petersdorff, which can be found here:
% http://terpconnect.umd.edu/~petersd/246/matlabode.html
function dirfield(f,tval,yval)
[tm,ym]=meshgrid(tval,yval);
dt = tval(2) - tval(1); 
dy = yval(2) - yval(1);
fv = vectorize(f);
if isa(f,'function_handle')
  fv = eval(fv);
end
yp=feval(fv,tm,ym); 
s = 1./max(1/dt,abs(yp)./dy)*0.35;
h = ishold;
quiver(tval,yval,s,s.*yp,0,'.r'); hold on;
quiver(tval,yval,-s,-s.*yp,0,'.r');
if h
  hold on
else
  hold off
end
axis([tval(1)-dt/2,tval(end)+dt/2,yval(1)-dy/2,yval(end)+dy/2])
end