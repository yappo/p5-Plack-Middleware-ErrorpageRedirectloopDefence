package Plack::Middleware::ErrorpageRedirectloopDefence;
use strict;
use warnings;
use parent qw(Plack::Middleware);
our $VERSION = '0.09';

use Plack::Request;
use Plack::Util::Accessor qw/code/;

my $res_notcontent = [ 204, [ 'Content-Type', 'text/html', 'Content-Length', '0' ], [ '' ] ];

sub call {
    my $self = shift;
    my $env = shift;
    my $req = Plack::Request->new($env);
    my $res = $self->app->($env);
    return $res unless $req->uri eq ($req->header('referer') || '');

    my $code = $self->code;
    return $res unless $code;

    if (((ref $code || '') eq 'Regexp' && $res->[0] =~ $code) || $res->[0].'' eq "$code") {
        return $res_notcontent;
    }
    return $res;
}


1;
__END__

=head1 NAME

Plack::Midelware::ErrorpageRedirectloopDefence -

=head1 SYNOPSIS

    use Plack::Midelware::ErrorpageRedirectloopDefence;

=head1 DESCRIPTION

Plack::Midelware::ErrorpageRedirectloopDefence is

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo {at} shibuya {dot} plE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
