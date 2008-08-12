use Test::More;

BEGIN {
	@::modules = (
		'Flickr::Test',
		'Flickr::Test::Straps',
	);

	plan tests => 3 * scalar @::modules;

	use_ok( $_ ) for @::modules;
}

require_ok( $_ ) for @::modules;

isa_ok(eval "$_->new();", $_) for @::modules;
