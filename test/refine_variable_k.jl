

@testset "Refine with variable splitting factor (k)" begin
    @testset "E = $E" for E in 3:7
        @testset "rep = $rep" for rep in 1:10
        println("E=",E, "\trep=",rep)
        ###########################################
        # A TRIANGULATION FROM A RANDOM POINT CLOUD
        ###########################################
        n_points = 10
        tau = 1
        embedding = embedding_example(n_points+E*2, E, tau)
        points, simplex_inds = triangulate(embedding[1:size(embedding, 1), :])

        # Take the images of the simplices in the triangulation as the forward projections
        # in time of the original simplices. Append first point of triangulation to
        # 'fake' an invariant set where the last point falls within the convex hull
        # of the triangulation
        impoints = vcat(points[2:end, :], embedding[1, :].')
        ########################
        # ORIGINAL TRIANGULATION
        ########################
        centroids, radii = centroids_radii2(points, simplex_inds)
        centroids_im, radii_im = centroids_radii2(impoints, simplex_inds)
        volumes = simplex_volumes(points, simplex_inds)
        volumes_im = simplex_volumes(impoints, simplex_inds)

        t = Triangulation(points, impoints, simplex_inds, centroids, radii, volumes, centroids_im, radii_im, volumes_im)

        volume_before = sum(t.volumes)
        imvolume_before = sum(t.volumes_im)

        ###########################################################################
        # VERIFY THAT DESIRED TARGET RADIUS GIVES DESIRED REDUCTION IN SIMPLEX SIZE
        ###########################################################################
        target_radius = min(minimum(t.radii), minimum(t.radii_im)) * 0.5
        # query = query_refinement(t, target_radius)
        #
        # @testset "Predicted maximum radius is smaller than target_radius" begin
        #    @test maximum(query.resulting_radii) <= target_radius
        # end

        # ####################################
        # # PERFORM TRIANGULATION REFINEMENT
        # ####################################
        refine_variable_k!(t, target_radius)

        volume_after = sum(t.volumes)
        imvolume_after = sum(t.volumes_im)

        @testset "Splitting preserved volumes" begin
            @test volume_before ≈ volume_after atol = 0.00001
            @test imvolume_before ≈ imvolume_after atol = 0.00001
        end

    end
    end
end
