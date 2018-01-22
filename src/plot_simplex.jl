using PlotlyJS

#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_simplex(simplex)

   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true,
                             margin = PlotlyJS.attr(l=0, r=0, b=0, t=65))


   s1 = hcat(simplex, simplex[1:end, 2])
   s1 = hcat(s1, s1[1:end, 3])
   s1 = hcat(s1, s1[1:end, 1])
   s1 = hcat(s1, s1[1:end, 4])

   trace = PlotlyJS.scatter3d(;x = s1[1, 1:end],
                              y = s1[2, 1:end],
                              z = s1[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 3, color = "black"),
                              line = PlotlyJS.attr(size = 1, color = "white"))

   push!(data, trace)

   PlotlyJS.plot(data, layout)
end


#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_simplex_and_point(simplex, p)
   simplex = simplex.'
   p = p.'
   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true,
                             margin = PlotlyJS.attr(l=0, r=0, b=0, t=65))


   s1 = hcat(simplex, simplex[1:end, 2])
   s1 = hcat(s1, s1[1:end, 3])
   s1 = hcat(s1, s1[1:end, 1])
   s1 = hcat(s1, s1[1:end, 4])

   trace = PlotlyJS.scatter3d(;x = s1[1, 1:end],
                              y = s1[2, 1:end],
                              z = s1[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 5, color = "black"),
                              line = PlotlyJS.attr(width = 3, color = "black"))

   push!(data, trace)

   trace_point = scatter3d(;x = p[1, 1:end],
                              y = p[2, 1:end],
                              z = p[3, 1:end],
                              name = "Convex combination of simplex vertices",
                           marker = PlotlyJS.attr(size = 10, color = "green"))
   push!(data, trace_point)

   PlotlyJS.plot(data, layout)
end


#' Plots a pair of simplices given as (dim+1)xdim array Float64 arrays.
function plot_simplices(simplex1, simplex2)
   simplex1 = simplex1.'
   simplex2 = simplex2.'
   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(;autosize = true,
                             margin = attr(l=0, r=0, b=0, t=65),
                             plot_bgcolor = "white",
                             paper_bgcolor = "white",
                             xaxis = attr(showgrid = true))


   s1 = hcat(simplex1, simplex1[1:end, 2])
   s1 = hcat(s1, s1[1:end, 3])
   s1 = hcat(s1, s1[1:end, 1])
   s1 = hcat(s1, s1[1:end, 4])

   trace = PlotlyJS.scatter3d(;x = s1[1, 1:end],
                              y = s1[2, 1:end],
                              z = s1[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 10, color = "black"),
                              line = PlotlyJS.attr(width = 3, color = "black"))

   push!(data, trace)

   s2 = hcat(simplex2, simplex2[1:end, 2])
   s2 = hcat(s2, s2[1:end, 3])
   s2 = hcat(s2, s2[1:end, 1])
   s2 = hcat(s2, s2[1:end, 4])

   trace = PlotlyJS.scatter3d(;x = s2[1, 1:end],
                              y = s2[2, 1:end],
                              z = s2[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 5, color = "blue"),
                              line = PlotlyJS.attr(width = 2, color = "blue"))

   push!(data, trace)

   PlotlyJS.plot(data, layout)
end



#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_simplex_and_triangulation(simplex1, triang_vertices, triang_simplex_indices)

   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true,
                             margin = PlotlyJS.attr(l=0, r=0, b=0, t=65))


   s1 = hcat(simplex1, simplex1[1:end, 2])
   s1 = hcat(s1, s1[1:end, 3])
   s1 = hcat(s1, s1[1:end, 1])
   s1 = hcat(s1, s1[1:end, 4])

   trace = PlotlyJS.scatter3d(;x = s1[1, 1:end],
                              y = s1[2, 1:end],
                              z = s1[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 3, color = "blue"),
                              line = PlotlyJS.attr(size = 1, color = "blue"))

   push!(data, trace)

   for i = 1:size(triang_simplex_indices, 1)
      s = triang_vertices[triang_simplex_indices[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])


      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                           y = s[2, 1:end],
                           z = s[3, 1:end],
                           mode = "markers+lines",
                           showlegend = false,
                           marker = PlotlyJS.attr(size = 3, color = "black"),
                           line = PlotlyJS.attr(size = 1, color = "white"))

      push!(data, trace)
   end


   PlotlyJS.plot(data, layout)
