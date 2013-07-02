package Nephia::TestApp;
use strict;
use warnings;
use Nephia plugins => [qw/FormValidator::Lite/];
use utf8;

path '/' => sub {
    return {
        template => 'index.html',
        title    => config->{appname},
        envname  => config->{envname},
        apppath  => 'lib/' . __PACKAGE__ .'.pm',
    };
};

post '/form' => sub {
    my $res = form(
        first_name => [qw/NOT_NULL/],
        last_name => [qw/NOT_NULL/],
        mail => [qw/NOT_NULL EMAIL_LOOSE/],
    );
    $res->set_param_message(
        first_name => 'FIRST NAME',
        last_name => 'LAST NAME',
        mail => 'E-MAIL ADDRESS'
    );

    if ($res->has_error) {
        return {
            template => 'index.html',
            title    => config->{appname},
            envname  => config->{envname},
            error_messages => [$res->get_error_messages],
        };
    }
    else {
        my $req = req;
        my $first_name = $req->param('first_name');
        my $last_name = $req->param('last_name');
        my $full_name = sprintf('%s %s', $first_name, $last_name);
        my $mail = $req->param('mail');
        return {
            template => 'confirm.html',
            title    => config->{appname},
            envname  => config->{envname},
            full_name => $full_name,
            mail => $mail,
        };
    }
};

1;

=head1 NAME

MyApp - Web Application

=head1 SYNOPSIS

  $ plackup

=head1 DESCRIPTION

MyApp is web application based Nephia.

=head1 AUTHOR

clever guy

=head1 SEE ALSO

Nephia

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

