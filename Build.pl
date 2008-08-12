use Module::Build;

my $build = Module::Build->new(
	module_name => 'Flickr::Test',
	requires => {
		#'Some::Module'  => '1.23',
	},
);
$build->add_build_element('php');
$build->create_build_script;
