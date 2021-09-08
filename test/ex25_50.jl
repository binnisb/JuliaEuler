using Test
using JuliaEuler

@testset "Examples 25 - 50" begin

    @testset "Ex25" begin
        @test ex25(3) == 12
        @test ex25(1000) == 4782
        
    end

end

