use strict;
use warnings;
use Test::More tests => 4;
use Test::MockTime qw();

use Time::Activated;
use DateTime;

subtest 'Fancy multiline syntax iso8601' => sub {
    Test::MockTime::set_absolute_time('1986-05-27T00:00:00Z');

	time_activated
		after '1985-01-01T00:00:00+00:00', execute { pass('Basic after') },
	    before '1986-12-31T00:00:00+00:00', execute { pass('Basic before') },
		between '1985-01-01T00:00:00+00:00', '1986-12-31T00:00:00+00:00', execute { pass('Basic between') };
};

subtest 'Fancy DateTime syntax' => sub {
    my $past = DateTime::Infinite::Past->new();
    my $future = DateTime::Infinite::Future->new();

    time_activated after $past, execute { pass('After simple syntax DT past') };
    time_activated after $future, execute { fail('After simple syntax DT future should never be in the past') };
};

subtest 'Fancy multiline abusing hash iso8601' => sub {
    Test::MockTime::set_absolute_time('1986-05-27T00:00:00Z');

	time_activated
		after '1985-01-01T00:00:00+00:00' => execute { pass('Basic after') },
	    before '1986-12-31T00:00:00+00:00' => execute { pass('Basic before') },
		between '1985-01-01T00:00:00+00:00' => '1986-12-31T00:00:00+00:00' => execute { pass('Basic between') };
};

subtest 'Fancy conditions with external subs' => sub {
	plan tests => 4;

	Test::MockTime::set_absolute_time('2001-01-01T00:00:00Z');

	time_activated
		after '2001' => execute \&external_condition_pass;

	time_activated
		after '2001' => execute {&external_condition_pass('External conditions')};

	time_activated
		after '2001' => execute (\&external_condition_pass),
		after '2000' => execute (\&external_condition_pass),
		after '2002' => execute \&external_condition_fail;
};

sub external_condition_pass {
	pass($_[0]);
}

sub external_condition_fail {
	fail($_[0]);
}
