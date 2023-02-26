
Base.@kwdef mutable struct Polynom{T}
    coef::Vector{T}
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
    lst = [0 for i in 1:(length(p1.coef)+length(p2.coef)-1)]
    for i in 1:length(p1.coef)
        for j in 1:length(p2.coef)
            lst[i+j-1] += p1.coef[i]*p2.coef[j]
        end
    end
    return Polynom{T}(lst)
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


p = Polynom{BigInt}([1, 3, 2])
p1 = Polynom{BigInt}([4, 5, 2])

println(p1*p)
x = Polynom([-1, 0, 2, 4, 0, -8])
println(x)
p2 = Polynom([1, 3, -2, 0,  4])
println(p2)
p3 = Polynom([-1, 3, -3, 1])
println(p3)
println(value(p3, 2))
println(ord(Polynom{BigInt}([1, 2, 3])))
