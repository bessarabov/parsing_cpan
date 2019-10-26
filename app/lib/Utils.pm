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
	seconds2text
    get_db_name
);
our @EXPORT = @EXPORT_OK;

sub get_db_name {
    return 'cpan';
}

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
        database => get_db_name(),
        user => 'root',
        password => '',
        host => 'mysql',
        port => 3306,
        connection_check_threshold => 30,
    );
}

=head2 seconds2text

=cut

sub seconds2text {
    my ($full_seconds) = @_;

    my $text;

    my $left_seconds = $full_seconds;

    my $days = int($left_seconds / (24*60*60));
    $left_seconds = $left_seconds - $days*(24*60*60);

    my $hours = int($left_seconds / (60*60));
    $left_seconds = $left_seconds - $hours*(60*60);

    my $minutes = int($left_seconds / (60));
    $left_seconds = $left_seconds - $minutes*(60);

    my $need;

    if ($days) {
        $text .= sprintf "%sd",
            $days,
            ;
        $need = 1;
    }

    if ($need || $hours) {
        $text .= sprintf "%02dh",
            $hours,
            ;
        $need = 1;
    }

    if ($need || $minutes) {
        $text .= sprintf "%02dm",
            $minutes,
            ;
    }

    $text .= sprintf "%02ds",
            $left_seconds,
            ;

    $text =~ s/^0//;

    return $text;
}

1;
