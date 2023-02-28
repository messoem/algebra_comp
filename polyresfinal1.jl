Base.@kwdef mutable struct Polynom{T}
    coef::Vector{T}
end

function ord(p::Polynom{T})::BigInt where T
    return length(p.coef) -1
end

function value(p::Polynom{T}, a::T):: T where T
    pval = 0
    for i in 1:length(p.coef) 
        pval+= p.coef[i]*(a^(i-1))
    end
    return pval
end


function get_max_pow(value::Int, T)
    arr = []
    for i in 1:value+1
        push!(arr,T(0))
    end
    arr[end] =  T(1)
    return Polynom(arr)
end
function Base.println(p::Polynom{T}) where T
    poly = ""
    if length(p.coef) != 1
        for i in 1:(length(p.coef))
            if p.coef[i] > 0
                if i == 1
                    poly *= string(p.coef[i])
                elseif i == 2
                    poly *= " + " * string(p.coef[i])*"x"
                elseif  i != length(p.coef)
                    poly*= " + " * string(p.coef[i])*"x^"*string(i-1)
                else
                    poly*= " + " * string(p.coef[i])*"x^"*string(i-1)
                end
            elseif p.coef[i] == 0
                if i == 1
                    poly *= string(0)*" + "
                elseif i == 2
                    poly *= ""
                elseif  i != length(p.coef)
                    poly*= ""
                else
                    poly*= ""
                end
            else
                if i == 1
                    poly *= string(p.coef[i])
                elseif i == 2
                    poly *= " - "*string(abs(p.coef[i]))*"x"
                elseif  i != length(p.coef)
                    poly*= " - "*string(abs(p.coef[i]))*"x^"*string(i-1)
                else
                    poly*= " - "*string(abs(p.coef[i]))*"x^"*string(i-1)
                end
            end
        end
    end
    println(poly)
end



function Base. +(p1::Polynom{T}, p2::Polynom{T}) where T
    lst = []
    if length(p1.coef) >= length(p2.coef)
        for i in 1:length(p1.coef)
            if i <= length(p2.coef)
                push!(lst, p1.coef[i] + p2.coef[i])
            else
                push!(lst, p1.coef[i])
            end
        end
    end
    if length(p1.coef) < length(p2.coef)
        for i in 1:length(p2.coef)
            if i <= length(p1.coef)
                push!(lst, p1.coef[i] + p2.coef[i])
            else
                push!(lst, p2.coef[i])
            end
        end
    end
    return Polynom{T}(lst)
end


function Base. -(p1::Polynom{T}, p2::Polynom{T}) where T
    lst= []
    if length(p1.coef) >= length(p2.coef)
        for i in 1:length(p1.coef)
            if i <= length(p2.coef)
                push!(lst, p1.coef[i] - p2.coef[i])
            else
                push!(lst, p1.coef[i])
            end
        end
    end
    if length(p1.coef) < length(p2.coef)
        for i in 1:length(p2.coef)
            if i <= length(p1.coef)
                push!(lst, p1.coef[i] - p2.coef[i])
            else
                push!(lst, -p2.coef[i])
            end
        end
    end
    return Polynom{T}(lst)
end

function Base. *(p1::Polynom{T}, p2::Polynom{T}) where T
    lst = [T(0) for i in 1:(length(p1.coef)+length(p2.coef)-1)]
    for i in 1:length(p1.coef)
        for j in 1:length(p2.coef)
            lst[i+j-1] += p1.coef[i]*p2.coef[j]
        end
    end
    return Polynom{T}(lst)
end

function Base. *(value::T, a::Polynom) where T
    c = Polynom(value * a.coef)
    return c
end



function Base. /(a::Polynom{T}, b::Polynom{T}) where T
    if length(a.coef)<length(b.coef)
        return 0, a
    else
        s = a
        w = b
        t::Vector{T} = []
        for i in 1:length(s.coef)
            push!(t,T(0))
        end
        while length(s.coef)>=length(b.coef)            
            coef = s.coef[end]/b.coef[end]
            poli = length(s.coef)-length(b.coef)
            q::Vector{T} = []
            for k in 1:poli
                push!(q,T(0))
            end
            push!(q,coef)
            t[length(q)] = coef
            s -= Polynom(q)*b
            if length(s.coef) !=0
                while s.coef[end]==T(0)
                    deleteat!(s.coef,length(s.coef))
                    if length(s.coef) == 0
                        break
                    end
                end  
            end
        end
    end   
    return s,Polynom(t)
