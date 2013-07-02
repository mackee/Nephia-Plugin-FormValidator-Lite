package MyApp;
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
        name => [qw/NOT_NULL/],
        name_kana => [qw/NOT_NULL KATAKANA/],
        mail => [qw/NOT_NULL EMAIL/],
    );
    $res->set_param_message(
        name => '名前',
        name_kana => 'カナ',
        mail => 'メールアドレス'
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
        return {
            name => [$req->param('name')],
            name_kana => [$req->param('name_kana')],
            mail => [$req->param('mail')],
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

