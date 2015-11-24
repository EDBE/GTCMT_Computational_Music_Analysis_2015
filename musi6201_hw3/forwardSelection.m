function [ f_sel, maxRate ] = forwardSelection( genres, features, numFeatures, nFolds, prevSel, prevRate, K )

% Rank the single best feature using 10-fold cross validation
 for i=1:numFeatures
     rate = 0;
     if(~prod(ismember(i,prevSel)))
         [rate, actualLabels] = myNFold(genres, features, nFolds, [prevSel i], K);
     end
     rates(i) = rate;
 end
 [maxRate, ind] = max(rates);
 if(maxRate > prevRate)
     stepRate = maxRate
    [ f_sel, maxRate] = forwardSelection(genres, features, numFeatures, nFolds, [prevSel ind], maxRate, K );
 else
     f_sel = [prevSel];
     maxRate = prevRate;
 end
 
end