"""
    tensordecomposition(k::Int, d::Int)

Decomposition of the integers  0:(k^p - 1) in powers of k.


"""
function tensordecomposition(k::Int, d::Int)

    sequences = zeros(Integer, k^d, d)

    for n = 0:k^d-1
        i = d
        m = n

        while i > 0
            i = i - 1
            j = i
            f = floor(Int, m / k^i)

            while j > 0 && f == 0
                j = j - 1
                f = floor(Integer, m / k^j)
            end

            if f > 0
                sequences[n + 1, j + 1] = f
                i = j
            elseif f == 0
                sequences[n + 1, 1] = m
                i = 0
            end
            m = m - f * k^i
        end
    end

    return sequences
end
