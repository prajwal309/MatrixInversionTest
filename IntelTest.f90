program matrix_inverse
    use MKL95_PRECISION, only: dp => wp
    implicit none

    integer, parameter :: n = 4  ! Example matrix size
    real(dp) :: A(n, n), work(n)
    real(dp) :: anorm, rcond
    integer :: info, i, j
    integer :: ipiv(n)

    ! Example matrix (symmetric positive definite)
    A = reshape([ &
        4.0_dp, -1.0_dp, 0.0_dp, 0.0_dp, &
        -1.0_dp, 4.0_dp, -1.0_dp, 0.0_dp, &
        0.0_dp, -1.0_dp, 4.0_dp, -1.0_dp, &
        0.0_dp, 0.0_dp, -1.0_dp, 4.0_dp], shape(A))

    ! Step 1: Perform Cholesky decomposition
    call dpotrf('L', n, A, n, info)
    if (info /= 0) then
        print *, 'Cholesky decomposition failed'
        stop
    end if

    ! Step 2 (Optional): Estimate the condition number
    anorm = dlansy('1', 'L', n, A, n)
    call dpocon('L', n, A, n, anorm, rcond, work, ipiv, info)
    if (info /= 0) then
        print *, 'Condition number estimation failed'
        stop
    end if
    print *, 'Estimated condition number:', 1.0_dp / rcond

    ! Step 3: Compute the inverse
    call dpotri('L', n, A, n, info)
    if (info /= 0) then
        print *, 'Matrix inversion failed'
        stop
    end if

    ! Print the inverse matrix
    do i = 1, n
        do j = 1, i  ! Only lower triangle is computed
            print '("A(",I1,",",I1,") = ", F6.2)', i, j, A(i, j)
        end do
    end do

end program matrix_inverse