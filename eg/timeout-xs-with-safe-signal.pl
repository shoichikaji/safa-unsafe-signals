#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Fib;

eval {
    local $SIG{ALRM} = sub { die "timeout\n" };
    alarm 1;
    xs_fib(50);
    alarm 0;
};
alarm 0;
warn $@ if $@;
