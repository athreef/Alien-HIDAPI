use Alien::Base::ModuleBuild;
use Config;
use Alien::autoconf;
use Alien::automake;
use Alien::libtool;
use Alien::libudev;
use Alien::LibUSBx;

use Env qw( @PATH );

unshift @ENV, Alien::automake->bin_dir, Alien::autoconf->bin_dir, Alien::libtool->bin_dir;

my $build = Alien::Base::ModuleBuild->new(
    module_name => 'Alien::HIDAPI',
    license => 'perl',
    alien_bin_requires => {
    },
    configure_requires => {
        'Alien::Base::ModuleBuild' => 0,
        'Module::Build' => 0,
    },
    build_requires => {
        # TODO: fallback to HTTP download when IO::Socket::SSL doesn't exist
        'IO::Socket::SSL' => 0,

        "Alien::autoconf" => "0.02",
        "Alien::automake" => "0.02",
        "Alien::libtool" => "0.02",

        $^O eq 'linux' ? ('Alien::LibUSBx' => 0,
                          'Alien::libudev' => 0)
                       : (),
    },
    recommends => {
        'IO::Socket::SSL' => 0
    },
    test_requires => {
        'Test::More'         => 0,
        'ExtUtils::CBuilder' => 0,
        'Test::Alien'        => '0.05',
        'Test2'              => '1.302015',
        'Test2::Suite'       => '0.000030',
    },
    requires => {
        'perl' => '5.008001',
        'Alien::Base' => '0.030',
        $^O eq 'linux' ? ('Alien::LibUSBx' => 0,
                          'Alien::libudev' => 0)
                       : (),
    },
    dist_author => 'Ahmad Fatoum <athreef@cpan.org>',
    alien_name => 'HIDAPI',
    alien_repository => {
        protocol => 'http',
        host     => 'github.com',
        location => '/signal11/hidapi/archive',
        exact_filename => 'master.tar.gz',
    },
    alien_inline_auto_include => [ 'hidapi.h' ],
    alien_stage_install => 1,

    alien_build_commands => [
        './bootstrap',
        '%c --prefix=%s',
        'make',
    ],
    alien_install_commands => ['make install'],
    extra_compiler_flags => [Alien::libudev->config('cflags'), Alien::LibUSBx->config('cflags')],
    extra_linker_flags => [Alien::libudev->config('libs'), Alien::LibUSBx->config('libs')],
);

$build->create_build_script;
#$build->dispatch('distmeta');
#$build->dispatch('manifest');
#$build->dispatch('build');
