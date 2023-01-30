# Cleaning
rm -rf ./target/*
> ./logs/errors.log

touch ./source/sansDroit1.txt
chmod 0 ./source/sansDroit1.txt

touch ./source/sansDroit2.txt
chmod 0 ./source/sansDroit2.txt

# run
gcc main.c

# argv[1] = dossier départ
# argv[2] = dossier arrivée
./a.out source target