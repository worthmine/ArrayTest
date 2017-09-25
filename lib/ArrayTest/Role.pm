package ArrayTest::Role;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Moose::Role;
has zero => ( is => 'ro', isa => 'Num', default => 0 );
has num => ( is => 'ro', isa => 'ArrayRef[Num]', default =>sub {[1..9]} );
requires 'list';

no Moose::Role;

sub count {
    my $self = shift;
    return scalar $self->list();
}

1;
