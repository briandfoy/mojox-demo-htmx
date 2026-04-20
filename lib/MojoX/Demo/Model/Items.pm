use v5.42;
use utf8;

package MojoX::Demo::Model::Item {
	use Mojo::Base -base;
	has $_ for qw(uuid label description epoch_added);

	sub date_added ($self) { localtime($self->epoch_added) }

	sub TO_JSON ($self) {
			my %hash = $self->%*;
			\%hash;
		}
	}

package MojoX::Demo::Model::Items;
use Data::UUID;
use Mojo::File;
use Mojo::JSON qw(decode_json encode_json);

sub DESTROY ($self) { $self->save }

sub new ($class, $file = 'items.json') {
	my $items = do {
		if( -e $file ) {
		print STDERR "reading file\n";
			my $contents = Mojo::File->new($file)->slurp;
			$contents = [] unless length $contents;
			my $decoded = eval { decode_json($contents) } // [];
			[ map { MojoX::Demo::Model::Item->new($_) } grep { ref } $decoded->@* ];
			}
		else { [] }
		};

	my $self = bless { items => $items, file => $file }, $class;
	say STDERR Dumper($self); use Data::Dumper;
	return $self;
	}

sub add ($self, %hash) {
	my $item = MojoX::Demo::Model::Item->new(
		uuid        => Data::UUID->new->create_str,
		label       => $hash{'label'},
		description => $hash{'description'},
		epoch_added => time,
		);
print STDERR "ITEM: " . Mojo::Util::dumper($item);

	push $self->items->@*, $item;
	$self->save;
	return $item;
	}

sub items ($self) { $self->{'items'} }

sub save ($self) {
	print STDERR "SAVE: " . Mojo::Util::dumper($self);
	Mojo::File->new( $self->{'file'} )->spurt( encode_json($self->items) );
	$self;
	}

__PACKAGE__;
