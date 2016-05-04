use strict;
use warnings;
use Test::More tests => 2;
use Test::Exception;
use Test::MockTime;
use Try::Tiny;

use lib 'lib';
use lib '../lib';

use Time::Activated;
use DateTime;

time_activated
  after '00:00', execute { pass('After simple syntax iso8601 relative time') };

my $past = DateTime::Infinite::Past->new();

time_activated
  after $past, execute { pass('After simple syntax DT past') };

my $future = DateTime::Infinite::Future->new();

time_activated
  after $future, execute { fail('After simple syntax DT future should never be in the past') };

#time_activated
#  after DateTime::Infinite::Past->new(), execute { pass('After simple syntax 1st born') };
  #after '2018', execute { pass('After simple syntax 2nd sibling') };
  #after '2019', execute { pass('After simple syntax 3rd instance') };

#time_activated
#  before '2017', execute { pass('Before simple syntax') };

#time_activated
#  before('2016', sub { ok('Before 2016.')}),
#  before('2017', sub { ok('Before called from fetus in fetus.')}),
#  before('2017', sub { ok('Before called from fetus in fetus in... fetus.')});

  #after {
  #  print 1;
  #} '2016';
  #
  #try {
  #
  #} catch {
  #
  #};