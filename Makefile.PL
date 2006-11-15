use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME                => 'HTML::Form::ForceValue',
  AUTHOR              => 'Ricardo SIGNES <rjbs@cpan.org>',
  VERSION_FROM        => 'lib/HTML/Form/ForceValue.pm',
  ABSTRACT_FROM       => 'lib/HTML/Form/ForceValue.pm',
  LICENSE             => 'perl',
  PL_FILES            => {},
  PREREQ_PM => {
    'HTML::Form'    =>       0, # minimum version needed unknown
    'Sub::Exporter' => '0.960', # 'into' argument
    'Test::More'    =>       0,
  },
  dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean               => { FILES => 'Form-*' },
);
