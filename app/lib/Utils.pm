package Utils;

use strict;
use warnings FATAL => 'all';
use feature 'say';
use utf8;
use open qw(:std :utf8);

use SQL::Easy;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
    get_space_tab_in_the_beginning
    get_se_mysql
    get_se_cpan
);
our @EXPORT = @EXPORT_OK;

sub get_space_tab_in_the_beginning {
    my (@lines) = @_;

    my $has_space = 0;
    my $has_tab = 0;

    foreach my $line (@lines) {
        my ($beginning) = $line =~ /^([\t ]+)[^ \t]/;
        $beginning //= '';

        if ($beginning =~ / /) {
            $has_space = 1;
        }
        if ($beginning =~ /\t/) {
            $has_tab = 1;
        }
    }

    return ($has_space, $has_tab);
}

sub get_se_mysql {
    my $se = SQL::Easy->new(
        database => 'mysql',
        user => 'root',
        password => '',
        host => 'mysql',
        port => 3306,
        connection_check_threshold => 30,
    );
}

sub get_se_cpan {
    my $se = SQL::Easy->new(
        database => 'cpan',
        user => 'root',
        password => '',
        host => 'mysql',
        port => 3306,
        connection_check_threshold => 30,
    );
}

1;
