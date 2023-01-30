typedef struct Node Node;

struct Node {
    Node* previous;
    Node* next;

    int value;
    char *text;
};

Node* createNode (int value, char *text);
