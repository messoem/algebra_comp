Base.@kwdef mutable struct Polinomial_of_one_variable
    coef::Vector{BigInt}
end

function print_degree(p::Polinomial_of_one_variable)
    return length(p.coef)
end

function sum_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
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
    return Polinomial_of_one_variable(lst)
end


function subtraction_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
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
    return Polinomial_of_one_variable(lst)
end

function multiplication_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
    lst = [0 for i in 1:(length(p1.coef)+length(p2.coef)-1)]
    for i in 1:length(p1.coef)
        for j in 1:length(p2.coef)
            lst[i+j-1] += p1.coef[i]*p2.coef[j]
        end
    end
    return Polinomial_of_one_variable(lst)
end


p = Polinomial_of_one_variable([1, 3, 2])
p1 = Polinomial_of_one_variable([4, 5, 2])
println("------------")

println(p.coef)
println("------------")
print_degree(p)
println("------------")
println(sum_of_pol(p, p1).coef)
println("------------")
println(subtraction_of_pol(p1, p).coef)
println("------------")
println(multiplication_of_pol(p, p1).coef)
