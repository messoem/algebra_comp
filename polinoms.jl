mutable struct Polinomial_of_one_variable
    coef::Vector{BigInt}=0
    degree::BigInt = length(coef)
end

function sum_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
    result_of_sum = Polinomial_of_one_variable()
    if length(p1) >= length(p2)
        for i in 1:length(p1)
            if i <= length(p2)
                push!(result_of_sum.coef, p1[i] + p2[i])
            else
                push!(result_of_sum.coef, p1[i])
            end
        end
    end
    if length(p1) < length(p2)
        for i in 1:length(p2)
            if i <= length(p1)
                push!(result_of_sum.coef, p1[i] + p2[i])
            else
                push!(result_of_sum.coef, p2[i])
            end
        end
    end
    return result_of_sum
end

function subtraction_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
    result_of_sum = Polinomial_of_one_variable()
    if length(p1) >= length(p2)
        for i in 1:length(p1)
            if i <= length(p2)
                push!(result_of_sum.coef, p1[i] - p2[i])
            else
                push!(result_of_sum.coef, p1[i])
            end
        end
    end
    if length(p1) < length(p2)
        for i in 1:length(p2)
            if i <= length(p1)
                push!(result_of_sum.coef, p1[i] - p2[i])
            else
                push!(result_of_sum.coef, -p2[i])
            end
        end
    end
    return result_of_sum
end

function multiplication_of_pol(p1::Polinomial_of_one_variable, p2::Polinomial_of_one_variable)::Polinomial_of_one_variable
    result_of_sum = Polinomial_of_one_variable()
    result_of_sum.coef = [0 for i in 1:(length(p1.coef)+length(p2.coef))]
    for i in 1:length(p1.coef)
        for j in 1:length(p2.coef)
            result_of_sum.coef[i+j+1] = p1.coef[i]*p2.coef[j]
    return result_of_sum
end
