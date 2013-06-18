#!/usr/bin/perl
use strict;

# Filename should be first argument
my $file = shift @ARGV;    # specify input file

open FP, $file or die "Could not open file:$file";

my %idTest;
my $dupInfo;
my $foo;
for my $line (<FP>) {

    # This line just unpacks into a basic array
    #@x = unpack(qq{A18 A24 A11 A4 A14 A23 A16 A30 A*},$line);
    my (
        $fileNumber,   $studentNumber,     $fullName,
        $schoolNumber, $homeRoom,          $track,
        $grade,        $ethnicCode,        $languageNumber,
        $frp,          $specialEd,         $ssn,
        $birthDay,     $dateRecordCreated, $recordNumber,
        $dateEntered,  $dropDate,          $parentName,
        $fosterChild,  $foodStamps,        $streetAddress,
        $city,         $state,             $zipCode,
        $homePhone,    $workPhone,         $pin
      )
      = unpack(
        qq{A9 A9 A24 A3 A6 A2 A2 A2 A2 A1 A2 A9 A8
                A8 A7 A8 A8 A26 A1 A13 A30 A15 A2 A9 A10 A10 A*}, $line
      );
      $dupInfo = join ("  ", $studentNumber, $fullName, $schoolNumber, $streetAddress);
	if (exists $idTest{$studentNumber}) {
		printf ("duplicate record\015\012 %s\015\012 %s\015\012", $idTest{$studentNumber}, $dupInfo);
	}
	$idTest{$studentNumber} = $dupInfo;
	printf ("long line\n %s", $line) if length($line) != 234;

}

close FP;

