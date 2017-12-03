
# k = the size reducing factor.
# d = dimension
# Finds all the possible ways of
function simplex_splitting(k::Int, d::Int)

    factor::Int = k^d

    matrices_simplicial_subdivision::Array{Int, 2} = zeros((d + 1) * factor, k)

    sequences::Array{Int, 2} = tensordecomposition(k, d)

    χ::Array{Int, 2} = sequences .* (d+1) +
                                repmat(collect(1:d).', size(sequences, 1), 1)
    χ = sort(χ, 2)

    #return size(sequences)

    for a = 1:size(sequences, 1)
        tmp = ones(Int, k * (d+1), 1)
        for b = 1:(d-1)
            #@show size(tmp), χ[a, b] + 1, χ[a, b+1]
            #@show tmp[(χ[a, b] + 1):(χ[a, b+1])]
            tmp[(χ[a, b] + 1):(χ[a, b+1])] = (b+1) * ones(χ[a, b+1] - χ[a, b], 1)
        end

        tmp[(χ[a, d]+1):size(tmp, 1)] = (d+1) * ones(size(tmp, 1) - χ[a, d], 1)

        indices = ((a-1) * (d + 1) + 1):(a*(d + 1))
        matrices_simplicial_subdivision[indices, :] = reshape(tmp, d + 1, k)
    end


    simplex_orientations = zeros(Float64, factor, 1)
    Χ_values = zeros(Int, d, 1)

    for i = 1:size(simplex_orientations, 1)
        indices::Vector{Int} = ((d+1) * (i - 1) + 1):((d + 1) * i)
        Χi = matrices_simplicial_subdivision[indices, :]

        ΔΧi = (Χi[2:(d+1), :] - Χi[1:d, :]) .* repmat(collect(1:k).', d, 1)

        transition_ind = round.(Int, ΔΧi * ones(k, 1))

        M = zeros(d, d)

        for j = 1:d
            Χ_values[j] =  Χi[j, transition_ind[j]]
            M[j, Χ_values[j]] = 1
        end

        simplex_orientations[i] = det(M) / factor
    end

    return matrices_simplicial_subdivision, simplex_orientations
end
