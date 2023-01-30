#include <stdio.h>
#include "List.h"


int main(int argc, char** argv) {
    printf("test \n");
    List* list = createList();
    Node* currentNode = insertFirst(list, 4, "Four");
    insertLast(list, 2, "Two");
    insertLast(list, 7, "Seven");
//    printList(list);

    printSelectedList(list, currentNode);
    printf("1 up, 2 down, 3 valid");

    int response = 0;


    while (response != 3) {
        scanf("%d", &response);
//    printf("%d", response);

        if (response == 1) {  // Up
            currentNode = getPrevious(currentNode);
            printSelectedList(list, currentNode);
            printf("1 up, 2 down, 3 valid");
        }
        else if (response == 2) { // Down
            currentNode = getNext(currentNode);
            printSelectedList(list, currentNode);
            printf("1 up, 2 down, 3 valid");
        }
        printf("\n");
    }




//
//    while (1 == 1) {
//        char c = getchar();
//        printf("%c", c);
//    }


//    insertLast(list, 10);
//    printListInt(list);
//
//    deleteFirst(list, 4);
//    printListInt(list);
//
//    int (*pDoubler) (int) = doubler;
//    map(list, pDoubler);
//    printListInt(list);
//
//    map(list, div2);
//    printListInt(list);


    return 1;
}