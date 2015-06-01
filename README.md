# NAME

Fib - safe/unsafe signal

# DESCRIPTION

According to [perlipc](https://metacpan.org/pod/perlipc), Perl has two kind of signals:

- safe (deferred)
- unsafe

Nomally, we should use safe signals.
But if you use XS modules, you may want to unsafe signals.

For example, the following code (call `xs_fib(50)` with timeout 1sec)
does not work; never timeout 1sec!

    use Fib;
    eval {
        local $SIG{ALRM} = sub { die "timeout\n" };
        alarm 1;
        xs_fib(50); # xs implimentation of Fibonacci
        alarm 0;
    };
    alarm 0;
    warn $@ if $@;

While, the following code does work expectedly:

    use Sys::SigAction 'timeout_call';
    my $is_timeout = timeout_call 1, sub {
        xs_fib(50);
    };
    warn "timeout\n" if $is_timeout;

Ok, so should we use unsafe signals?
As described in [perlipc](https://metacpan.org/pod/perlipc),
unsafe signals does subject you to possible memory corruption.

And I've experienced memory corruption in real-world code!
See https://github.com/shoichikaji/perl-hang

SO WHAT SHOLD WE DO?

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>
