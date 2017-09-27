package ArrayTest4;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Moose;
with 'ArrayTest::Role';

__PACKAGE__->meta->make_immutable;
no Moose;

sub list {
    my $self = shift;
    map {$_} $self->zero(), @{ $self->num() };
}

1;
