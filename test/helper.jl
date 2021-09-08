using Test
using JuliaEuler
using Lazy

@testset "helper" begin
    # Write your tests here.
    @testset "Fib" begin
        @test fib(;under=90) |> collect |> Vector{Int} == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
        @test fib(;terms=11) |> collect |> Vector{Int} == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
        @test take(11, fibs) |> collect |> Vector{Int} == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
        @test takewhile(x-> x < 90,fibs) |> collect |> Vector{Int} == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
        @test take(11,fibs) |> collect |> Vector{Int} == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
    end
    @testset "Prime" begin
        @test primes(20) == [2,3,5,7,11,13,17,19]
        @test primes(2) == [2]
        @test primes(5) == [2,3,5]
        @test factors(2309125) == [(5,3), (7,2), (13,1), (29,1)]
        @test factors(2) == [(2,1)]
        @test factors(5) == [(5,1)]
        @test primes_of_num(13195) == [5,7,13,29]
        @test primes_of_num(2) == [2]
        @test primes_of_num(5) == [5]

    end

    @testset "ProperDivisors" begin
        @test proper_divisors(220) == [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110]
        @test proper_divisors(284) == [1, 2, 4, 71, 142]
    end

    @testset "Permutations" begin
        @test Set(permutations([1,2,3], 2)) == Set([(1,2), (1,3), (2,1), (2,3), (3,1),(3,2)])
        @test Set(permutations([1,2,3], 3)) == Set([(1,2,3), (1,3,2), (2,1,3), (2,3,1), (3,1,2), (3,2,1)
            ])

    end

    @testset "Product" begin
        @test Set(product([1,2,3], 2)) == Set([(1,1), (1,2), (1,3), (2,1), (2,2), (2,3), (3,1), (3,2), (3,3)])
        @test Set(product([1,2,3], 3)) == Set([
            (1,1,1), (1,1,2), (1,1,3), (1,2,1), (1,2,2), (1,2,3), (1,3,1), (1,3,2), (1,3,3),
            (2,1,1), (2,1,2), (2,1,3), (2,2,1), (2,2,2), (2,2,3), (2,3,1), (2,3,2), (2,3,3),
            (3,1,1), (3,1,2), (3,1,3), (3,2,1), (3,2,2), (3,2,3), (3,3,1), (3,3,2), (3,3,3)
            ])
    end

    @testset "combinations" begin
        @test Set(combinations([1,2,3], 2)) == Set([(1,2), (1,3), (2,3)])
        @test Set(combinations([1,2,3], 2;with_replacement=true)) == Set([(1,1), (1,2), (1,3), (2,2), (2,3), (3,3)])
        @test Set(combinations([1,2,3], 3)) == Set([(1,2,3)])
        @test Set(combinations([1,2,3], 3;with_replacement=true)) == Set([
            (1,1,1), (1,1,2), (1,1,3), (1,2,2), (1,2,3), (1,3,3),
            (2,2,2), (2,2,3), (2,3,3),
            (3,3,3)
    ])
    end

    @testset "unique_sorted" begin
        @test JuliaEuler.unique_sorted([1,2,3]) == true
        @test JuliaEuler.unique_sorted([1,2, 2,3]) == false
    end
end
