module Geometry

function vector_angle(A::Vector{<:Real}, B::Vector{<:Real})
    (length(A) == length(B) == 2) || throw(ArgumentError("Incorrect vector length. $(length(A))=$(length(B))=2"))
    atan(B[2] - A[2], B[1] - A[1])
end

export vector_angle

end
