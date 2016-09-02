use strict;
use warnings;
use Test::More tests => 1;
use Test::MockTime qw();

use Time::Activated;

subtest 'Basic syntax iso8601' => sub {
	plan tests => 2;

	use constant PROCESS_X_CUTOVER_DATE => '2016-05-25T13:30:00Z';

	Test::MockTime::set_absolute_time('1986-05-27T00:00:00Z');
	time_activated before PROCESS_X_CUTOVER_DATE, execute { pass('Before using constants') };
	
	Test::MockTime::set_absolute_time(PROCESS_X_CUTOVER_DATE);
	time_activated before PROCESS_X_CUTOVER_DATE, execute { fail('Before should not trigger on exact cutover date') };
	
	Test::MockTime::set_absolute_time(PROCESS_X_CUTOVER_DATE);
	time_activated after PROCESS_X_CUTOVER_DATE, execute { pass('After using constants') };
};
