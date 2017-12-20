
@testset "Recursive splitting with forward linear maps of simplices" begin
    @testset "E = $E" for E in 2:4
        @testset "k = $k" for k in 2:4
        embedding = embedding_example(10, E, 1)

        # Triangulate all but the last point
        points, simplex_inds = triangulate(embedding[1:size(embedding, 1), :])

        # Take the images of the simplices in the triangulation as the forward projections
        # in time of the original simplices. Append first point of triangulation to
        # 'fake' an invariant set where the last point falls within the convex hull
        # of the triangulation
        image_indices = simplex_inds + 1
        image_points = vcat(points[2:end, :], embedding[1, :].')

        centroids, radii = centroids_radii2(points, simplex_inds)
        centroids_im, radii_im = centroids_radii2(image_points, simplex_inds)

        volumes_before = simplex_volumes(points, simplex_inds)
        imagevolumes_before = simplex_volumes(image_points, simplex_inds)

        radiusmax = max(maximum(radii), maximum(radii_im))
        maxradius_allowed = radiusmax * 0.4

        refined = refine_recursive_images(points, image_points, simplex_inds, maxradius_allowed, k)

        radiusmax_after_refinement = max(maximum(refined[6]), maximum(refined[7]))

        volumes_after_refinement = refined[8]
        imagevolumes_after_refinement = refined[9]




        # Check that the maximum simplex size has been reduced to the desired level
        @testset "Desired refinement level reached" begin
            @test radiusmax_after_refinement < maxradius_allowed
        end

        @testset "Triangulation volumes are preserved" begin
            @test sum(volumes_before) ≈ sum(volumes_after_refinement)
            @test sum(imagevolumes_before) ≈ sum(imagevolumes_after_refinement)
        end
        end
    end
end
