#!/usr/bin/env perl
use strict;
use warnings;
use Fib;

eval {
    local $SIG{ALRM} = sub { die "timeout\n" };
    alarm 1;
    pp_fib(50);
    alarm 0;
};
alarm 0;
warn $@ if $@;
