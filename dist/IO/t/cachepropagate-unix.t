#!/usr/bin/perl

use warnings;
use strict;

use File::Temp qw(tempdir);
use File::Spec::Functions;
use IO::Socket;
use IO::Socket::UNIX;
use Socket;
use Config;
use Test::More;

plan skip_all => "UNIX domain sockets not implemented on $^O"
  if ($^O =~ m/^(?:qnx|nto|vos|MSWin32)$/);

plan tests => 15;

my $socketpath = catfile(tempdir( CLEANUP => 1 ), 'testsock');

# start testing stream sockets:
my $listener = IO::Socket::UNIX->new(Type => SOCK_STREAM,
				     Listen => 1,
				     Local => $socketpath);
ok(defined($listener), 'stream socket created');

my $p = $listener->protocol();
ok(defined($p), 'protocol defined');
my $d = $listener->sockdomain();
ok(defined($d), 'domain defined');
my $s = $listener->socktype();
ok(defined($s), 'type defined');

SKIP: {
    skip "fork not available", 4
	unless $Config{d_fork} || $Config{d_pseudofork};

    my $cpid = fork();
    if (0 == $cpid) {
	# the child:
	sleep(1);
	my $connector = IO::Socket::UNIX->new(Peer => $socketpath);
	exit(0);
    } else {
	ok(defined($cpid), 'spawned a child');
    }

    my $new = $listener->accept();

    $TODO = "this information isn't cached for accepted sockets";
    is($new->sockdomain(), $d, 'domain match');
  SKIP: {
      skip "no Socket::SO_PROTOCOL", 1 if !defined(eval { Socket::SO_PROTOCOL });
      is($new->protocol(), $p, 'protocol match');
    }
  SKIP: {
      skip "no Socket::SO_TYPE", 1 if !defined(eval { Socket::SO_TYPE });
      is($new->socktype(), $s, 'type match');
    }

    unlink($socketpath);
    wait();
}

undef $TODO;
# now test datagram sockets:
$listener = IO::Socket::UNIX->new(Type => SOCK_DGRAM,
				  Local => $socketpath);
ok(defined($listener), 'datagram socket created');

$p = $listener->protocol();
ok(defined($p), 'protocol defined');
$d = $listener->sockdomain();
ok(defined($d), 'domain defined');
$s = $listener->socktype();
ok(defined($s), 'type defined');

my $new = IO::Socket::UNIX->new_from_fd($listener->fileno(), 'r+');

$TODO = "this information isn't cached for new_from_fd sockets";
is($new->sockdomain(), $d, 'domain match');
SKIP: {
    skip "no Socket::SO_PROTOCOL", 1 if !defined(eval { Socket::SO_PROTOCOL });
    is($new->protocol(), $p, 'protocol match');
}
SKIP: {
    skip "no Socket::SO_TYPE", 1 if !defined(eval { Socket::SO_TYPE });
    is($new->socktype(), $s, 'type match');
}
unlink($socketpath);
