"""
    even_sampling_rules(dim::Int, split_factor::Int)
We want to generate evenly distributed centroids within a simplex. To do this,
we perform a shape-preserving splitting of the simplex. Given a splitting factor,
this function returns the convex expansion coefficients of the centroids of the resulting subsimplices in terms of the vertices of the original simplex.

This would be applied to simplices represented by (dim + 1)xdim-sized arrays.
"""
function even_sampling_rules(dim::Int, split_factor::Int)

    sequences::Array{Int, 2} = SimplexSplitting.tensordecomposition(split_factor, dim)
    n_seq = size(sequences, 1)

    χ1 = sequences .* (dim + 1)
    χ2 = repmat(collect(1:dim).', n_seq, 1)
    χ::Array{Int, 2} = χ1 .+ χ2
    χ = sort(χ, 2)

    # Define multiplicity matrix M
    M = Array{Float64}(size(χ, 1), size(χ, 2) + 1)
    M[:, 1] = χ[:, 1]
    M[:, 2:(end - 1)] = χ[:, 2:end] - χ[:, 1:(end - 1)]
    M[:, end] = (dim+1)*split_factor * ones(size(χ, 1)) - χ[:, end]

    M = M ./ (split_factor * (dim + 1))

    return M.'
end

"""
Evenly sample points within a simplex by performing a shape-preserving
subdivision of the simplex with a given `split_factor`. If the simplex
lives in a space of dimension `dim`, the resulting number of points is
`split_factor`^(dim).
"""
function evenly_sample(simplex::AbstractArray{Float64, 2}, split_factor::Int)
    dim = size(simplex, 2)
    centroids_exp_coeffs = even_sampling_rules(dim, split_factor)
    centroids_exp_coeffs * simplex
end
