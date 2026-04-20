package MojoX::Demo::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;


sub welcome ($c) {
	my $items = $c->model->items;
	my %vars = (
		items   => $c->model->items,
		title   => 'HTMX demo on Mojolicious',
		content => 'This is the content',
		);
	$c->render( template => 'main_spa', format => 'html', %vars );
	}

sub add ($c) {
	my $item = $c->model->add(
		label       => $c->param('label'),
		description => $c->param('description'),
		);

	$c->render( template => 'partials/list-item', format => 'html', item => $item );
	}

__PACKAGE__;
