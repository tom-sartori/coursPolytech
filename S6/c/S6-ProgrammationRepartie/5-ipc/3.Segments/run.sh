gcc semDestruct.c -o semDestruct
./semDestruct ./

gcc shmDestruct.c -o shmDestruct
./shmDestruct ./

gcc shmInit.c -o shmInit
./shmInit 5 ./