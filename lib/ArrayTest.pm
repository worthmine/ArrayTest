package ArrayTest;
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
    my @list = ( $self->zero(), @{ $self->num() } );
}

1;
__END__

=encoding utf-8

=head1 NAME

ArrayTest - perl CORE::scaler has strange specifications

=head1 SYNOPSIS

C<perl t/00_compile.t> will never succeed. Why not?

=head1 DESCRIPTION

I wonder why do these tests fail.

=head2 what's the matter?

C<diff lib/ArrayTest.pm lib/ArrayTest2.pm> without POD is below:

 1c1
 < package ArrayTest;
 ---
 > package ArrayTest2;
 16c16
 <     my @list = ( $self->zero(), @{ $self->num() } );
 ---
 >     ( $self->zero(), @{ $self->num() } );

The joined value with ' ' is same,
And trying to C<note explain> succeeded, I got 10 references.

So there must be 10 references in what these return.
But CORE::scalar() returns 9 with ArrayTest2.pm.

It was too strange for me.

=head2 But it's the specifications

According to L<perldoc|http://perldoc.perl.org/perlop.html#Comma-Operator>,

 Comma Operator

 Binary "," is the comma operator. In scalar context it evaluates its left
 argument, throws that value away, then evaluates its right argument and\
 returns that value.
 This is just like C's comma operator. In list context, it's just the list
 argument separator, and inserts both its arguments into the list.
 These arguments are also evaluated from left to right.

namely, C<( $self-E<gt>zero(), @{ $self-E<gt>num() } )> and ifever, C<return ( $self-E<gt>zero(), @{ $self-E<gt>num() } )> mean below:

 $self->zero();
 @{ $self->num() };

So they return only C<@{ $self-E<gt>num() }> B<in scalar context>

To tell the truth, Moose is irrelevant. To say simply,

 my $zero = 0;
 my $num = [1..9];

 sub list {
    return( $zero, @$num );
 }
 
 my ($x) = list();
 my $y = scalar list();

Under the above, by perl's specifications, $x is 0(the first value of the list)
and $y is 9(counting @$num), NOT 10! This is contrary to intuition!

And to say more simply, C<sub{}> is also irrelevant.
It's specification of C<CORE::scalar>

 my $zero = 0;
 my $num = [1..9];

 my ($x) = ( $zero, @$num );     # is 0
 my $y = scalar( $zero, @$num ); # is 9

=head2 how to avoid them

Just use an Array, the Anonymous array or C<map> like below:

=over

=item by using a named Array

 my @return = $self->zero(), @{ $self->num() };

=item by using an Anonymous Array

 @{ [ $self->zero(), @{ $self->num() } ] };

=item by using C<map>

 map {$_} $self->zero(), @{ $self->num() };

=back

=head1 SEE ALSO

=over

=item

L<Why do I get the last value in a list in scalar context in perl? - stackoverflow|https://stackoverflow.com/questions/19689393/why-do-i-get-the-last-value-in-a-list-in-scalar-context-in-perl?newreg=b76291905c824a95a0fabaf5a539d0e0>

=item

L<Comma-Operator in perlop|http://perldoc.perl.org/perlop.html#Comma-Operator>

=item

L<日本語の記事を作成しました|https://qiita.com/worthmine/items/a632d124516743950c21>

=back

=head1 LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida(worthmine) E<lt>worthmine@gmail.comE<gt>
