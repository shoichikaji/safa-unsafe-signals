#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Fib;

use Sys::SigAction 'timeout_call';

my $is_timeout = timeout_call 1, sub {
    xs_fib(50);
};
warn "timeout\n" if $is_timeout;
