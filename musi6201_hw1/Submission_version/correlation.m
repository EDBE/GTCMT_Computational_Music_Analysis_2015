function z = correlation (x,h)
    % initialization 
    L = size(x, 2);
    M = size(h, 2);
    z = zeros((L+M-1), 1);

    C = L + M - 1;

    for i=1:C
        xbeg = max(1,i-M+1);
        xend = min(i,L);
        hbeg = max(1,M-i+1);
        hend = min(M, C - i + 1);

        z(i) = x(xbeg:xend)*(h(hbeg:hend))';      
    end

end