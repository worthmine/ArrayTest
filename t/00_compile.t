use strict;
use Test::More 0.98 tests => 7;

use lib 'lib';

use_ok 'ArrayTest';                                         # 1
use_ok 'ArrayTest2';                                        # 2

my $a1 = ArrayTest->new();  # Succeed
note join " ", $a1->list();
is $a1->count(), 10, "succeed to count 0..9";               # 3
is scalar $a1->list(), 10, "succeed to count 0..9";         # 4

my $a2 = ArrayTest2->new(); # Fail
note join " ", $a2->list();
is $a2->count(), 10, "succeed to count 0..9";               # 5
is scalar $a2->list(), 10, "succeed to count 0..9";         # 6

my @list = $a2->list();# Succeed
is scalar @list, 10, "succeed to count 0..9";               # 7

done_testing;

