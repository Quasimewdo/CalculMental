#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

char niveau(){
    //Pour choisir le niveau de difficulté
    printf("\n*******************************************************\n");
    printf("         Veuillez choisir votre niveau du jeu          \n");
    printf("Niveau facile : taper 1\n");
    printf("Niveau medium : taper 2\n");
    printf("Niveau difficile : taper 3\n");
    printf("Votre choix : ");
    char n;
    scanf("%c", &n);
    printf("*******************************************************\n");
    printf("            Vous avez 20 calculs à effectuer           \n");
    return (n);
}

int easy(){
    //Mode easy: une addition ou soustraction entre deux valeurs compris entre 0 et 100
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
    //Valeur de soustraction ne peut pas être négatif
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
    //Mode Medium: composition de deux opérations (+, -, *) entre trois valeurs 
    //Multiplication entre une valeur compris entre O et 1000 et une valeur 0 et 10
    char ope[3] = {'+', '-', '*'};
    int result;
    time_t t;
    srand((unsigned) time(&t));

    int op1 = rand() % 3; // entre 0 et 2
    int op2 = rand() % 3; // entre 0 et 2
    int val1 = rand() % 101; // entre 0 et 100
    int val2;
    int val3;
    if (op2 != 2){
        switch (op1){
        case 0:
            val2 = rand() % 101;
            printf("%d %c %d ", val1, ope[op1], val2);
            result = val1 + val2;
            break;

        case 1:
            val2 = rand() % 101;
            printf("%d %c %d ", val1, ope[op1], val2);
            result = val1 - val2;
            break;
            
        case 2:
            val2 = rand() % 11;
            printf("%d %c %d ", val1, ope[op1], val2);
            result = val1 * val2;
            break;
        }
        switch (op2){
        case 0: 
            val3 = rand() % 101;
            printf("+ %d = ?\n", val3);
            result = result + val3;
            break;
        
        case 1: 
            val3 = rand() % 101;
            printf("- %d = ?\n", val3);
            result = result - val3;
            break;

        case 2:
            val3 = rand() % 11;
            printf("* %d = ?\n", val3);
            result = result * val3;
            break;
        }
    }
    else{
        val3 = rand() % 11;
        switch (op1){
        case 0:
            val2 = rand() % 101;
            printf("%d %c %d * %d = ?\n", val1, ope[op1], val2, val3);
            result = val1 + val2 * val3;
            break;

        case 1:
            val2 = rand() % 101;
            printf("%d %c %d * %d = ?\n", val1, ope[op1], val2, val3);
            result = val1 - val2 * val3;
            break;
            
        case 2:
            val2 = rand() % 11;
            printf("%d %c %d * %d = ?\n", val1, ope[op1], val2, val3);
            result = val1 * val2 * val3;
            break;
        }
        
    }
    
    return result;
}

int hard(){
    //Mode Hard: composition de deux opérations (+, -, *, /) entre trois valeurs 
    //Multiplication entre une valeur compris entre O et 1000 et une valeur 0 et 10
    //Division est entière
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
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 - op2;
        break;

    case 2:
        op2 = rand() % 11;
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = op1 * op2;
        break;

    case 3:
        op2 = rand() % 10 + 1;
        while(op1 % op2 != 0){
            /* pour avoir une division entiere */
            op1 = rand() % 101 + 1; // entre 0 et 100
            op2 = rand() % 10 + 1;
        }
        printf("%d %c %d = ?\n", op1, ope[op], op2);
        result = roundf(op1 / op2);
        break;
    }
    return result;
}


void comment(int n){
    //Donner l'appréciation selon la note obtenue
    printf("*******************************************************\n*                      %2d / 20                        *\n", n);
    if (n < 6)
        printf("*             Appréciation : Très Faible              *\n");
    else if (6 <= n && n < 9)
        printf("*                Appréciation : Faible                *\n");
    else if (9 <= n && n < 10)
        printf("*              Appréciation : Insuffisant             *\n");
    else if (10 <= n && n < 12)
        printf("*               Appréciation : Passable               *\n");
    else if (12 <= n && n < 14)
        printf("*                  Appréciation : Bien                *\n");
    else if (14 <= n && n < 16)
        printf("*               Appréciation : Assez Bien             *\n");
    else if (16 <= n && n < 18)
        printf("*                Appréciation : Très Bien             *\n");
    else
        printf("*                Appréciation : Excellent             *\n");
    printf("*******************************************************\n");
    printf("\n");
}

int note(char choix){
    //Compte et mettre à jour la note du jeu
    int mark=0;
    int result, answer; 

    for (int i = 0; i < 5; i++){
        printf("%d . ", i+1);
        switch (choix)
        {
        case '1':
            result = easy();
            break;

        case '2':
            result = medium();
            break;

        case '3':
            result = hard();
            break;
        
        default:
            printf("Erreur : Veuillez taper 1, 2 ou 3\n");
            printf("Votre choix : ");
            scanf("%c", &choix);
            printf("*******************************************************\n");
            return (note(choix));
        }
        scanf("%d", &answer);
        if (answer == result){
            mark++;
            printf("Vrai %d/20\n", mark);
        }
        else{
            printf("Faux %d/20     Résultat = %d \n", mark, result);
        }   
        printf("-------------------------------------------------------\n");
    }
    return (mark);
}

int main(){
    int level = niveau();
    int mark = note(level);
    comment(mark);

}