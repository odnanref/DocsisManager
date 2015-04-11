#!/usr/bin/perl -w 

/**
 * This file belongs to the Docsis Manager for managing ISC dhcp and 
 * docsis server table (docsismodem) for a cable network it provides some
 * utilization and information gathering tools for easy management of the cable
 * modem network and provision of CPE and other ISP related equipments.
 * 
 * Copyright (C) 2011  Fernando André <netriver at gmail dot com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * 
 */

use DBI;
use strict;

our $MAXUP=0;
our $MAXDOWN=0;
our $NUMEROTELEF=0;
our $telmac=0;
our $mac=0;
our $mtafile = "";
our $FORCE =0;

chdir("/home/gerarArris");

foreach my $argnum (0 .. $#ARGV) {
	if ( $ARGV[$argnum] eq '--max-up' ){
		$MAXUP = $ARGV[$argnum+1];
		my $V = substr($MAXUP, -1);
		if ($V eq 'M' || $V eq 'm' ) {
			$MAXUP = substr($MAXUP, 0, length($MAXUP)-1);
			$MAXUP = ($MAXUP*1024000);
		}
	}
	elsif($ARGV[$argnum] eq '--max-down' ) {
		$MAXDOWN = $ARGV[$argnum+1];
		my $V = substr($MAXDOWN, -1);
		if ($V eq 'M' || $V eq 'm' ) {
			$MAXDOWN = substr($MAXDOWN, 0, length($MAXDOWN)-1);
			$MAXDOWN = ($MAXDOWN*1024000);
		}
	}
	elsif($ARGV[$argnum] eq '--numero' ) {
		$NUMEROTELEF =  $ARGV[$argnum+1];
	}
	elsif($ARGV[$argnum] eq '--mac' ) {
		$mac = $ARGV[$argnum+1];
	}
	elsif($ARGV[$argnum] eq '--telmac') {
		$telmac = $ARGV[$argnum+1];
	}
	elsif($ARGV[$argnum] eq '--mta-file') {
		$mtafile = $ARGV[$argnum+1];
	}
	elsif($ARGV[$argnum] eq '--force') {
		$FORCE =1;
	}
	elsif($ARGV[$argnum] eq '-h') {
		print "Options: --max-up xM --max-down xM --numero numero --mac MAC --telmac MAC_MTA --mta-file XXX.bin --force\n";
		print "Example: 
			./gerar.pl --max-up 392000 --max-down 9M --numero 255913070 --mac 001DCF1CD730 --telmac 001DCF1CD731 --mta-file 142_mta \n";
		exit;
	}
}

sub getMac{
    my $mac = $_[0];
    my @Amac = split(/:/, $mac);
    $mac  = '';
    for (my $i=0; $i <= $#Amac; $i++) {
        if (length($Amac[$i]) < 2 ) {
            $mac .= '0';
        }
        $mac .= $Amac[$i];
    }
    return $mac;
}

sub ligarBD{
        my $dbh = DBI->connect("DBI:mysql:dhcp:127.0.0.1", "root", "aniga2004",
                {
                        RaiseError => 1,
                        AutoCommit      => 0
                }
        );

        return $dbh;
}

sub setmtafile {
  my ($mac, $mtafile, $mtamac, $tel1) = @_;

  my $dbh = ligarBD();
  $mac = getMac($mac);
  my $sth = $dbh->do("UPDATE docsismodem SET config_file_mta = '$mtafile', tel1='$tel1', macaddr_mta='$mtamac' WHERE macaddr = '$mac'");
  $dbh->disconnect();
}

print "A gerar com MAC=$mac Velocidade up=$MAXUP down=$MAXDOWN numero de telefone = $NUMEROTELEF Mac do telefone=$telmac \n";
gerarArris();

sub gerarArris {
	my $str = `/bin/cat DEFAULT_ARRIS_phone_on.cfg`;

	$str =~ s/#MAXUP#/$MAXUP/gi;
	$str =~ s/#MAXDOWN#/$MAXDOWN/gi;

	my $mta = `/bin/cat DEFAULT_ARRIS_mta.cfg`;

	$mta =~ s/#NUMEROTELF#/$NUMEROTELEF/gi;

	open(MTA, "> ./gerados/$mtafile.cfg");
	print MTA $mta;
	close(MTA);
	`/usr/local/bin/docsis -e  ./gerados/$mtafile.cfg  ./gerados/$mtafile.cfg  /home/tftp/$mtafile.bin`;
	# ($mac, $mtafile, $mtamac, $tel1)
	setmtafile($mac, $mtafile.".bin", $telmac, $NUMEROTELEF);

	my $FILE = "./gerados/".$MAXDOWN."_".$MAXUP.".cfg";
	if (!-r $FILE || $FORCE == 1) {
		open(FH, "> ".$FILE);
		print FH $str;
		close(FH);
		my $OUT = $FILE;
		$OUT =~ s/\.cfg/\.bin/gi;
		`/usr/local/bin/docsis -e $FILE $FILE /home/tftp/$OUT`;
	}

}

chdir;
