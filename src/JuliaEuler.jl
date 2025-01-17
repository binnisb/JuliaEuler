module JuliaEuler

using Dates
using Lazy

import Base.Iterators: product

export ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ex9, ex10
export ex11, ex12, ex13, ex14, ex15, ex16, ex17, ex18, ex19, ex20
export ex21, ex22, ex23, ex24, ex25, ex26, ex27, ex28, ex29

export fib, fibs, primes, factors, primes_of_num, proper_divisors, permutations, product, combinations
"""
```jldoctest
julia> fib(;terms=7) == [1, 2, 3, 5, 8, 13, 21]
true

```
"""
fibs = @lazy BigInt(1):1:(fibs + drop(1,fibs))

function fib(; terms=missing, under=missing)
    m = count(x->ismissing(x), [terms,under])
    if m in (0,2)
        throw("User either number of terms, or fibs under certain value")
    end
    if !ismissing(terms)
        return take(terms, fibs)
    else
        return takewhile(x-> x < under, fibs)
    end    
end


function primes(n)
    p = Vector{Int}()
    if n == 1
        return p
    end
    append!(p,2)

    sieve=fill(true, n)
    sieve[4:2:end] .= false
    for i in 3:2:n
        if sieve[i]
            append!(p,i)
            sieve[i+i:i:end] .= false
        end
    end
    return p
end


function factors(n)
    fs = Vector{Tuple{Int,Int}}()
    if n == 1
        return fs
    end
    ps = primes(convert(Int,ceil(sqrt(n))))

    for p in ps
        count = 1
        while n%(p^count) == 0
            count+=1
        end
        count -= 1
        if count  > 0
            append!(fs, [(p,count)])
            n /= p^count
        end
    end
    if n != 1
        append!(fs, [(n,1)])
    end
    fs
end

function primes_of_num(n)
    fac = factors(n)
    [f for (f,_) in fac]
end

function proper_divisors(n)
    [j for j in 1:n-1 if n % j == 0]
end

function product(l, n::Int)
    product([l for i in 1:n]...)
end

function unique_sorted(ind) 
    for i in 1:length(ind)-1
        if ind[i] == ind[i+1]
            return false
        end
    end
    true
end

function permutations(l, n)
    ps = product(l,n)
    pd = product(1:length(l),n)
    
    (p for (p,ind) in zip(ps,pd) if unique_sorted(sort(collect(ind))))
end

function combinations(l, n; with_replacement=false)
    ps = product(l,n)
    pd = product(1:length(l),n)

    (p for (p,ind) in zip(ps,pd) if (issorted(ind) & (with_replacement | unique_sorted(ind))))
end
# Write your package code here.
ex1(n) = sum(i for i in 3:3:(n-1)) + sum(i for i in 5:5:(n-1)) - sum(i for i in 15:15:(n-1))
ex2(n) = fib(;under=n) |> x->filter(y->y%2==0, x) |> sum
ex3(n) = primes_of_num(n)[end]
ex4(n) = begin
    nums = 10^(n-1):1:10^n
    max_pal = 0
    for (i,n1) in enumerate(nums)
        for (j,n2) in enumerate(nums)
            n = n1*n2
            ns = "$n"
            max_pal = max(max_pal, ns == reverse(ns) ? n : 0)
        end
    end
    max_pal
end
ex5(n) = begin 
    f = 1:n .|> factors |> Base.Iterators.flatten |> Set |> collect |> sort |> (x->groupby(y->y[1],x)) 
    res = 1
    for (k,v) in f
        m = k^maximum([i for (_,i) in v])
        res *= m
    end
    res
end
"""
``(1+2+3+\\ldots+n)^2 - (1^2+2^2+3^2+\\ldots+n^2)``
"""
ex6(n) = 1:n |> (x-> sum(x)^2 - ((x.^2) |> sum))
ex7(n) = primes(n*n)[n]
ex8(n) = begin
    num = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450
    ns = "$num"
    max_val = 0
    for i in 1:(length(ns)-n+1)
        max_val = max(max_val, ns[i:i+n-1] |> collect .|> (x->parse(Int,x)) |> (x->reduce(*,x)))
    end
    max_val
end
ex9(n) = begin
    res = []
    for i = 1:n
        if i + i + 1 >= n
            break
        end
        for j = i+1:n
            if n - (i + j) <= j
                break
            end
            k = n - i - j
            if i^2 + j^2 == k^2
                append!(res, [(i,j,k)])
            end
        end
    end
    reduce(*,res[1])
