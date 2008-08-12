package Flickr::Test;

#
# $Id$
#
# Flickr::Test - A multi-language test framework
#
# Copyright (c) 2007-2008 Yahoo! Inc.  All rights reserved.  This library is
# free software; you can redistribute it and/or modify it under the terms of
# the GNU General Public License (GPL), version 2 only.  This library is
# distributed WITHOUT ANY WARRANTY, whether express or implied. See the GNU
# GPL for more details (http://www.gnu.org/licenses/gpl.html)
#

use vars qw(@ISA @EXPORT $PhpDir $PhpIncDir);
use Exporter;
@ISA = ('Exporter');
@EXPORT = qw(&runtests);

our $VERSION = 1.00_01;

use Test::Harness;
use Flickr::Test::Straps;

sub runtests {

	#
	# need to find out where we keep our PHP files
	#

	$Flickr::Test::PhpDir = '';

	for my $path (@INC){
		if (-e "$path/Flickr/Test/Straps.php"){
			$Flickr::Test::PhpDir = $path;
		}
	}


	#
	# get the existing PHP include dir and build a new one
	#

	my $current_php = `php -r "echo ini_get('include_path');"`;

	$Flickr::Test::PhpIncDir = $current_php.":.:".$Flickr::Test::PhpDir;


	#
	# todo: make this configurable?
	#

	$Test::Harness::verbose=1;

	bless $Test::Harness::Strap, 'Flickr::Test::Straps';

	if (@ARGV){
		Test::Harness::runtests @ARGV;
	}else{
		@tests = (glob("t/*.t"), glob("t/*/*.t"));
		Test::Harness::runtests @tests;
	}
}

1;
