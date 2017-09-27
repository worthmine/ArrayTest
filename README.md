# NAME

ArrayTest - perl CORE::scaler has strange specifications

# SYNOPSIS

`perl t/00_compile.t` will never succeed. Why not?

# DESCRIPTION

I wonder why do these tests fail.

## what's the matter?

`diff lib/ArrayTest.pm lib/ArrayTest2.pm` without POD is below:

    1c1
    < package ArrayTest;
    ---
    > package ArrayTest2;
    16c16
    <     my @list = ( $self->zero(), @{ $self->num() } );
    ---
    >     ( $self->zero(), @{ $self->num() } );

The joined value with ' ' is same,
And trying to `note explain` succeeded, I got 10 references.

So there must be 10 references in what these return.
But CORE::scalar() returns 9 with ArrayTest2.pm.

It was too strange for me.

## But it's the specifications

According to [perldoc](http://perldoc.perl.org/perlop.html#Comma-Operator),

    Comma Operator

    Binary "," is the comma operator. In scalar context it evaluates its left
    argument, throws that value away, then evaluates its right argument and
    returns that value.
    This is just like C's comma operator. In list context, it's just the list
    argument separator, and inserts both its arguments into the list.
    These arguments are also evaluated from left to right.

namely, `( $self->zero(), @{ $self->num() } )` and ifever, `return ( $self->zero(), @{ $self->num() } )` mean below:

    $self->zero();
    @{ $self->num() };

So they return only `@{ $self->num() }` **in scalar context**

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

And to say more simply, `sub{}` is also irrelevant.
It's specification of `CORE::scalar`

    my $zero = 0;
    my $num = [1..9];

    my ($x) = ( $zero, @$num );     # is 0
    my $y = scalar( $zero, @$num ); # is 9

I heard It's the specification affected from C.
But I think **it's almost bug**

## how to avoid them

Just use an Array, the Anonymous array or `map` like below:

- by using a named Array

        my @return = $self->zero(), @{ $self->num() };

- by using an Anonymous Array

        @{ [ $self->zero(), @{ $self->num() } ] };

- by using `map`

        map {$_} $self->zero(), @{ $self->num() };

# SEE ALSO

- [Why do I get the last value in a list in scalar context in perl? - stackoverflow](https://stackoverflow.com/questions/19689393/why-do-i-get-the-last-value-in-a-list-in-scalar-context-in-perl?newreg=b76291905c824a95a0fabaf5a539d0e0)
- [Comma-Operator in perlop](http://perldoc.perl.org/perlop.html#Comma-Operator)
- [日本語の記事を作成しました](https://qiita.com/worthmine/items/a632d124516743950c21)

# LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yuki Yoshida(worthmine) <worthmine@gmail.com>
