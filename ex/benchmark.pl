#!/usr/bin/env perl
use strict;
use warnings;

use Benchmark qw(timethese);
use Getopt::Long qw(GetOptions :config no_ignore_case);
use List::Util qw(max);

use Digest            ();
use Digest::BLAKE     ();
use Digest::BMW       ();
use Digest::MD5       ();
use Digest::MD6       ();
use Digest::CubeHash  ();
use Digest::SHA       ();
use Digest::Shabal    ();
use Digest::Skein     ();
use Digest::Whirlpool ();

my %opts = (
    iterations => -1,
    size       => 1,  # KB
);
GetOptions(\%opts, 'iterations|i=i', 'size|s=f',);

my $data = '01234567' x (128 * $opts{size});

my %digests = (
    blake_224    => sub { Digest::BLAKE::blake_224($data) },
    blake_256    => sub { Digest::BLAKE::blake_256($data) },
    blake_384    => sub { Digest::BLAKE::blake_384($data) },
    blake_512    => sub { Digest::BLAKE::blake_512($data) },
    bmw_224      => sub { Digest::BMW::bmw_224($data) },
    bmw_256      => sub { Digest::BMW::bmw_256($data) },
    bmw_384      => sub { Digest::BMW::bmw_384($data) },
    bmw_512      => sub { Digest::BMW::bmw_512($data) },
    cubehash_224 => sub { Digest::CubeHash::cubehash_224($data) },
    cubehash_256 => sub { Digest::CubeHash::cubehash_256($data) },
    cubehash_384 => sub { Digest::CubeHash::cubehash_384($data) },
    cubehash_512 => sub { Digest::CubeHash::cubehash_512($data) },
    md5          => sub { Digest::MD5::md5($data) },
    md6_224      => sub { Digest::MD6::md6_224($data) },
    md6_256      => sub { Digest::MD6::md6_256($data) },
    md6_384      => sub { Digest::MD6::md6_384($data) },
    md6_512      => sub { Digest::MD6::md6_512($data) },
    sha1         => sub { Digest::SHA::sha1($data) },
    sha_224      => sub { Digest::SHA::sha224($data) },
    sha_384      => sub { Digest::SHA::sha256($data) },
    sha_256      => sub { Digest::SHA::sha384($data) },
    sha_512      => sub { Digest::SHA::sha512($data) },
    shabal_224   => sub { Digest::Shabal::shabal_224($data) },
    shabal_256   => sub { Digest::Shabal::shabal_256($data) },
    shabal_384   => sub { Digest::Shabal::shabal_384($data) },
    shabal_512   => sub { Digest::Shabal::shabal_512($data) },
    skein_256    => sub { Digest::Skein::skein_256($data) },
    skein_512    => sub { Digest::Skein::skein_512($data) },
    skein_1024   => sub { Digest::Skein::skein_1024($data) },
    whirlpool    => sub { Digest->new('Whirlpool')->add($data)->digest },
);

my $times = timethese -1, \%digests, 'none';

my @info;
my ($max_name_len, $max_rate_len, $max_bw_len) = (0, 0, 0);

while (my ($name, $info) = each %$times) {
    my ($duration, $cycles) = @{$info}[ 1, 5 ];
    my $rate = sprintf '%.0f', $cycles / $duration;
    my $bw   = sprintf '%.0f', $rate * $opts{size} / 1024;

    push @info, [$name, $rate, $bw];

    $max_name_len = max $max_name_len, length($name);
    $max_rate_len = max $max_rate_len, length($rate);
    $max_bw_len   = max $max_bw_len,   length($bw);
}

for my $rec (sort { $a->[1] <=> $b->[1] } @info) {
    my ($name, $rate, $bw) = @$rec;

    my $name_padding = $max_name_len - length($name);

    printf "%s%s %${max_rate_len}s/s  %${max_bw_len}s MB/s\n",
        $name, ' 'x$name_padding, $rate, $bw;
}

