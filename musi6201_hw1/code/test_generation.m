function test = test_generation(f1, f2)
    t1 = [0: 1/(44100-1): 1];
    A = 1;
    y1 = A*sin(2*pi*f1*t1);
    t2 = [1: 1/(44100-1): 2];
    y2 = A*sin(2*pi*f2*t2);
    test = [y1';y2'];
  
end