%% A function to convert a ferquency to its corresponding midi note.

function [ midi ] = FreqToMidi( freq )
 midi = 21 +(12 * log(freq/27.5)/log(2)) ;
end