end
ex10(n) = primes(n) |> sum
ex11(n) = begin
    nums = [08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08;
    49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00;
    81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65;
    52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91;
    22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80;
    24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50;
    32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70;
    67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21;
    24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72;
    21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95;
    78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92;
    16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57;
    86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58;
    19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40;
    04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66;
    88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69;
    04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36;
    20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16;
    20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54;
    01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48]

    max_val = 0
    for x in 1:20
        for y in 1:20-n+1
            max_val = max(max_val, reduce(*,nums[x,y:y+n-1]))
        end
    end
    for y in 1:20
        for x in 1:20-n+1
            max_val = max(max_val, reduce(*,nums[x:x+n-1,y]))
        end
    end
    for x in 1:20-n+1
        for y in 1:20-n+1
            max_val = max(max_val, reduce(*,[nums[x+i-1, y+i-1] for i in 1:n]))
        end
    end
    for x in n:20
        for y in 1:(20-n+1)
            vals = [nums[x-(i-1), y+(i-1)] for i in 1:n]
            max_val = max(max_val, reduce(*,vals))
        end
    end
    max_val
end
ex12(n) = begin
    i = 1
    t = 1
    while i < 100000000
        f = [p+1 for (_,p) in factors(t)]
        if reduce(*,f) > n
            break
        end
        i += 1
        t += i
    end
    return t
end
ex13(n) = begin
    nums = 
    [
        37107287533902102798797998220837590246510135740250,
        46376937677490009712648124896970078050417018260538,
        74324986199524741059474233309513058123726617309629,
        91942213363574161572522430563301811072406154908250,
        23067588207539346171171980310421047513778063246676,
        89261670696623633820136378418383684178734361726757,
        28112879812849979408065481931592621691275889832738,
        44274228917432520321923589422876796487670272189318,
        47451445736001306439091167216856844588711603153276,
        70386486105843025439939619828917593665686757934951,
        62176457141856560629502157223196586755079324193331,
        64906352462741904929101432445813822663347944758178,
        92575867718337217661963751590579239728245598838407,
        58203565325359399008402633568948830189458628227828,
        80181199384826282014278194139940567587151170094390,
        35398664372827112653829987240784473053190104293586,
        86515506006295864861532075273371959191420517255829,
        71693888707715466499115593487603532921714970056938,
        54370070576826684624621495650076471787294438377604,
        53282654108756828443191190634694037855217779295145,
        36123272525000296071075082563815656710885258350721,
        45876576172410976447339110607218265236877223636045,
        17423706905851860660448207621209813287860733969412,
        81142660418086830619328460811191061556940512689692,
        51934325451728388641918047049293215058642563049483,
        62467221648435076201727918039944693004732956340691,
        15732444386908125794514089057706229429197107928209,
        55037687525678773091862540744969844508330393682126,
        18336384825330154686196124348767681297534375946515,
        80386287592878490201521685554828717201219257766954,
        78182833757993103614740356856449095527097864797581,
        16726320100436897842553539920931837441497806860984,
        48403098129077791799088218795327364475675590848030,
        87086987551392711854517078544161852424320693150332,
        59959406895756536782107074926966537676326235447210,
        69793950679652694742597709739166693763042633987085,
        41052684708299085211399427365734116182760315001271,
        65378607361501080857009149939512557028198746004375,
        35829035317434717326932123578154982629742552737307,
        94953759765105305946966067683156574377167401875275,
        88902802571733229619176668713819931811048770190271,
        25267680276078003013678680992525463401061632866526,
        36270218540497705585629946580636237993140746255962,
        24074486908231174977792365466257246923322810917141,
        91430288197103288597806669760892938638285025333403,
        34413065578016127815921815005561868836468420090470,
        23053081172816430487623791969842487255036638784583,
        11487696932154902810424020138335124462181441773470,
        63783299490636259666498587618221225225512486764533,
        67720186971698544312419572409913959008952310058822,
        95548255300263520781532296796249481641953868218774,
        76085327132285723110424803456124867697064507995236,
        37774242535411291684276865538926205024910326572967,
        23701913275725675285653248258265463092207058596522,
        29798860272258331913126375147341994889534765745501,
        18495701454879288984856827726077713721403798879715,
        38298203783031473527721580348144513491373226651381,
        34829543829199918180278916522431027392251122869539,
        40957953066405232632538044100059654939159879593635,
        29746152185502371307642255121183693803580388584903,
        41698116222072977186158236678424689157993532961922,
        62467957194401269043877107275048102390895523597457,
        23189706772547915061505504953922979530901129967519,
        86188088225875314529584099251203829009407770775672,
        11306739708304724483816533873502340845647058077308,
        82959174767140363198008187129011875491310547126581,
        97623331044818386269515456334926366572897563400500,
        42846280183517070527831839425882145521227251250327,
        55121603546981200581762165212827652751691296897789,
        32238195734329339946437501907836945765883352399886,
        75506164965184775180738168837861091527357929701337,
        62177842752192623401942399639168044983993173312731,
        32924185707147349566916674687634660915035914677504,
        99518671430235219628894890102423325116913619626622,
        73267460800591547471830798392868535206946944540724,
        76841822524674417161514036427982273348055556214818,
        97142617910342598647204516893989422179826088076852,
        87783646182799346313767754307809363333018982642090,
        10848802521674670883215120185883543223812876952786,
        71329612474782464538636993009049310363619763878039,
        62184073572399794223406235393808339651327408011116,
        66627891981488087797941876876144230030984490851411,
        60661826293682836764744779239180335110989069790714,
        85786944089552990653640447425576083659976645795096,
        66024396409905389607120198219976047599490197230297,
        64913982680032973156037120041377903785566085089252,
        16730939319872750275468906903707539413042652315011,
        94809377245048795150954100921645863754710598436791,
        78639167021187492431995700641917969777599028300699,
        15368713711936614952811305876380278410754449733078,
        40789923115535562561142322423255033685442488917353,
        44889911501440648020369068063960672322193204149535,
        41503128880339536053299340368006977710650566631954,
        81234880673210146739058568557934581403627822703280,
        82616570773948327592232845941706525094512325230608,
        22918802058777319719839450180888072429661980811197,
        77158542502016545090413245809786882778948721859617,
        72107838435069186155435662884062257473692284509516,
        20849603980134001723930671666823555245252804609722,
        53503534226472524250874054075591789781264330331690
    ]
    "$(sum(nums[1:n]))"[1:10]
