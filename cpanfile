on 'runtime' => sub {
    requires 'perl' => '5.008001';
    requires 'strict';
    requires 'warnings';
    requires 'base';
    requires 'Alien::Base';
    do {
        requires 'Alien::LibUSBx' => 0;
        requires 'Alien::libudev' => '0.1';
    } if $^O eq 'linux';
};

on 'build' => sub {
    requires 'Alien::Base';
    requires 'Alien::Build';
    requires 'Alien::Build::MM';
    requires 'Alien::Build::Plugin::Build::Autoconf';
    requires 'Alien::Build::Plugin::Gather::IsolateDynamic';
    requires 'Alien::MSYS';
    requires 'Alien::autoconf' => '0.02';
    requires 'Alien::automake' => '0.02';
    requires 'Alien::libtool' => '0.02';
    do {
        requires 'Alien::LibUSBx' => 0;
        requires 'Alien::libudev' => '0.1';
    } if $^O eq 'linux';
    requires 'Config';
    requires 'ExtUtils::MakeMaker';
};

on 'test' => sub {
    requires 'Test::Alien';
    requires 'Test::More' => '0.88';
    requires 'Test2::Suite';
    requires 'Test2::V0';
};

on 'develop' => sub {
    requires 'Test::CheckManifest' => '1.29';
    requires 'Test::CPAN::Changes' => '0.4';
    requires 'Test::Kwalitee'      => '1.22';
    requires 'Test::Pod::Spelling::CommonMistakes' => '1.000';
};