end


#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_triangulation(triang_vertices, triang_simplex_indices; col1 = "blue", col2 = "red" )

   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true,
                             margin = PlotlyJS.attr(l=0, r=0, b=0, t=65))

   colors = ["green", "red", "blue", "yellow", "black", "brown", "pink", "orange", "purple", "magenta"]
   for i = 1:size(triang_simplex_indices, 1)
      s = triang_vertices[triang_simplex_indices[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])


      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                           y = s[2, 1:end],
                           z = s[3, 1:end],
                           mode = "markers+lines",
                           showlegend = false,
                           marker = PlotlyJS.attr(size = 3, color = "white"),
                           line = PlotlyJS.attr(size = 1, color = "white", colors[rand(1:length(colors), 1)]))

      push!(data, trace)
   end

   PlotlyJS.plot(data, layout)
end



#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_triangulations(t1_points, t1_simplex_inds,
                            t2_points, t2_simplex_inds;
                             col1 = "blue", col2 = "red" )

   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true,
                             margin = PlotlyJS.attr(l=0, r=0, b=0, t=65))


   for i = 1:size(t1_simplex_inds, 1)
      s = t1_points[t1_simplex_inds[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])


      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                           y = s[2, 1:end],
                           z = s[3, 1:end],
                           mode = "markers+lines",
                           showlegend = false,
                           marker = PlotlyJS.attr(size = 3, color = "black"),
                           line = PlotlyJS.attr(size = 1, color = col1))

      push!(data, trace)

      s = t2_points[t2_simplex_inds[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])


      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                           y = s[2, 1:end],
                           z = s[3, 1:end],
                           mode = "markers+lines",
                           showlegend = false,
                           marker = PlotlyJS.attr(size = 5, color = "black"),
                           line = PlotlyJS.attr(size = 1, color = col2))

      push!(data, trace)
   end

   PlotlyJS.plot(data, layout)
end



#' Plots a pair of simplices given as dim x n_vertices Float64 arrays.
function plot_triangulation_and_refined_simplices(start_points, start_inds,
                            refined_points, refined_inds;
                             col1 = "black", col2 = "blue")

   data = PlotlyJS.GenericTrace[]

   layout = PlotlyJS.Layout(autosize = true)
   for i = 1:size(start_inds, 1)
      s = start_points[start_inds[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])

      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                              y = s[2, 1:end],
                              z = s[3, 1:end],
                              mode = "markers+lines",
                              showlegend = false,
                              marker = PlotlyJS.attr(size = 10, color = col1),
                              line = PlotlyJS.attr(width = 5, color = col1))

      push!(data, trace)
   end

   for i = 1:size(refined_inds, 1)
      s = refined_points[refined_inds[i, 1:end], 1:end].'
      s = hcat(s, s[1:end, 2])
      s = hcat(s, s[1:end, 3])
      s = hcat(s, s[1:end, 1])
      s = hcat(s, s[1:end, 4])


      trace = PlotlyJS.scatter3d(;x = s[1, 1:end],
                           y = s[2, 1:end],
                           z = s[3, 1:end],
                           mode = "markers+lines",
                           showlegend = false,
                           marker = PlotlyJS.attr(size = 5, color = col2),
                           line = PlotlyJS.attr(width = 3, color = col2))

      push!(data, trace)
   end

   PlotlyJS.plot(data, layout)
end
