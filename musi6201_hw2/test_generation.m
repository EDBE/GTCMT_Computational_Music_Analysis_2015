function test = test_generation(f1, f2, A1, A2)
    t1 = 0: 1/(44100-1): 1;
    y1 = A1*sin(2*pi*f1*t1);
    
    t2 = 1: 1/(44100-1): 2;
    y2 = A2*sin(2*pi*f2*t2);
    
    test = [y1';y2'];
  
end