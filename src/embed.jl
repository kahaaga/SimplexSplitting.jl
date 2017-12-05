"""
    embed(ts::Vector{Float64}, E::Int, tau::Int)

Embed a time series `ts` in `E` dimensions with embedding lag `tau`.
"""
function embed(ts::Vector{Float64}, E::Int, tau::Int)
  n::Int = length(ts)

  # Initialize
  embedded_ts = zeros(Float64, E, n - ((E - 1) * tau))
  l::Int = n - ((E - 1) * tau)

  for i in 1:E
    start_index = 1 + (i - 1) * tau
    stop_index  = start_index + l - 1
    embedded_ts[i, :] = ts[start_index:stop_index]
  end
  return embedded_ts.'
end

"""
    embedding_example(n_points::Int, m::Int, tau::Int)

Create an example embedding consisting of `n_points` points in `E` dimension space,
using embedding lag `tau`.
"""
function embedding_example(n_points::Int, E::Int, tau::Int)
  ts = randn(n_points)
  embedding = embed(ts, E, tau)
end
