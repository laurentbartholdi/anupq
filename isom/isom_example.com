#example used in lecture

1
prime 2 
class 2 
generators {a, b} 
relations {a^4, b^2 = [b, a, a], b = a^2 * b^-1 * a^2} 
;

2
Standard 

10

3
1 0 0 1
0 1 0 0 

1 0 0 0
0 1 0 1

1 1 1 0
0 1 1 1


1 #PAG-generating sequence

0
