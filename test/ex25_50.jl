using Test
using JuliaEuler

@testset "Examples 25 - 50" begin

    @testset "Ex25" begin
        @test ex25(3) == 12
        @test ex25(1000) == 4782
        
    end

    @testset "Ex26" begin
        @test ex26(10) == 7
        @test ex26(1000) == 983
    end

    @testset "Ex27" begin
        @test ex27(1000,1000) == -59231
        @test ex27(80,1602) == -126479
    end

    @testset "Ex28" begin
        @test ex28(3) == 25
        @test ex28(5) == 101
        @test ex28(7) == 261
        @test ex28(1001) == 669171001
    end

    @testset "Ex29" begin
        @test ex29(5,5) == 15
        @test ex29(100,100) == 9183
    end
end

