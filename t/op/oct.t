#!./perl

print "1..24\n";

print +(oct('0b10101') ==          0b10101) ? "ok" : "not ok", " 1\n";
print +(oct('0b10101') ==              025) ? "ok" : "not ok", " 2\n";
print +(oct('0b10101') ==               21) ? "ok" : "not ok", " 3\n";
print +(oct('0b10101') ==             0x15) ? "ok" : "not ok", " 4\n";

print +(oct('b10101')  ==          0b10101) ? "ok" : "not ok", " 5\n";
print +(oct('b10101')  ==              025) ? "ok" : "not ok", " 6\n";
print +(oct('b10101')  ==               21) ? "ok" : "not ok", " 7\n";
print +(oct('b10101')  ==             0x15) ? "ok" : "not ok", " 8\n";

print +(oct('01234')   ==     0b1010011100) ? "ok" : "not ok", " 9\n";
print +(oct('01234')   ==            01234) ? "ok" : "not ok", " 10\n";
print +(oct('01234')   ==              668) ? "ok" : "not ok", " 11\n";
print +(oct('01234')   ==            0x29c) ? "ok" : "not ok", " 12\n";

print +(oct('0x1234')  ==  0b1001000110100) ? "ok" : "not ok", " 13\n";
print +(oct('0x1234')  ==           011064) ? "ok" : "not ok", " 14\n";
print +(oct('0x1234')  ==             4660) ? "ok" : "not ok", " 15\n";
print +(oct('0x1234')  ==           0x1234) ? "ok" : "not ok", " 16\n";

print +(hex('01234')   ==  0b1001000110100) ? "ok" : "not ok", " 17\n";
print +(hex('01234')   ==           011064) ? "ok" : "not ok", " 18\n";
print +(hex('01234')   ==             4660) ? "ok" : "not ok", " 19\n";
print +(hex('01234')   ==           0x1234) ? "ok" : "not ok", " 20\n";

print +(hex('0x1234')  ==  0b1001000110100) ? "ok" : "not ok", " 21\n";
print +(hex('0x1234')  ==           011064) ? "ok" : "not ok", " 22\n";
print +(hex('0x1234')  ==             4660) ? "ok" : "not ok", " 23\n";
print +(hex('0x1234')  ==           0x1234) ? "ok" : "not ok", " 24\n";
