using JuliaEuler
using Dates

@testset "Examples 1-24" begin

    @testset "Ex1" begin
        @test ex1(10) == 23
        @test ex1(16) == 60
        @test ex1(1_000) == 233_168
    end

    @testset "Ex2" begin
        @test ex2(90) == 44
        @test ex2(4_000_000) == 4613732
    end

    @testset "Ex3" begin
        @test ex3(13_195) == 29
        @test ex3(600851475143) == 6857
    end

    @testset "Ex4" begin
        @test ex4(2) == 9009
        @test ex4(3) == 906609
    end

    @testset "Ex5" begin
        @test ex5(10) == 2520
        @test ex5(20) == 232792560
    end

    @testset "Ex6" begin
        @test ex6(10) == 2640
        @test ex6(100) == 25164150
    end

    @testset "Ex7" begin
        @test ex7(6) == 13
        @test ex7(10_001) == 104743
    end

    @testset "Ex8" begin
        @test ex8(4) == 5832
        @test ex8(13) == 23514624000
    end

    @testset "Ex9" begin
        @test ex9(12) == 3*4*5
        @test ex9(1000) == 31875000
    end


    @testset "Ex10" begin
        @test ex10(10) == 17
        @test ex10(2_000_000) == 142913828922
    end

    @testset "Ex11" begin
        @test ex11(2) == 99*97
        @test ex11(4) == 70600674
    end

    @testset "Ex12" begin
        @test ex12(5) == 28
        @test ex12(500) == 76576500
    end

    @testset "Ex13" begin
        @test ex13(1) == "3710728753"
        @test ex13(100) == "5537376230"
    end

    @testset "Ex14" begin
        @test ex14(8) == 7
        @test ex14(999_999) == 837799
    end

    @testset "Ex15" begin
        @test ex15(3) == 20
        @test ex15(20) == 137846528820
    end

    @testset "Ex16" begin
        @test ex16(15) == 26
        @test ex16(1000) == 1366
    end

    @testset "Ex17" begin
        @test ex17() == 21124
    end

    @testset "Ex18" begin
        @test ex18(3) == 75+64+82
        @test ex18(15) == 1074
    end

    @testset "Ex19" begin
        @test ex19(Date(2000,1,1), Date(2000,12,1)) == 1
        @test ex19(Date(1901,1,1), Date(2000,12,1)) == 171
    end

    @testset "Ex20" begin
        @test ex20(10) == 27
        @test ex20(100) == 648
    end

    @testset "Ex21" begin
        @test ex21(284) == 504
        @test ex21(10000) == 31626
    end


    @testset "Ex22" begin
        @test ex22() == 871198282
    end


    @testset "Ex23" begin
        @test ex23(24) == sum(1:23)
        @test ex23(28123) == 4179871
    end

     @testset "Ex24" begin
        @test [ex24(split("012",""),i) for i in 1:6] == [12,21,102,120,201,210]
        @test ex24(split("0123456789",""), 1_000_000) == 2783915460
    end
end