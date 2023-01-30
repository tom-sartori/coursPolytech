#include <stdlib.h>
#include "Node.h"

Node* createNode (int value, char *text) {
    Node *node = malloc(sizeof(*node));
    if (node == NULL) {
        exit(EXIT_FAILURE);
    }

    node->previous = NULL;
    node->next = NULL;

    node->value = value;
    node->text = text;
    return node;
}

