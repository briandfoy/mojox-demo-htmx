use v5.42;
package MojoX::Demo::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;

=encoding utf8

=head1 NAME

MojoX::Demo::Controller::Example - the controller for this demonstration

=head1 SYNOPSIS

To run the demo:

	% morbo script/mojox-demo-htmx

=head1 DESCRIPTION

=over 4

=item * main

Render the main page

=item * add

Handle the HTMX response

=back

=head1 SOURCE AVAILABILITY

This module is on GitHub:

	https://github.com/briandfoy/mojox-demo-htmx

=head1 AUTHOR

brian d foy, C<< <briandfoy@pobox.com> >>

=head1 COPYRIGHT AND LICENSE

Copyright © 2026-2026, brian d foy C<< <briandfoy@pobox.com> >>. All rights reserved.
This software is available under the Artistic License 2.0.

=cut

sub main ($c) {
	my $items = $c->model->items;
	my %vars = (
		items   => $c->model->items,
		title   => 'HTMX demo on Mojolicious',
		content => 'This is the content',
		);
	$c->render( template => 'main_spa', format => 'html', %vars );
	}

sub activate ($c) {
	my $id = $c->param('id');
	$c->app->log->debug( "In activate for <$id>" );

	my $item = $c->model->activate($id);
	$c->render( template => 'partials/list-item', format => 'html', item => $item );
	}

sub add ($c) {
	my $item = $c->model->add(
		label       => $c->param('label'),
		description => $c->param('description'),
		);

	$c->render( template => 'partials/list-item', format => 'html', item => $item );
	}

sub deactivate ($c) {
	my $id = $c->param('id');
	$c->app->log->debug( "In deactivate for <$id>" );

	my $item = $c->model->deactivate($id);
	$c->render( template => 'partials/list-item', format => 'html', item => $item );
	}

sub delete ($c) {
	my $id = $c->param('id');
	$c->app->log->debug( "In delete for <$id>" );

	$c->model->delete($id);
	$c->render( template => 'partials/deleted-list-item', format => 'html' );
	}

sub edit ($c) {
	my $id = $c->param('id');
	$c->app->log->debug( "In edit for <$id>" );

	my $item = $c->model->get($id);

	$c->render( template => 'partials/edit-list-item', format => 'html', item => $item );
	}

sub save ($c) {
	my $id = $c->param('id');
	$c->app->log->debug( "In save for <$id>" );

	if( $c->param('action') eq 'save' ) {
		$c->model->update( $id, $c->param('label'), $c->param('description') );
		}

	$c->render( template => 'partials/list-item', format => 'html', item => $c->model->get($id) );
	}

__PACKAGE__;
