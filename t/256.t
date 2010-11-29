use strict;
use warnings;
use Test::More tests => 68;
use Digest::CubeHash qw(cubehash_256 cubehash_256_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::CubeHash->new(256)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            cubehash_256_hex($data), $digest,
            "cubehash_256_hex: $len bits of $msg"
        );
        ok(
            cubehash_256($data) eq pack('H*', $digest),
            "cubehash_256: $len bits of $msg"
        );
    }

    my $md = Digest::CubeHash->new(256)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|44C6DE3AC6C73C391BF0906CB7482600EC06B216C7C54A2A8688A6A42676577D
00|DE937563047CEFED250D961D69429567A625E43AC6CEFB85476A0FB4DFD9026B
C0|36DDCF5DBB636370727EA9B212B3FD938372DF8E6E710959B45D7A75A2DB60F4
C0|1C4DCC94E2E4DC2CFDA45DB8076289F6E58A3B606DCF85C2F03DDA17D51CAC78
80|A5A02091C4BC85179065E37D5F1106C785481ACEFF6EFDA523D9B03B41FD1022
48|AD1FA70E76BFF051861924E9292B2159EB900DAAA34021EBE0F08A8180DD51CC
50|02C4204B0E1F0EEF6ED40796D332CF9301317D1FB87BCE26DC57679DBF615ACC
98|6E5B25C2D8E1CF1C82AA2D570ABF1056F56691DD75BE503D761BDBF722E7CAA1
CC|6C38422FB21D2C2C648B25ADD974F29208E02A08105B6DE99D745AA79E2B8466
9800|66D12228946B5B1F5E10CF2A8BBCA3815CA7C194FA3D507C9257F68E444EF332
9D40|9E42C546974218D2F7B9924498BB4E296A360527C10D82B08BA1A934C80CB5BA
AA80|EA2E98EB6683EF07264A59BCB883ECCCBF2DF6C9B133450367F98483C609539D
9830|5BC9B826DEF40F57EAC15241B9192FCF84EDBC1F37DC4CD7BD83E4A7C29E7D12
5030|9254DF194A0F19B8685B95160D7AD0782A82A57D4343666E8F30AE0F47524DD3
4D24|2D927A8676605D2A55AEE2E66768182953E28F6B61A04C0717AA35EA1EA357F3
CBDE|713093D18B7D7EDD381CEB574FCE561351ABB08395365CC2B1DA8C4CFB6CF1B8
41FB|AD4A4242BD1D2385D72A46EAEAE3239BFA243829F0CF3640ED852D4F6609F7DF
4FF400|41859ED4CB7C12D634941653C30F3008A5E880928373C9AC21ABCFA95BA279F2
FD0440|FCAE55E97076831FBDE019A8F5904645CE9432F8B73F30FE41DBDD70ECF48528
424D00|0B7143C44B6D40760ACE111CECA32BC2E7CCD24D184EDCB5EACD72D79B823B45
3FDEE0|2DC518CD54A07D69EB17A3DAAF39E1BD916B90265CEDD4C8B9138661B0F8ABD1
335768|3791EC341B65C865FE61EB4394385B2624FE9622268AC7B8C49F7EC8E1CDECD2
051E7C|A0E7656D8C5D16940CCB657AE5D3F1841AD863260F19AFC9571728B323E781F3
717F8C|36A1A9EE5857AD756DE6F9B78198DD8ECFC35A8ABFD9D3BB2316FCB41B269472
1F877C|10A357968EA2F1E0D64B6C4358880CFEFDD97480B9BDC3491E6D6EE9CFEA315E
EB35CF80|F8F0BD765A903DECB5C536847D46BC589E483AC35B9FEE817387B3ADA99FED71
B406C480|B263DB99232A8ADC053F1477B84CAEA8D13C99AB0789E8BF1854FE1E650606C5
CEE88040|3461B7B48E0247BF4765055A28A366B824C5A5EE1EA7B8B21519ABFD06F0F3CF
C584DB70|859261F604425C9DC9BCAAD4DA74AFFA5DDEB689076F62EE25FBDBED132E71D2
53587BC8|D51C7A795A245CDE6EEFC0F532740E98B448C1248846F1D75A6EEE515511C3D5
69A305B0|AEC4E890C75334643D7BC611035C796EAA7C992726CF0A664AD471B886716B4D
C9375ECE|048B486A5AAC7D6D5DDACC7792FD46AC3C0C570D8C768BD6C3F36CD3386E47D9
C1ECFDFC|AEC39BD08CE304E7CE36D9BB0A09F674678A9F2F34BA26BEA59BEAF1D177F278
8D73E8A280|4F32638F00E82AC2D7E558176A3AFC1068AE0DEAC64E6AD90739D0AE345546AA
06F2522080|AACE97AF78476A5E487864D448B161E76F1A79DFC73FAB628049B6FFB178EC98
3EF6C36F20|0674260191239A92AC6B995D6DA5BFBD51D9872D0D84DDFBFDDDED21836CCCBD
0127A1D340|A4FDEE5232C2B7D4D007F29C62ACEF3BEB5948F7B18BF986D2FDA82F94E2AB37
6A6AB6C210|15C6C2A6F2072234240C22B2B33987B5A3105FB2E5C20CD1360BDE4BD4AAD1F1
AF3175E160|D5C50A6008724ECC2135E181E1EFA390654FF0DD140AFB0EDC771DC3209C4494
B66609ED86|879D2F59A86B140A03B77A6757DC131F5DE4575007AF09BF0E936FD6D495AD1E
21F134AC57|3E198B9C513EC90209B26820FC88B6F7BFB5C4C1F62339C82F8388B3982FF3A1
3DC2AADFFC80|486E857FF41F159FECBE6BD39E2D511E5E0493B1E31D3F39A1D0B1E7297CB71B
9202736D2240|582B14942D23D85F56276523D5447D92BB518B85232B3F5D2590E6A2D4091F3C
F219BD629820|C73826AE98319432431810687C7225009BC37934B376189457A86E82833229FE
F3511EE2C4B0|4526856B3E9968332DF9F50CBC36208074AC598CE3FAF59A28325DCD6CA9A16D
3ECAB6BF7720|3273D2EBCB0B50A7025389E15C8ED059583DC17C9BA7DB35C100A0AE5C434B7B
CD62F688F498|9F5FEB90345687406EFF6651556C477BFBE057769DF08734AB941DD6DC4EB76F
C2CBAA33A9F8|BE13AD1DE8166D32C5DF14CAC25D3DD43794AF9E2BD5283738A1C457674D6564
C6F50BB74E29|779745042AC578C8FEC72DEE94377E2774273ABC4306B1B6592E5FC8EB9FF7D1
79F1B4CCC62A00|1A9B6F5FC97A6769CB8BDD88375A206A50197D2B51A96E75D73250A1C8EC0829
