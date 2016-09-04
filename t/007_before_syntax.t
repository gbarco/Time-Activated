use strict;
use warnings;
use Test::More tests => 3;
use Test::MockTime qw();

use Time::Activated;

subtest 'Before simple syntax' => sub {
	plan tests => 2;
	Test::MockTime::set_absolute_time('9998-12-31T01:00:00Z');

	time_activated
		before '9999', execute { pass('Before simple syntax iso8601 year based') };

	time_activated
		before '9999-01-01T00:00:00', execute { pass('Before simple syntax iso8601 full no timezone') };

	time_activated
		before '9998-01-01T00:00:00', execute { fail('Before simple syntax iso8601 full no timezone past') };

	Test::MockTime::set_absolute_time('9998-12-31T00:00:00Z');

	time_activated
		before '9998-12-31T00:00:00', execute { fail('Before simple syntax iso8601 full no timezone past FF -1 hour') };
};

subtest 'Before complex syntax' => sub {
	plan tests => 4;
	Test::MockTime::set_absolute_time('9998-12-31T01:00:00Z');

	time_activated
		before '9999', execute { pass('Before complex syntax iso8601 year based') },
		before '9999-01-01T00:00:00', execute { pass('Before complex syntax iso8601 full no timezone') },
		before '9998-01-01T00:00:00', execute { fail('Before complex syntax iso8601 full no timezone past FF +1 hour') };

	Test::MockTime::set_absolute_time('9998-12-31T02:00:00Z');

	time_activated
		before '9999', execute { pass('Before complex syntax iso8601 year based FF -1 hour') },
		before '9998-12-31T03:00:00', execute { pass('Before complex syntax iso8601 full no timezone FF -1 hour') },
		before '9998-12-31T00:00:00', execute { fail('Before complex syntax iso8601 full no timezone past FF -1 hour') };
};

subtest 'Before fancy syntax' => sub {
	plan tests => 4;
	Test::MockTime::set_absolute_time('9998-12-31T01:00:00Z');

	time_activated
		before '9999' => execute { pass('Before complex syntax iso8601 year based') },
		before '9999-01-01T00:00:00' => execute { pass('Before complex syntax iso8601 full no timezone') },
		before '9998-01-01T00:00:00' => execute { fail('Before complex syntax iso8601 full no timezone past FF +1 hour') };

	Test::MockTime::set_absolute_time('9998-12-31T02:00:00Z');

	time_activated
		before '9999' => execute { pass('Before complex syntax iso8601 year based FF -1 hour') },
		before '9998-12-31T03:00:00' => execute { pass('Before complex syntax iso8601 full no timezone FF -1 hour') },
		before '9998-12-31T01:00:00' => execute { fail('Before complex syntax iso8601 full no timezone past FF -1 hour') };
};
