# mt-aws-glacier - Amazon Glacier sync client
# Copyright (C) 2012-2013  Victor Efimov
# http://mt-aws.com (also http://vs-dev.com) vs@vs-dev.com
# License: GPLv3
#
# This file is part of "mt-aws-glacier"
#
#    mt-aws-glacier is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    mt-aws-glacier is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

package App::MtAws::ProxyTask;

our $VERSION = '1.051';

use strict;
use warnings;
use utf8;


sub new
{
	my ($class, %args) = @_;
	my $self = \%args;

	my $task = $self->{task}||die;
	my $id = $self->{id}||die;
	my $jobid = $self->{jobid}||die;

	$self = $task;

	$self->{_stack} ||= [];
	push @{ $self->{_stack} }, { id => $self->{id}, jobid => $self->{jobid} };

	$self->{id} = $id;
	$self->{jobid} = $jobid;

	bless $self, $class;
	defined($self->{id})||die;
	return $self;
}

sub pop
{
	my ($self) = @_;
	my $stack = $self->{_stack};
	my $s = pop @$stack;
	$self->{id} = $s->{id};
	$self->{jobid} = $s->{jobid};
	$self;
}
	
1;
