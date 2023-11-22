program random_large_matrix
    use omp_lib
    implicit none

    ! Parameters
    integer :: n 

    ! Variables
    real(8),allocatable,dimension(:,:) :: matrix
    integer :: i, j
    real(8) :: StartTime1, StopTime1,  StartTime2, StopTime2, TimeTaken1, TimeTaken2, TimeTaken3, TimeTaken4
    integer,allocatable,dimension(:)::isuppz
    integer::INFO,LWORK,LIWORK
    !real(kind=dp),allocatable,dimension(:)::WORK
    real(8),allocatable,dimension(:)::WORK
    character(len=2) :: ValuePassed

    ! Read the integer from the command-line argument
    call get_command_argument(1, value=ValuePassed)
    write(*,*) "This works.", ValuePassed
    do n = 1000,10000,500
        LWORK=64*n
       

        allocate(matrix(n,n))
        allocate(isuppz(2*n))
        allocate(WORK(LWORK))

        ! Seed the random number generator
        call random_seed()

        ! Initialize the random matrix

        StartTime1 = OMP_GET_WTIME()
        !$OMP PARALLEL DO PRIVATE (i,j) SCHEDULE(STATIC)
        do i = 1, n
            do j = 1, i
                call random_number(matrix(j, i))
                matrix(i,j) = matrix(j,i)
            end do
        end do

        !$OMP END PARALLEL DO
        StopTime1 = OMP_GET_WTIME()
        write(*,'(A,F7.4)') "The elapsed time is:", StopTime1 - StartTime1

        StartTime1 = OMP_GET_WTIME()
        !call dgetrf(n,n,matrix,n,isuppz,info)
        StopTime1 = OMP_GET_WTIME()
        TimeTaken1 = StopTime1-StartTime1

        StartTime2 = OMP_GET_WTIME()
        !call dgetri(n,matrix,n,isuppz,work,lwork,info)
        StopTime2 = OMP_GET_WTIME()
        TimeTaken2 = StopTime2-StartTime2

        write(*,'(A,I5,A,3F6.3)') "Method dgetrf", n," is: ", TimeTaken1, TimeTaken2, TimeTaken1+TimeTaken2

        !StartTime1 = OMP_GET_WTIME()
        !call matinvNew(matrix, n)
        !StopTime1 = OMP_GET_WTIME()
        !TimeTaken1 = StopTime1-StartTime1
        !write(*,'(A,I5,A,F7.4,F7.4)') "Method 1 New", n," is: ", TimeTaken1
        
        
        StartTime1 = OMP_GET_WTIME()
        call matinv(matrix, n)
        StopTime1 = OMP_GET_WTIME()
        TimeTaken1 = StopTime1-StartTime1
        write(*,'(A,I5,A,F7.4,F6.3)') "Method 1", n," is: ",TimeTaken1

        
       

        StartTime1 = OMP_GET_WTIME()
        call mkl_dgetrfnp('U',n,matrix,n,isuppz,work,lwork,info)
        StopTime1 = OMP_GET_WTIME()
        TimeTaken1 = StopTime1 - StartTime1

        StartTime2 = OMP_GET_WTIME()    
        call dsytri('U',n,matrix,n,isuppz,work,info)
        StopTime2 = OMP_GET_WTIME() 
        TimeTaken2 = StopTime2 - StartTime2

        write(*,'(A,I5,A,F6.3,3F6.3)') "Method dsytrf", n," is: ", TimeTaken1, TimeTaken2, TimeTaken1+TimeTaken2


        StartTime1 = OMP_GET_WTIME()
        call dsytrf('U',n,matrix,n,isuppz,work,lwork,info)
        StopTime1 = OMP_GET_WTIME()
        TimeTaken1 = StopTime1 - StartTime1

        StartTime2 = OMP_GET_WTIME()    
        call dsytri('U',n,matrix,n,isuppz,work,info)
        StopTime2 = OMP_GET_WTIME() 
        TimeTaken2 = StopTime2 - StartTime2

        write(*,'(A,I5,A,F6.3,3F6.3)') "Method dsytrf", n," is: ", TimeTaken1, TimeTaken2, TimeTaken1+TimeTaken2



        write(ValuePassed,'(I5,4F6.3)')  n, TimeTaken1, TimeTaken2, TimeTaken3, TimeTaken4
        
        

        deallocate(matrix)
        deallocate(isuppz)
        deallocate(WORK)
        write(*,*) "   "


    end do

end program random_large_matrix