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

function Base. -(x::Residue{T, M}, y::Residue{T, M}) where {T, M}
    c = x.a - y.a
    return Residue{Int, M}(c)
end

function Base.println(x::Residue{T, M}) where {T, M}
    println(x.a)
end
function Base.print(x::Residue{T, M}) where {T, M}
    print(x.a)
end
function Base. !(x::Residue{T, M}) where {T, M}
    a, v, u = ecd(x, M)
    if a != 1
        return Nothing
    else
        return  Residue{Int, M}(mod(v, n))
    end
    
end
