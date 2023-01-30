#include <stdlib.h>
#include <stdio.h>
#include "List.h"

List* createList () {
    List* list = malloc(sizeof(*list));
    if (list == NULL) {
        exit(EXIT_FAILURE);
    }
    Node* node = createNode(0, NULL);
    list->head = node;
    return list;
}

int getSize (List* list) {
    return list->head->value;
}

int increaseSize (List* list) {
    list->head->value ++;
    return list->head->value;
}

int decreaseSize (List* list) {
    list->head->value --;
    return list->head->value;
}

Node* insertFirst (List* list, int value, char* text) {
    increaseSize(list);

    Node* new = createNode(value, text);
    new->next = list->head->next;
    list->head->next = new;

    new->previous = list->head;

    return new;
}

Node* insertLast (List* list, int value, char* text) {
    increaseSize(list);

    Node* new = createNode(value, text);
    Node* current = list->head;
    while (current->next != NULL) {
        current = current->next;
    }
    new->next = current->next;  // NULL
    current->next = new;

    new->previous = current;

    return new;
}

void deleteFirst (List* list, int value, const char* text) {
    Node* current = list->head->next;

    while (current != NULL && (current->value != value || current->text != text) ) {
        current = current->next;
    }

    if (current == NULL) {
        return;
    }
    else {  // current == (value, text)
        current->previous->next = current->next;
        if (current->next != NULL) {
            current->next->previous = current->previous;
        }
        decreaseSize(list);
        free(current);
    }
}

void printList (List* list) {
    if (list == NULL) {
        exit(EXIT_FAILURE);
    }

    printf("List | size : %d \n", getSize(list));

    Node* current = list->head;
    int i = 0;
    while (current->next != NULL) {
        current = current->next;
        printf("%d | %d %s \n", i, current->value, current->text);
        i++;
    }
    printf("NULL");
}

void printSelectedList (List* list, Node* selectedNode) {
    if (list == NULL) {
        exit(EXIT_FAILURE);
    }

    printf("List | size : %d \n", getSize(list));

    Node* current = list->head;
    int i = 0;
    while (current->next != NULL) {
        current = current->next;
        if (current == selectedNode) {
            printf(" -> ");
        }
        else {
            printf("    ");
        }
        printf("%d %s \n", current->value, current->text);
        i++;
    }
    printf("    NULL \n");
}


void printListInt (List* list) {
    if (list == NULL) {
        exit(EXIT_FAILURE);
    }

    printf("List | size : %d \n", getSize(list));
    printf("[");
    Node* current = list->head;
    int i = 0;
    while (current->next != NULL) {
        current = current->next;
        printf("%d, ", current->value);
        i++;
    }
    printf("NULL]\n\n");
}


void map (List* list, int (*f) (int)) {
    Node* current = list->head;
    if (current == NULL) {
        return;
    }
    while (current->next != NULL) {
        current = current->next;
        current->value = f(current->value);
    }
}

int doubler (int x) {
    return x*2;
}

int div2 (int x) {
    return (int)x/2;
}


Node* getNext (Node* current) {
    if (current->next == NULL) {
        return current;
    }
    else {
        return current->next;
    }
}

Node* getPrevious (Node* current) {
    if (current->previous->previous == NULL) {  // current->previous == head
        return current;
    }
    else {
        return current->previous;
    }
}




