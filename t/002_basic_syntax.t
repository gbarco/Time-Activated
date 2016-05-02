use strict;
use warnings;
use Test::More tests => 2;
use Test::Exception;
use Test::MockTime;

use lib '../lib';
use Time::Activated;

my ($always, $before, $after, $between) = (0,0,0,0);

try {

} ctc

lives_ok {
  time_activated {
  } always {
  } before '2017-04-23T18:25:43.511+00:00' {
  } after '2012-04-23T18:25:43.511+00:00' {
  } between '2012-04-23T18:25:43.511+00:00' '2012-04-23T18:25:43.511+00:00' {
  };
}