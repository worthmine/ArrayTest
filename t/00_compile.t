use strict;
use Test::More 0.98 tests => 10;

use lib 'lib';

use_ok 'ArrayTest';                                                     # 1
use_ok 'ArrayTest2';                                                    # 2
use_ok 'ArrayTest3';                                                    # 3
note "\n";

note "they will succeed";
my $a1 = ArrayTest->new();
note join " ", $a1->list();
is $a1->count(), 10, "succeed to count 0..9";                           # 4
is scalar $a1->list(), 10, "succeed to count 0..9";                     # 5
note "\n";

note "they will NOT succeed, why not?";
my $a2 = ArrayTest2->new();
note join " ", $a2->list();
is $a2->count(), 10, "succeed to count 0..9";                           # 6
is scalar $a2->list(), 10, "succeed to count 0..9";                     # 7
note explain \$a2->list();
note "I did count the above again and again...\n";
note "\n";

note "they will succeed";
my @list = $a2->list(); # if let them to another array once...
note join " ", @list;   # the values are same, of course
is scalar @list, 10, "succeed to count 0..9";   # It passes             # 8

my $a3 = ArrayTest3->new();
note join " ", $a3->list();
is $a3->count(), 10, "succeed to count 0..9";                           # 9
is scalar $a3->list(), 10, "succeed to count 0..9";                     #10


done_testing;

