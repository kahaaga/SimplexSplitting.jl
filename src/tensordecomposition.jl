""" Decomposition of the integers  0:(k^p - 1) in powers of k.

"""
function tensordecomposition(k::Int, p::Int)

    t::Vector{Int} = collect(0:k^p-1)
    exponent::Array{Float64, 2} = repmat((1 ./ k .^ collect(0:p-1)).', k^p, 1)

    T::Array{Int, 2} = floor.(repmat(t, 1, p) .* exponent)
    T[:, 1:p-1] = T[:, 1:p-1] - k .* T[:, 2:p]

    # Returns an array of dimension k^p x p.
    # Each row contains the decomposition of the index of the row minus one

    return T

end
