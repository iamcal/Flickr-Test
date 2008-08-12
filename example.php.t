<?php
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

	#
	# this will magically be in the include path when
	# the test harness runs this code
	#

	include('Flickr/Test/Straps.php');


	plan(3);

	ok(1, 'woo');
	is(2, 2, 'yay');
	isnt(3, 4, 'hoopla');
?>
