use v5.042;
use utf8;

package MojoX::Demo::HTMX;
use Mojo::Base 'Mojolicious', -signatures;

use MojoX::Demo::Model::Items;

our $VERSION = '0.901';

=encoding utf8

=head1 NAME

MojoX::Demo::HTMX - a demo of using HTMX, in a Mojo app

=head1 SYNOPSIS

To run the demo:

	% morbo script/mojox-demo-htmx

=head1 DESCRIPTION

=over 4

=item * startup

Everything that needs to happen to start the web application.

=back

=head1 SOURCE AVAILABILITY

This module is on Github:

	https://github.com/briandfoy/mojox-demo-htmx

=head1 AUTHOR

brian d foy, C<< <briandfoy@pobox.com> >>

=head1 COPYRIGHT AND LICENSE

Copyright © 2026-2026, brian d foy C<< <briandfoy@pobox.com> >>. All rights reserved.
This software is available under the Artistic License 2.0.

=cut


sub startup ($app) {
	$app->moniker('demo-htmx');
	my $config = $app->plugin('Config');
	$app->secrets($config->{secrets});

	my $model = MojoX::Demo::Model::Items->new;
	$app->helper( model => sub ($c) { $model } );

	$app->renderer->cache->max_keys(0);

	my $r = $app->routes;
	push @{$r->namespaces}, 'MojoX::Demo::Controller';

	$r->get('/')    ->to('Example#main');
	$r->post('/add')->to('Example#add');
	}

1;


__PACKAGE__;
