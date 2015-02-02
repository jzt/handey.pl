use Irssi;
use Irssi::Irc;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.00";
%IRSSI = (
    authors     => '#meobets@',
    name        => 'handey',
    description => 'Random Jack Handey quote',
    license     => 'Public Domain',
    changed => 'Sun Feb 1 20:16 CST 2015'
);

my $handeyfile = glob "~/.irssi/irssi.handey";

sub cmd_handey {
  my ($nick, $server, $witem) = @_;
  open (f, "<", $handeyfile) || return;
  my $lines = 0; while(<f>) { $lines++; };

  my $line = int(rand($lines))+1;

  my $handeymsg;
  seek(f, 0, 0); $. = 0;
  while(<f>) {
    next if ($. != $line);

    chomp;
    $handeymsg = $_;
    last;
  }
  close(f);

  my $window = Irssi::active_win();
  if ($nick ne "") {
    $window->command("/say $nick: $handeymsg")
  } else {
    $window->command("/say $handeymsg")
  }
}

Irssi::command_bind('handey', 'cmd_handey');
