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
	# This code is probably too simple. 
	# 
	# I know there's PHP unit testing libraries out there but I don't know 
	# which ones are any good, and I don't know which ones will work with
	# perl's Test::Harness.
	#
	# Until then, I guess that some less-that-perfectly-structured tests 
	# are better than no tests at all, so made this
	#
	# I see Kellan has written some tests with simpletest, but, um,
	# LOOK! OVER THERE! A PLANE!
	#
	# Don't like it? Make it better...
	#
	
	$GLOBALS['__hackytest_testid'] = 1;
	
	
	function plan($n) {
		print "1..$n\n";
	}
	
	function ok($test,$message, $error='') {
		$i = $GLOBALS['__hackytest_testid']++;
		if($test) {
			print("ok $i - $message\n");
		} else {
			print("not ok $i - $message\n");
			if($error) {
				print("#   $error\n");
			}
		}
	
	}

	function is($test1, $test2, $message) {
		$error = _hackytest_compare($test1,$test2,'==');
		ok($error==='',$message, $error);
	}

	function isnt($test1, $test2, $message) {
		$error = _hackytest_compare($test1,$test2,'!=');
		ok($error==='',$message, $error);
	}


	function is_exact($test1, $test2, $message) {
		$error = _hackytest_compare($test1,$test2,'===');
		ok($error==='',$message, $error);
	}

	function isnt_exact($test1, $test2, $message) {
		$error = _hackytest_compare($test1,$test2,'!==');
		ok($error==='',$message, $error);
	}

	function _hackytest_compare($var1, $var2, $operator) {
		
		# objects always fail (because we're lazy)
		if (is_object($var1) || is_object($var2)) {
			return "object comparison doesn't work yet, if you need it code it yourself";
		}
		
		# handle != and !== by negating the response from == and ===
		if($operator == '!=') {
			$test = _hackytest_compare($var1, $var2, "==");
			return(($test)?'':'$var1 == $var2');
		}
		
		if($operator == '!==') {
			$test = _hackytest_compare($var1, $var2, "===");
			return(($test)?'':'$var1 === $var2');
		}
		
		# sanity check the remaining operators, just in case
		if (!in_array($operator,array('==','==='))) {
			return "$operator is not a valid operator";
		}
		
		#
		# special case types
		#
		if (is_array($var1) || is_array($var2)) {
			return _hackytest_compare_array($var1, $var2, $operator);
		}
		
		#
		# everything else
		#

		eval("\$ok = \$var1 $operator \$var2;");
		$negated = ($operator == '===')?'!==':'!=';
		return ($ok)?'':"$var1 $negated $var2";
	}
	
	function _hackytest_compare_array($var1, $var2, $operator) {
		if (! (is_array($var1) && is_array($var2)) ) {
			return "$var1 and $var2 are not both arrays";
		}
		
		# check they have the same keys
		foreach(array_keys($var1) as $key) {
			if(!isset($var2[$key])) {
				return("$var2 doesn't contain $key");
			}
		}
		foreach(array_keys($var2) as $key) {
			if(!isset($var1[$key])) {
				return("$var1 doesn't contain $key");
			}
		}
		
		# check the values in $var1
		foreach($var1 as $k => $v) {
			$error = _hackytest_compare($var1[$k], $var2[$k], $operator);
			if($error !== '') { 
				return $error; 
			}
		}
		
		return '';

	}


?>
