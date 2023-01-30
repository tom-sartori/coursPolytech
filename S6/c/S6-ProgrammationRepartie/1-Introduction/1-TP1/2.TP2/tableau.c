#include <stdio.h>


struct Point {
    int x;
    int y;
};

void printPoint (struct Point point) {
    printf("(%d; %d)\n", point.x, point.y);
}

struct Point initPoint (int x, int y) {
    struct Point point;
    point.x = x;
    point.y = y;
    return point;
}

int main(int argc, char** argv) {

    struct Point p1;
    p1.x = 3;
    p1.y = 3;

    printPoint(p1);

    struct Point p2 = initPoint(3, 4);
    printPoint(p2);
    p2.x = 5;
    printPoint(p2);
}



