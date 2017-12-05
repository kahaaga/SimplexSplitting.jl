"""
    triangulate(points::Array{Float64, 2})

Triangulate a set of vertices in N dimensions. `points` is an array of vertices, where
each row of the array is a point.
"""
function triangulate(points::Array{Float64, 2})
  SimplexIntersection.QHull.delaunay_tesselation(points)
end