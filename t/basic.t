use strict;
use warnings;

use Test::More 0.96;
use Test::Deep;

use Test::DZil;

my $dist_ini = dist_ini(
    {
        name     => 'DZT-Sample',
        abstract => 'Sample DZ Dist',
        author   => 'E. Xavier Ample <example@example.org>',
        license  => 'Perl_5',
        copyright_holder => 'E. Xavier Ample',
        version => '1.0.0',
    },
    qw/
        GatherDir
    /,
    [ 'Travis::ConfigForReleaseBranch' => { } ],
);

my $tzil = Builder->from_config(
    { dist_root => 't/corpus' },
    { add_files => { 'source/dist.ini' => $dist_ini } },
);

$tzil->build;

like $tzil->slurp_file( 'build/.travis.yml' ), qr/language: perl/,
    ".travis.yml exists and looks ok";

done_testing;
