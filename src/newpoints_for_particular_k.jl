

function newpoints_for_particular_k!(new_points, new_impoints, split_inds)
    # Fill the array by looping over all simplices that we want to split
    for i = 1:length(inds_toolarge)
        # Figure out what the row indices corresponding to the ith simplex
        # must be. Marks the beginning of each of the simplex stacks in new_points
        k = string(ks[i])
        n_newverts_persplit = size(rules[k], 1)
        ind = n_newverts_persplit * (i - 1)

        # Index of the simplex we need to split
        simplex_idx = inds_toolarge[i]

        # Get the vertices of the simplex currently being splitted. Each of the
        # n_newverts_persplit new vertices will be a linear combination
        # of these vertices. Each row is a vertex.
        ith_simpl_vertices = points[simplex_inds[simplex_idx, :], :]
        ith_simpl_imvertices = impoints[simplex_inds[simplex_idx, :], :]

        # Create new vertices within parent simplex as linear combinations of its original
        # vertices such that each generated new vertex lies strictly within the simplex
        for j = 1:n_newverts_persplit
            # Rules for constructing the jth subsimplex (i. e. indices indicating
            # which of the vertices of the parent simplex to combine into the jth
            # subsimplex; could be for example [1, 1, 2, 4], meaning that the new
            # vertex will be the following linear combination of the original vertices:
            # (2*V1 + 1*V2 + 1*V4)/(splitting factor).
            jth_simpl_rules = rules[k][j, :]


            original_points = ith_simpl_vertices[jth_simpl_rules, :]
            original_impoints = ith_simpl_imvertices[jth_simpl_rules, :]

            append!(new_points, sum(original_points, 1) ./ ks[i])
            append!(new_impoints, sum(original_impoints, 1) ./ ks[i])
        end
    end

    new_points = reshape(new_points, ÷(length(new_points), dim), dim)
    new_impoints = reshape(new_impoints, ÷(length(new_points), dim), dim)
end
