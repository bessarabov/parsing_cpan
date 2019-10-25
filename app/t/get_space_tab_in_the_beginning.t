
package Utils;

use strict;
use warnings FATAL => 'all';
use feature 'say';
use utf8;
use open qw(:std :utf8);

use Test::More;
use Utils;

my @tests = (
    {
        content => '',
        has_space => 0,
        has_tab => 0,
    },
    {
        content => "    use Utils;",
        has_space => 1,
        has_tab => 0,
    },
    {
        content => "\tuse Utils;",
        has_space => 0,
        has_tab => 1,
    },
    {
        content => "  \tuse Utils;",
        has_space => 1,
        has_tab => 1,
    },
    {
        content => "\t  use Utils;",
        has_space => 1,
        has_tab => 1,
    },
    {
        content => "abc\n    use Utils;\ndef",
        has_space => 1,
        has_tab => 0,
    },
    {
        content => "abc\n\tuse Utils;\ndef",
        has_space => 0,
        has_tab => 1,
    },
    {
        content => "abc\n  \tuse Utils;\ndef",
        has_space => 1,
        has_tab => 1,
    },
    {
        content => "abc\n    use Utils;\n\tuse Other;\ndef",
        has_space => 1,
        has_tab => 1,
    },
);

foreach my $t (@tests) {
    is_deeply(
        [get_space_tab_in_the_beginning(split /\n/, $t->{content})],
        [$t->{has_space}, $t->{has_tab}],
        ($t->{description} // ''),
    );
}

done_testing();
