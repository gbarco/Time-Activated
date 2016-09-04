use strict;
use warnings;
use Test::More tests => 2;
use Test::MockTime qw();

use Time::Activated;

subtest 'Exact moments with after and before' => sub {
	plan tests => 4;

	Test::MockTime::set_absolute_time('2000-01-01T00:00:00Z');

	time_activated
		after '2000-01-01T00:00:00' => execute { pass('After matches exact moment') },
		before '2000-01-01T00:00:00' => execute { fail('After matches exact moment') };

	time_activated
		after '2000-01-01T00:00:00-00:00' => execute { pass('After matches exact moment with TZ +0') },
		after '2000-01-01T00:00:00+01:00' => execute { pass('After matches exact moment with TZ +1') },
		after '2000-01-01T00:00:00-01:00' => execute { fail('After matches exact moment with TZ -1') },
		before '2000-01-01T00:00:00-00:00' => execute { fail('Before matches exact moment with TZ +0') },
		before '2000-01-01T00:00:00+01:00' => execute { fail('Before matches exact moment with TZ +1') },
		before '2000-01-01T00:00:00-01:00' => execute { pass('Before matches exact moment with TZ -1') },
};

subtest 'Exact moments with between' => sub {
	plan tests => 2;

	Test::MockTime::set_absolute_time('2000-01-01T00:00:00Z');
	time_activated
		between '2000-01-01T00:00:00' => '2001-01-01T00:00:00' => execute { pass('Between matches exact beggining') };

	Test::MockTime::set_absolute_time('2001-01-01T00:00:00Z');
	time_activated
		between '2000-01-01T00:00:00' => '2001-01-01T00:00:00' => execute { pass('Between matches exact endding') };
};

