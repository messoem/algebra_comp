Base.@kwdef mutable struct Polynom
    coef::Vector{BigInt}
end


ord(p::Polynom) = length(p.coef) - 1

function Base.display(p::Polynom)
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

function Base. +(p1::Polynom, p2::Polynom)
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
    return Polynom(lst)
end


function Base. -(p1::Polynom, p2::Polynom)::Polynom
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
    return Polynom(lst)
end

function Base. *(p1::Polynom, p2::Polynom)::Polynom
    lst = [0 for i in 1:(length(p1.coef)+length(p2.coef)-1)]
    for i in 1:length(p1.coef)
        for j in 1:length(p2.coef)
            lst[i+j-1] += p1.coef[i]*p2.coef[j]
        end
    end
    return Polynom(lst)
end

function value(p::Polynom, a::T):: T where T
    pval = 0
    for i in 1:length(p.coef) 
        pval+= p.coef[i]*(a^(i-1))
    end
    return pval
end


p = Polynom([1, 3, 2])
p1 = Polynom([4, 5, 2])

print(p1*p)
x = Polynom([-1, 0, 2, 4, 0, -8])
print(x)
p2 = Polynom([1, 3, -2, 0,  4])
print(p2)
p3 = Polynom([-1, 3, -3, 1])
print(p3)
print(value(p3, 2))
