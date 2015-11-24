function [vmfcc] = FeatureSpectralMfccs(X, f_s)

     iNumCoeffs  = 13;
    
    % allocate memory
    vmfcc       = zeros(iNumCoeffs, size(X,2));

    H           = ToolMfccFb(size(X,1), f_s);
    T           = GenerateDctMatrix (size(H,1), iNumCoeffs);
 
    for n = 1:size(X,2)
        % compute the mel spectrum
        X_Mel       = log10(H * X(:,n)+1e-20);

        % calculate the mfccs
        vmfcc(:,n)  = T * X_Mel;
    end
    
% vmfcc = (vmfcc(2:end,:)-repmat(min(vmfcc(2:end,:),[],2),1,size(vmfcc,2)))./repmat(max(vmfcc(2:end,:),[],2)-min(vmfcc(2:end,:),[],2),1,size(vmfcc,2));
% rms  = 
%     rms(rms<0) = 0;
%     vmfcc    = vmfcc.*repmat(rms,size(vmfcc,1),1);
%      vmfcc    = vmfcc/max(max(vmfcc));
 vmfcc = vmfcc / norm(vmfcc);
end


%> see function mfcc.m from Slaneys Auditory Toolbox
function [T] = GenerateDctMatrix (iNumBands, iNumCepstralCoeffs)
    T       = cos((0:(iNumCepstralCoeffs-1))' * ...
                                (2*(0:(iNumBands-1))+1) * pi/2/iNumBands);
            
    T       = T/sqrt(iNumBands/2);
    T(1,:)  = T(1,:) * sqrt(2)/2;
end

function [H] = ToolMfccFb (iFftLength, f_s)

    % initialization
    f_start         = 133.3333;
    
    iNumLinFilters  = 13;
    iNumLogFilters  = 27;
    iNumFilters     = iNumLinFilters + iNumLogFilters;

    linearSpacing   = 66.66666666;
    logSpacing      = 1.0711703;

    % compute band frequencies
    f               = f_start + (0:iNumLinFilters-1)*linearSpacing;
    f(iNumLinFilters+1:iNumFilters+2) = ...
		      f(iNumLinFilters) * logSpacing.^(1:iNumLogFilters+2);

    % sanity check
    f               = f (f<f_s/2);
    iNumFilters     = length(f)-2;
    
    f_l             = f(1:iNumFilters);
    f_c             = f(2:iNumFilters+1);
    f_u             = f(3:iNumFilters+2);

    % allocate memory for filters and set max amplitude
    H               = zeros(iNumFilters,iFftLength);
    afFilterMax     = 2./(f_u-f_l);
    f_k             = (0:iFftLength-1)/iFftLength*f_s/2;

    % compute the transfer functions
    for c = 1:iNumFilters
        H(c,:)      = ...
            (f_k > f_l(c) & f_k <= f_c(c)).* ...
            afFilterMax(c).*(f_k-f_l(c))/(f_c(c)-f_l(c)) + ...
            (f_k > f_c(c) & f_k < f_u(c)).* ...
            afFilterMax(c).*(f_u(c)-f_k)/(f_u(c)-f_c(c));
    end
   
    
end