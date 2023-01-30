#include "Node.h"

typedef struct List List;

struct List {
    struct Node* head;
};

List* createList ();
int getSize (List* list);
int increaseSize (List* list);
int decreaseSize (List* list);

Node* insertFirst (List* list, int value, char* text);
Node* insertLast (List* list, int value, char* text);
void deleteFirst (List* list, int value, const char* text);

void printList (List* list);
void printSelectedList (List* list, Node* selectedNode);
void printListInt (List* list);

void map (List* list, int (*f) (int));
int doubler (int x);
int div2 (int x);

Node* getNext (Node* current);
Node* getPrevious (Node* current);
