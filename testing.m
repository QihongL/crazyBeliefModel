clear variables; close all; clc;

range = [0 300];
T = 50; 
tau = .2; 
% set up
initB = 120;
sources = [100 200];

% initial condition
curB = initB;
weights = [0 0];

% update

history.b = nan(T,1);
for t = 1 : T
    % compute distance from 2 sources
    dist = sources - curB
    % update weights as a function of distances 
    weights(1) = (dist(1) / sum(abs(dist)))* tau
    weights(2) = (1 - dist(2) / sum(abs(dist))) * tau
    
    
    % update location 
    curB = curB + weights * dist'
    
    % save history
    history.b(t) = curB;
end

% add initial boundary 
history.b = [initB ;history.b];

% plot the development 
hold on 
plot(history.b, 'linewidth', 1.5)
plot(1, sources(1), 'rx', 'linewidth', 3)
plot(1, sources(2), 'rx', 'linewidth', 3)
hold off 
ylim(range)
xlim([1 T])
