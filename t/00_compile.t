use strict;
use Test::More 0.98 tests => 17;

use lib 'lib';

use_ok 'ArrayTest';                                                     # 1
use_ok 'ArrayTest2';                                                    # 2
use_ok 'ArrayTest3';                                                    # 3
use_ok 'ArrayTest4';                                                    # 4
note "\n";

note "they will succeed";
my $a1 = ArrayTest->new();
note join " ", $a1->list();
is $a1->count(), 10, "succeed to count 0..9";                           # 5
is scalar $a1->list(), 10, "succeed to count 0..9";                     # 6
note "\n";

note "they will NOT succeed, why not?";
my $a2 = ArrayTest2->new();
note join " ", $a2->list();
is $a2->count(), 10, "succeed to count 0..9";                           # 7
is scalar $a2->list(), 10, "succeed to count 0..9";                     # 8
note explain \$a2->list();
note "I did count the above again and again...\n";
note "\n";

note "they will succeed";
my @list = $a2->list(); # if let them to another array once...
note join " ", @list;   # the values are same, of course
is scalar @list, 10, "succeed to count 0..9";   # It passes             # 9

my $a3 = ArrayTest3->new();
note join " ", $a3->list();
is $a3->count(), 10, "succeed to count 0..9";                           #10
is scalar $a3->list(), 10, "succeed to count 0..9";                     #11

my $a4 = ArrayTest4->new();
note join " ", $a4->list();
is $a4->count(), 10, "succeed to count 0..9";                           #12
is scalar $a4->list(), 10, "succeed to count 0..9";                     #13

my $zero = 0;
my $num = [1..9];

sub list {
    return( $zero, @$num );
}

my ($x) = list();
my $y = scalar list();

is $x, 0, "\$x is 0";                                                   #14
is $y, 9, "\$y is 9, not 10!";                                          #15

($x) = ( $zero, @$num );
$y = scalar( $zero, @$num );

is $x, 0, "\$x is 0";                                                   #16
is $y, 9, "\$y is 9, not 10!";                                          #17

done_testing;

