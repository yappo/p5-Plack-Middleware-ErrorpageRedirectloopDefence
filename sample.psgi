#!/usr/bin/env perl
use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');

use Plack::Builder;
use Plack::Request;

my $html = <<'HTML';
<html>
    <head>
        <title>error</title>
        <meta http-equiv="refresh" content="3;URL=%s">
    </head>
    <body>now: %d, %s</body>
</html>
HTML

builder {
    enable 'ErrorpageRedirectloopDefence',
        code => qr/[45]\d\d/;
#        code => '502';

    sub {
        my $req = Plack::Request->new(shift);
        my $body = sprintf $html, $req->uri, time(), $req->uri;
        if ($req->path eq '/ok') {
            return [ 200, [ 'Content-Type', 'text/html', 'Content-Length', length($body) ], [ $body ] ];
        } else {
            return [ 502, [ 'Content-Type', 'text/html', 'Content-Length', length($body) ], [ $body ] ];
        }
    };
};

