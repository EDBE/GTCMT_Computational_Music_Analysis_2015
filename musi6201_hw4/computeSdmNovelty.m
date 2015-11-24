% compute novelty function from Self-distance matrix
% input:
%   SDM: float N by N matrix, self-distance matrix
%   L: int, L of the checkerboard kernel (L by L) preferably power of 2
% output:
%   nvt: float N by 1 vector, audio segmentation novelty function 

function [nvt] = computeSdmNovelty(SDM, L)


    function [kernel] = computeFilter(L)
        w = kron( [1 -1; -1 1], ones(L/2,L/2) );
        kernel = w.*(gausswin(L) *gausswin(L)');
    end
g = computeFilter(L);
figure();
mesh(g);
out = filter2(g, SDM);
nvt = diag(out);
nvt = (nvt - min(nvt))/(max(nvt) - min(nvt));
figure();
plot(nvt), axis tight;    
    
end