end
ex14(n) = begin
    _even(k::Int)::Int = k/2
    _odd(k::Int)::Int = 3k+1
    longest = (0,0)
    for i in 1:n
        len = 1
        res = i
        while res != 1
            res = res % 2 == 0 ? _even(res) : _odd(res)
            len += 1
        end
        longest = max((len,i), longest)
    end
    longest[2]
end
ex15(n::Int)::BigInt = begin
    result = 1
    for i=1:n
        result = result * (n+i)/i
    end
    result
end
ex16(n::Int) = BigInt(2)^n |> x->"$x" |> x-> split(x,"") .|> (x-> parse(Int,x)) |> sum
ex17() = begin 
    n_to_l = Dict(
        0=>0, 1=>3, 2=> 3, 3=>5, 4=>4, 5=>4, 6=>3, 7=>5, 8=>5, 9=>4, 
        10=>3, 11=>6,12=>6, 13=>8,14=>8,15=>7,16=>7,17=>9,18=>8, 19=>8, 
        20=>6, 30=>6, 40=>5, 50=>5, 60=>5,70=>7, 80=>6, 90=>6,
        100=>7, 1000=>8,-1=>3
        )
    all_tens = sum(n_to_l[i] for i in 1:9)
    all_tweens = sum(n_to_l[i] for i in 10:19)
    all_20_90 = sum(n_to_l[i] for i in 20:10:90)
    sub_100 = all_tens + all_tweens + all_20_90*10 + all_tens*8
    all_1_99 = 10 * sub_100
    all_hundreds = sum(n_to_l[i]+n_to_l[100] for i in 1:9)
    all_hundreds_and = all_hundreds*99 + 9*99*n_to_l[-1]
    thousand = n_to_l[1] + n_to_l[1000]
    thousand + all_hundreds_and+all_hundreds + all_1_99