end

function gcp(a::T, b::T) where T <: Int
    while(b!=0)
        a,b = b,mod(a,b)
    end
    return a
end

function egcp(a::T, b::T) where T <: Int
    m,n = a,b
    u , v = 1 , 0;
    u1,v1=0,1
    while(b>0)
        k = div(a,b)
        a,b = b,a-k*b
        u,v,u1,v1 = u1,v1,u-k*u1,v-k*v1
    end
    if a < 0
        a,u,v =-a,-u,-v
    end
    return a,u,v
end
function inverse_null(a::T,n::T) where T<:Int
    if(gcp(a,n) == 1)
        return Nothing
    end
    return div(n,gcp(a,n))
end
function inverse(a::T,n::T) where T<:Int
    if(gcp(a,n) != 1)
        return Nothing
    end
    a,u,v = egcp(mod(a,n),n) #ab = 1 + nm ab - nm = 1
    return mod(u,n)
end

struct Residue{T, M}
    a::T
    Residue{T, M}(b::T) where {T<:Integer, M} = new(mod(b, M))
end
function Base. +(x::Residue{T, M}, y::Residue{T, M}) where {T, M}
    c = x.a + y.a
    return Residue{Int, M}(c)
end
function Base. *(x::Residue{T, M}, y::Residue{T, M}) where {T, M}
    c = x.a * y.a
    return Residue{Int, M}(c)
end

function get_value(a::Residue{T,M})where {T,M}
    return a.a
end

function Base. -(x::Residue{T, M}, y::Residue{T, M}) where {T, M}
    c = x.a - y.a
    return Residue{Int, M}(c)
end
function Base. isless(x::T, y::Residue{T, M}) where {T, M}
    if mod(x, M) < y.a
        return true
    else
        return false
    end
    
end

function inverse(a::Residue{T,M}) where {T,M}
    f = get_value(a)
    d = M
    if(gcp(f,M) != 1)
        return 0
    end
    s1,s2,s3 = egcp(mod(f,M),M)
    return Residue{T,M}(s2) #ab = 1 + nm ab - nm = 1
end

function Base. /(a::Residue{T, M}, b::Residue{T, M}) where {T, M}
    return a*inverse(b)
end

function Base.println(x::Residue{T, M}) where {T, M}
    println(x.a)
end


function Base.println(p::Polynom{Residue{T, M}}) where {T, M}
    poly = ""
    if length(p.coef) != 1
        for i in 1:(length(p.coef))
            if p.coef[i].a > 0
                if i == 1
                    poly *= string(p.coef[i].a)
                elseif i == 2
                    poly *= " + " * string(p.coef[i].a)*"x"
                elseif  i != length(p.coef)
                    poly*= " + " * string(p.coef[i].a)*"x^"*string(i-1)
                else
                    poly*= " + " * string(p.coef[i].a)*"x^"*string(i-1)
                end
            elseif p.coef[i].a == 0
                if i == 1
                    poly *= string(0)*" + "
                elseif i == 2
                    poly *= ""
                elseif  i != length(p.coef)
                    poly*= ""
                else
                    poly*= ""
                end
            else
                if i == 1
                    poly *= string(p.coef[i].a)
                elseif i == 2
                    poly *= " - "*string(abs(p.coef[i].a))*"x"
                elseif  i != length(p.coef)
                    poly*= " - "*string(abs(p.coef[i].a))*"x^"*string(i-1)
                else
                    poly*= " - "*string(abs(p.coef[i].a))*"x^"*string(i-1)
                end
            end
        end
    end
    println(poly)
end

function Base. +(x::T, y::Residue{T, M}) where {T, M}
    return Residue{T, M}(x) + y
    
end



a = Residue{Int, 10}(3)
b = Residue{Int, 10}(5)
println((a+b))
println(inverse(a))

println(Polynom([1, 2, 3, 5]))
p1 = Polynom([-6,-1,-2,1])
p2 = Polynom([-3,1])
println((p1/p2)[2])
pr = Polynom([Residue{Int, 10}(12), Residue{Int, 10}(1), Residue{Int, 10}(9)])
pr2 = Polynom([Residue{Int, 10}(3), Residue{Int, 10}(12), Residue{Int, 10}(7)])
println(pr+pr2)
println(pr-pr2)
println(pr*pr2)
println((pr/pr2)[1])
