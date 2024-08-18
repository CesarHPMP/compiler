#include "analex.h"


typedef struct TreeNode {
    int data;
    struct ChildNode *children; 
} TreeNode;

typedef struct ChildNode {
    struct TreeNode *child;     
    struct ChildNode *next;    
} ChildNode;

TreeNode* createTreeNode(int data) {
    TreeNode *newNode = (TreeNode*)malloc(sizeof(TreeNode));
    newNode->data = data;
    newNode->children = NULL;
    return newNode;
}

void addChild(TreeNode *parent, TreeNode *child) {
    ChildNode *newChildNode = (ChildNode*)malloc(sizeof(ChildNode));
    newChildNode->child = child;
    newChildNode->next = NULL;

    if (parent->children == NULL) {
        parent->children = newChildNode;
    } else {
        ChildNode *current = parent->children;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newChildNode;
    }
}

void calcular(TreeNode *node) {
    if (node == NULL) 
        return;
    


    ChildNode *currentChild = node->children;
    while (currentChild != NULL) {
        postOrderTraversal(currentChild->child);
        currentChild = currentChild->next;
    }
    printf("%d ", node->data);
}

