package Flickr::Test::Straps;

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

use base Test::Harness::Straps;

sub _command_line {
    my $self = shift;
    my $file = shift;

    my $command =  $self->_command($file);
    my $switches = $self->_switches($file);

    $file = qq["$file"] if ($file =~ /\s/) && ($file !~ /^".*"$/);
    my $line = "$command $switches $file";

#    print "\ncommand: $line\n";

    return $line;
}

sub _command {
	
    my $php = ($^O =~ /cygwin/) ? '/cygdrive/c/php-4.3.11-Win32/php.exe' : 'php';

    return "$php -q -d include_path='$Flickr::Test::PhpIncDir'" if $_[1] =~ /\.php/;

    return Test::Harness::Straps::_command(@_);
}

sub _switches {
    my($self, $file) = @_;

    return '' if $file =~ m/\.php/;

    return Test::Harness::Straps::_switches($self, $file);
}

1;
