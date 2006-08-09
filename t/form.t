#!perl -w

use strict;
use Test::More tests => 5;

use HTML::Form;

my $f = HTML::Form->parse(<<EOT, "http://www.example.com");
<form action="http://example.com/">
  <input type='checkbox' name='check_box' checked="checked" />
  <select name='single_select'>
    <option>foo</option>
    <option>bar</option>
    <option>baz</option>
  </select>
</form>
EOT

eval { $f->value(single_select => 'quux') };
like($@, qr/illegal value/i, "can't set select element to invalid option");

eval { $f->value(single_select => 'fingo') };
like($@, qr/illegal value/i, "can't set select element to invalid option");

eval { $f->find_input('single_select')->force_value('fingo') };
like($@, qr/method/, "no force_value method yet");


use_ok('HTML::Form::ForceValue');

eval { $f->find_input('single_select')->force_value('fingo') };
is($@, '', "using force_value forces it");

