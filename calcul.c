#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

int niveau(){
    printf("*******************************************************\n");
    printf("         Veuillez choisir votre niveau du jeu          \n");
    printf("Niveau facile : taper 1\n");
    printf("Niveau medium : taper 2\n");
    printf("Niveau difficile : taper 3\n");
    printf("Votre choix : ");
    int n;
    scanf("%d", &n);
    printf("*******************************************************\n");
    return (n);
}

int easy(){
    char ope[2] = {'+', '-'};
    int result;
    time_t t;
    srand((unsigned) time(&t));

    int op = rand() % 2;
    int op1 = rand() % 101;
    int op2 = rand() % 101;
    switch (op){
    case 0:
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 + op2;
        break;

    case 1:
        if (op1 > op2){
            printf("%d %c %d = ?\n", op1, ope[op], op2);
            result = op1 - op2;
        }
        else{
            printf("%d %c %d = ?\n", op2, ope[op], op1);
            result = op2 - op1;
        }
        break;
    }
    return result;
}

int medium(){
    char ope[3] = {'+', '-', '*'};
    int result;
    time_t t;  //pourquoi ne pas utiliser srand(time(NULL))
    srand((unsigned) time(&t));

    int op = rand() % 3; // entre 0 et 2
    int op1 = rand() % 101; // entre 0 et 100
    int op2;
    switch (op){
    case 0:
        op2 = rand() % 101;
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 + op2;
        break;

    case 1:
        op2 = rand() % 101;
        if (op1 > op2){
            printf("%d %c %d = ?\n", op1, ope[op], op2);
            result = op1 - op2;
        }
        else{
            printf("%d %c %d = ?\n", op2, ope[op], op1);
            result = op2 - op1;
        }
        break;
        
    case 2:
        op2 = rand() % 11;
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 * op2;
        break;
    }
    return result;
}

int hard(){
    char ope[4] = {'+', '-', '*', '/'};
    int result;
    time_t t;
    srand((unsigned) time(&t));

    int op = rand() % 4;
    int op1 = rand() % 101;
    int op2;
    switch (op){
    case 0:
        op2 = rand() % 101;
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 + op2;
        break;

    case 1:
        op2 = rand() % 101;
        if (op1 > op2){
            printf("%d %c %d = ?\n", op1, ope[op], op2);
            result = op1 - op2;
        }
        else{
            printf("%d %c %d = ?\n", op2, ope[op], op1);
            result = op2 - op1;
        }
        break;

    case 2:
        op2 = rand() % 11; // entre 0 et 10 
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 * op2;
        break;

    case 3:
        op2 = rand() % 10 + 1; // entre 1 et 10
        while(op1 % op2 != 0){ 
            /* pour avoir une division entiere */
            op1 = rand() % 101 ; // entre 0 et 100 
            op2 = rand() % 10 + 1;
        }
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = roundf(op1 / op2);
        break;
    }
    return result;
}


void comment(int n){
    printf("************************************\n*             %2d / 20              *\n", n);
    if (n < 6)
        printf("*    Appréciation : Très Faible    *\n");
    else if (6 <= n && n < 9)
        printf("*       Appréciation : Faible      *\n");
    else if (9 <= n && n < 10)
        printf("*    Appréciation : Insuffisant    *\n");
    else if (10 <= n && n < 12)
        printf("*      Appréciation : Passable     *\n");
    else if (12 <= n && n < 14)
        printf("*        Appréciation : Bien       *\n");
    else if (14 <= n && n < 16)
        printf("*     Appréciation : Assez Bien    *\n");
    else if (16 <= n && n < 18)
        printf("*     Appréciation : Très Bien     *\n");
    else
        printf("*     Appréciation : Excellent     *\n");
    printf("************************************\n");
}

int note(int choix){
    int mark=0;
    int result, answer; 
// On peut préciser que l'enfant aura 20 calculs a faire
    for (int i = 0; i < 20; i++){
        printf("%d . ", i+1);
        switch (choix)
        {
        case 1:
            result = easy();
            break;

        case 2:
            result = medium();
            break;

        case 3:
            result = hard();
            break;
        
        default:
            printf("Erreur : Veuillez taper 1, 2 ou 3\n");
            printf("Votre choix : ");
            scanf("%d", &choix);
            printf("*******************************************************\n");
            return (note(choix));
        }
        scanf("%d", &answer);
        if (answer == result){
            printf("Vrai \n");
            mark++;
        }
        else{
            printf("Faux \n");
            printf("Resultat = %d \n", result);
        }   
    }
    return (mark);
}

int main(){
    int level = niveau();
    int mark = note(level);
    comment(mark);

}