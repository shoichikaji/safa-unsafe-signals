package Fib;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

use Exporter 'import';
our @EXPORT = qw(xs_fib pp_fib);

sub pp_fib {
    my $n = shift;
    if ($n == 0 || $n == 1) {
        return 1;
    } else {
        return pp_fib($n-2) + pp_fib($n-1);
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Fib - safe/unsafe signal

=head1 DESCRIPTION

According to L<perlipc>, Perl has two kind of signals:

=over 4

=item * safe (deferred)

=item * unsafe

=back

Nomally, we should use safe signals.
But if you use XS modules, you may want to unsafe signals.

For example, the following code (call C<xs_fib(50)> with timeout 1sec)
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
As described in L<perlipc>,
unsafe signals does subject you to possible memory corruption.

And I've experienced memory corruption in real-world code!
See https://github.com/shoichikaji/perl-hang

SO WHAT SHOLD WE DO?

=head1 SEE ALSO

L<perlipc|http://perldoc.perl.org/perlipc.html#Deferred-Signals-(Safe-Signals%29>

L<http://blogs.perl.org/users/leon_timmermans/2012/01/what-you-should-know-about-signal-based-timeouts.html>

L<http://perl-users.jp/articles/advent-calendar/2009/data-model/03.html>

L<http://lestrrat.ldblog.jp/archives/23209118.html>

L<http://lestrrat.ldblog.jp/archives/23209250.html>

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