end 
ex18(n) = begin
    tri = 
    """75
    95 64
    17 47 82
    18 35 87 10
    20 04 82 47 65
    19 01 23 75 03 34
    88 02 77 73 07 63 67
    99 65 04 28 06 16 70 92
    41 41 26 56 83 40 80 70 33
    41 48 72 33 47 32 37 16 94 29
    53 71 44 65 25 43 91 52 97 51 14
    70 11 33 28 77 73 17 78 39 68 17 57
    91 71 52 38 17 14 91 43 58 50 27 29 48
    63 66 04 68 89 53 67 30 73 16 69 87 40 31
    04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"""
    tri_parsed = tri |> strip |> x->split(x, "\n") .|> (x->split(x)) .|>(x-> map(y->parse(Int,y), x))
    res = [tri_parsed[n]]
    for i in n:-1:2
        t = res[end]
        t_u = tri_parsed[i-1]
        push!(res, [max(v+t[i], v+t[i+1]) for (i,v) in enumerate(t_u)])
    end
    res[end][1]
end
ex19(ds::Date,de::Date) = sum([1 for d in ds:Month(1):de if Dates.issunday(d)])
ex20(n) = reduce(*, BigInt(1):BigInt(n)) |> x->"$x" |> x->split(x,"") .|> (x->parse(Int,x)) |> sum 
ex21(n) = [(i, sum(proper_divisors(i))) for i in 2:n] |> x->Dict(x) |> x-> [(k,v) for (k,v) in x if (k == get(x,v,0)) & (k != v)] |> Dict |>keys |> sum
ex22() = begin
    cv = Dict([(v,i) for (i,v) in enumerate('A':'Z')])
    open(f->read(f,String), joinpath(@__DIR__,"assets","p022_names.txt")) |> x-> replace(x,"\""=>"") |> x-> split(x,",") |> sort |> enumerate .|> (x->x[1] * sum([cv[c] for c in x[2]])) |> sum
end
ex23(n) = begin
    filter_abundant(x) = filter(y -> y[1] < y[2] ? true : false, x)
    comb(x) = combinations(x,2;with_replacement=true)
    ab_nums = [(i,sum(proper_divisors(i))) for i in 2:n] |> filter_abundant .|> (x-> x[1])
    all_nums = Set(1:n)
    for c in comb(ab_nums)
        pop!(all_nums,sum(c),0)
    end
    sum(all_nums)
end

ex24(l,n) = begin
    inds_to_out(ii) = begin
        [l[i] for i in ii] |> join |> x-> parse(Int,x)
    end
    if reduce(*,1:length(l)) == n
        return length(l):-1:1 |> collect |> inds_to_out
    end
    res = n
    inds = Vector{Int}()
    inds_left = 1:length(l)|>collect
    for i in length(l)-1:-1:1
        fact = reduce(*,1:i)
        d,res = divrem(res,fact)
        next_ind = d + (res!=0)
        ind = inds_left[next_ind]
        append!(inds,ind)
        deleteat!(inds_left,next_ind)

        if (fact == res) | (res == 0)
            break
        end
    end
    append!(inds,reverse(inds_left)) |> inds_to_out
end

ex25(n) = takeuntil(x-> x > BigInt(10)^(n-1), fibs) |> length

ex26(n) = begin
    N, hi = 0, 0
    for n = 1:n
        for β = 6:1000
            if (1//n*BigInt(10)^β)%1 == ((1//n * BigInt(10)^5) %1) 
                if hi < β-5
                    hi = β-5
                    N = n
                end
                break
            end
        end
    end
    N
end

ex27(am, bm) = begin
    nm = 5000
    ps = primes(nm^2)
    p = Set(ps)
    mp = ps[end]
    max_primes = 0
    max_mul = 0
    for a in (-am+1):(am-1)
        for b in -bm:bm
            for n = 1:nm
                f = (n^2 + a*n +b)
                if f in p
                    continue
                elseif f > mp
                    throw("GenerateMorePrimes")
                else
                    if n > max_primes
                        max_primes = n
                        max_mul = a*b
                    end
                    break
                end
            end
        end
    end
    max_mul
end

ex28(n) = 1 + sum((i^2+(i-2)^2 + i-1)*2  for i in 3:2:n)

ex29(am,bm) = begin
    res = Set{BigInt}()
    for a_tmp in 2:am
        a = big(a_tmp)
        b = 2
        while b <= bm
            a *= a_tmp
            push!(res, a)
            b += 1
        end
    end
    length(res)
end

end