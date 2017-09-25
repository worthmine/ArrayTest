# NAME

ArrayTest - perl CORE::scaler MAY have a bug

# SYNOPSIS

[`perl t/00_compile.t` ](https://github.com/worthmine/ArrayTest/blob/master/t/00_compile.t) will never succeed. Why not?

# DESCRIPTION

I wonder why do these tests fail.

## [diff lib/ArrayTest.pm lib/ArrayTest2.pm](https://github.com/worthmine/ArrayTest/blob/master/diff.txt) is below:
``` diff.txt
1c1
< package ArrayTest;
---
> package ArrayTest2;
16c16
<     my @list = ( $self->zero(), @{ $self->num() } );
---
>     ( $self->zero(), @{ $self->num() } );
```

The joined value with ' ' is same,
And trying to `note explain`  succeeded, I got 10 references.
So there must be 10 references in what these return.
But CORE::scalar() returns 9 with ArrayTest2.pm!

# LICENSE

Copyright (C) Yuki Yoshida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yuki Yoshida <worthmine@gmail.com>
