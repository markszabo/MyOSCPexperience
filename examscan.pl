#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

my @targets = (
#"192.168.1.1",
#"192.168.1.2" TODO insert IPs here
);

my $exam_folder = "exam/"; #TODO create this folder
my $interface = "tap0"; #TODO change to the interface

chdir($exam_folder) or die "cannot change: $!\n";

foreach my $target (@targets) {
  #Create dir for target
  print("\nCreating directory for target $target\n");
  unless(-e $target or mkdir $target) {
      die "Unable to create directory: $target\n";
  }
  chdir($target) or die "cannot change: $!\n";
  #Unicorn scan on the target
  print("\nExecuting unicorn TCP scan on target $target\n");
  runCommand("unicornscan -i $interface -l unicorn_tcp.txt -mT $target:a");
  print("\nExecuting unicorn UDP scan on target $target\n");
  runCommand("unicornscan -i $interface -l unicorn_udp.txt -mU $target:a");

  #Nmap scan on the unicornscan result ports
  print("\nExecuting nmap TCP scan on target $target\n");
  my @tcpports = parseFile("unicorn_tcp.txt", "\\[\\s*(\\d+)\\]");
  if(scalar @tcpports > 0) {
    runCommand("nmap -A -oA tcp_unicornports -p " . join(",", @tcpports) . " " . $target);
  }
  print("\nExecuting nmap UDP scan on target $target\n");
  my @udpports = parseFile("unicorn_udp.txt", "\\[\\s*(\\d+)\\]");
  if(scalar @udpports > 0) {
    runCommand("nmap -A -sU -oA udp_unicornports -p " . join(",", @udpports) . " " . $target);
  }
  #Nikto on all http ports
  print("\nExecuting nikto on all http ports on target $target\n");
  my @httpports = parseFile("tcp_unicornports.nmap", "(\\d+)/tcp\\s+open\\s+(http|ssl/https)");
  foreach my $httpport (@httpports) {
    runCommand("nikto -h $target -p $httpport > " . $target . "_" . $httpport . ".nikto");
  }

  #enum4linux
  print("\nExecuting enum4linux on target $target\n");
  runCommand("enum4linux -a " . $target . " > " . $target . ".enum4linux");

  print("########################################\nTarget $target done!\n########################################\n");
  chdir("..") or die "cannot change: $!\n";
}

sub runCommand {
  my($command) = @_;
  print("Executing: $command\n");
  my $output = `$command`;
  print($output);
  return $output;
}

sub parseFile {
  my($file, $pattern) = @_;
  my @result;
  print("Parsing file $file with pattern $pattern\n");
  open(my $fh, '<:encoding(UTF-8)', $file) or die "Could not open file '$file' $!";
  while (my $row = <$fh>) {
    chomp $row;
    if($row =~ /$pattern/i) {
      push(@result, $1);
    }
  }
  close($fh);
  print("The followings matched the pattern: " . join(", ", @result) . "\n");
  return @result;
}
