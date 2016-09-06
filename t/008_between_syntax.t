use strict;
use warnings;
use Test::More tests => 3;
use Test::MockTime qw();

use Time::Activated;

subtest 'Between simple syntax' => sub {
	plan tests => 4;
	Test::MockTime::set_absolute_time('9999-01-01T01:00:00Z');

	time_activated
		between '9999', '9999-01-01T02:00:00', execute { pass('Between simple syntax iso8601 year based') };

	time_activated
		between '9999-01-01T00:00:00', '9999-01-01T02:00:00', execute { pass('Between simple syntax iso8601 full no timezone') };

	time_activated
		between '9999-01-01T02:00:00', '9999-01-01T00:00:00', execute { pass('Between simple syntax iso8601 full no timezone mixed after/before') };

	time_activated
		between '9999-01-01T01:30:00', '9999-01-01T02:00:00', execute { fail('Between simple syntax iso8601 full no timezone future') };

	time_activated
		between '9999-01-01T02:00:00', '9999-01-01T01:30:00', execute { fail('Between simple syntax iso8601 full no timezone future after/before') };

	Test::MockTime::set_absolute_time('9999-01-01T02:00:00Z');
	time_activated
		between '9999-01-01T02:00:00', '9999-01-01T00:00:00', execute { pass('Between simple syntax iso8601 full no timezone future FF +1 hour') };
};

subtest 'Between complex syntax' => sub {
	plan tests => 8;

	Test::MockTime::set_absolute_time('9999-01-01T01:00:00Z');
	time_activated
		between '9999', '9999-01-01T02:00:00', execute { pass('Between complex syntax iso8601 year based') },
		between '9999-01-01T00:00:00', '9999-01-01T02:00:00', execute { pass('Between complex syntax iso8601 full no timezone') },
		between '9999-01-01T02:00:00', '9999-01-01T00:00:00', execute { pass('Between complex syntax iso8601 full no timezone mixed after/before') },
		between '9999-01-01T01:30:00', '9999-01-01T02:00:00', execute { fail('Between complex syntax iso8601 full no timezone future') },
		between '9999-01-01T02:00:00', '9999-01-01T01:30:00', execute { fail('Between complex syntax iso8601 full no timezone future after/before') };

	Test::MockTime::set_absolute_time('9999-01-01T02:00:00Z');
	time_activated
		between '9999', '9999-01-01T02:00:00', execute { pass('Between complex syntax iso8601 year based FF +1') },
		between '9999-01-01T00:00:00', '9999-01-01T02:00:00', execute { pass('Between complex syntax iso8601 full no timezone FF +1') },
		between '9999-01-01T02:00:00', '9999-01-01T00:00:00', execute { pass('Between complex syntax iso8601 full no timezone mixed after/before FF +1') },
		between '9999-01-01T01:30:00', '9999-01-01T02:00:00', execute { pass('Between complex syntax iso8601 full no timezone future FF +1') },
		between '9999-01-01T02:00:00', '9999-01-01T01:30:00', execute { pass('Between complex syntax iso8601 full no timezone future after/before FF +1') };
};

subtest 'Between fancy syntax' => sub {
	plan tests => 8;

	Test::MockTime::set_absolute_time('9999-01-01T01:00:00Z');
	time_activated
		between '9999' => '9999-01-01T02:00:00' => execute { pass('Between fancy syntax iso8601 year based') },
		between '9999-01-01T00:00:00' => '9999-01-01T02:00:00' => execute { pass('Between fancy syntax iso8601 full no timezone') },
		between '9999-01-01T02:00:00' => '9999-01-01T00:00:00' => execute { pass('Between fancy syntax iso8601 full no timezone mixed after/before') },
		between '9999-01-01T01:30:00' => '9999-01-01T02:00:00' => execute { fail('Between fancy syntax iso8601 full no timezone future') },
		between '9999-01-01T02:00:00' => '9999-01-01T01:30:00' => execute { fail('Between fancy syntax iso8601 full no timezone future after/before') };

	Test::MockTime::set_absolute_time('9999-01-01T02:00:00Z');
	time_activated
		between '9999' => '9999-01-01T02:00:00' => execute { pass('Between fancy syntax iso8601 year based FF +1') },
		between '9999-01-01T00:00:00' => '9999-01-01T02:00:00' => execute { pass('Between fancy syntax iso8601 full no timezone FF +1') },
		between '9999-01-01T02:00:00' => '9999-01-01T00:00:00' => execute { pass('Between fancy syntax iso8601 full no timezone mixed after/before FF +1') },
		between '9999-01-01T01:30:00' => '9999-01-01T02:00:00' => execute { pass('Between fancy syntax iso8601 full no timezone future FF +1') },
		between '9999-01-01T02:00:00' => '9999-01-01T01:30:00' => execute { pass('Between fancy syntax iso8601 full no timezone future after/before FF +1') };
};
