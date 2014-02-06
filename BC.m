function res = BC(f0, f1, p)
res = [ f0(1) - p(7);
        f0(2) - p(8);
        f0(3) - p(9);
        f1(1) - p(10);
        f1(2) - p(11);
        f1(3) - p(12)];