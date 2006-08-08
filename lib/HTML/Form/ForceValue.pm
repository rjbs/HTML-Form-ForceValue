package HTML::Form::ForceValue;

use warnings;
use strict;

=head1 NAME

HTML::Form::ForceValue - who cares what values are legal, anyway?

=head1 VERSION

version 0.001

=cut

our $VERSION = '0.001';

=head1 SYNOPSIS

  use Test::WWW::Mechanize tests => 5;
  use HTML::Form::ListInput::mixin::ForceValue;

  my $mech = WWW::Mechanize->new;

  # We're going to test our form.
  $mech->get_ok("http://cgi.example.com/form");

  $mech->set_fields(
    name => 'Crazy Ivan',
    city => 'Vladivostok',
  );

  # What if insane bot tries to claim it's from USSR?
  $mech->form_name("user_info")->find_input("country")->force_value("su");

  $mech->submit;

=head1 DESCRIPTION

L<HTML::Form|HTML::Form> is a very useful module that provides objects to
represent HTML forms.  They can be filled in, and the filled-in values can be
converted into an HTTP::Request for submission to a server.

L<WWW::Mechanize|WWW::Mechanize> makes this even easier by providing a very
easy to automate user agent that provides HTML::Form objects to represent
forms.  L<Test::WWW::Mechanize|Test::WWW::Mechanize> hangs some testing
features on Mech, making it easy to automatically test how web applications
behave.

One really important thing to test is how a web application responds to invalid
input.  Unfortunately, HTML::Form protects you from doing this by throwing an
exception when an invalid datum is assigned to an enumerated field.
HTML::Form::ForceValue mixes in to HTML::Form classes to provide C<force_value>
methods which behave like C<value>, but will automatically add any invalid
datum to the list of valid data.

=cut

use Sub::Exporter -setup => {
  into    => 'HTML::Form::ListInput',
  exports => [ qw(force_value) ],
  groups  => [ default => [ qw(force_value) ] ],
};

sub force_value {
  my ($self, $value) = @_;
  my $old = $self->value;
  eval { $self->value($value); };
  if ($@ and $@ =~ /Illegal value/) {
    push @{$self->{menu}}, { name => $value, $value => $value };
    return $self->value($value);
  }
  return $old;
}

=head1 WARNING

This implementation is extremely crude.  This feature should really be in
HTML::Form (in my humble opinion), and this module should cease to exist once
it is.  In the meantime, just keep in mind that I spent a lot more time
packaging this than I did writing it.  I<Caveat importor!>.

=head1 AUTHOR

Ricardo SIGNES, C<< <rjbs at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-form at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Form>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Form

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Form>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Form>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Form>

=item * Search CPAN

L<http://search.cpan.org/dist/Form>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006 Ricardo SIGNES, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
