use inc::Module::Install;
name 'Plack-Midelware-ErrorpageRedirectloopDefence';
all_from 'lib/Plack/Midelware/ErrorpageRedirectloopDefence.pm';
readme_from 'lib/Plack/Midelware/ErrorpageRedirectloopDefence.pm';
readme_markdown_from 'lib/Plack/Midelware/ErrorpageRedirectloopDefence.pm';
githubmeta;

requires 'parent';
requires 'Plack::Request';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
