#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#define TOTALE 5

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
    printf("            Vous avez %2d calculs a effectuer           \n",TOTALE);
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
    //Mode Medium: composition deux opérateurs (+, -, *) et trois valeurs 
    //Multiplication entre une valeur compris entre O et 100 et une valeur 0 et 10
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
    /* Mode Hard : composition de 3 operateurs choist parmi (+ - * /) et 4 valeurs
    Obligation d'une division entiere entre valeurs 1 et 100
    Multiplication de valeurs comprises entre 0 et 100*/
    char ope[4] = {'+','-','*','/'};
    int result;
    time_t t;
    srand((unsigned) time(&t));

    int op1 = rand() % 4;
    int op2 = rand() % 4;
    int op3 = rand() % 4;
    /*opfictif aide a savoir quel operateur doit etre avant la div*/
    int opfictif = rand() % 3;
    int val1 = rand() % 101; //val entre 1 et 100
    int val2;
    int val3;
    int val4;
    if(op3 != 3 && op2 != 3){
        switch (op1){
            case 0:
                val2 = rand() % 101;
                printf("%d %c %d ",val1,ope[op1],val2);
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

            case 3:
                val2 = rand() % 10 + 1;
                while(val1 % val2 != 0){
                    val1 = rand() % 100 + 1;
                    val2 = rand() % 10 + 1;
                }
                printf("(%d %c %d) ",val1,ope[op1],val2);
                result = roundf(val1/val2);
                break;
            }
        switch(op2){
            case 0:
                val3 = rand() % 101;
                printf("%c %d",ope[op2],val3);
                result = result + val3;
                break;
            case 1:
                val3 = rand() % 101;
                printf("%c %d",ope[op2],val3);
                result = result - val3;
                break;
            case 2:
                val3 = rand() % 11;
                printf("%c %d",ope[op2],val3);
                result = result * val3;
                break;
        }
        switch(op3){
            case 0:
                val4 = rand() % 101;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result + val4;
                break;
            case 1:
                val4 = rand() % 101;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result - val4;
                break;
            case 2:
                val4 = rand() % 11;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result * val4;
                break;
        }
    }
    else if(op2 == 3){
        switch (opfictif){ // + ; - ; *
            case 0:
                printf("%d %c ",val1,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) ",val2,val3);
                val2 = roundf(val2 / val3);
                result = val1 + val2;
                break;

            case 1:
                printf("%d %c ",val1,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) ",val2,val3);
                val2 = roundf(val2 / val3);
                result = val1 + val2;
                break; 

            case 2:
                printf("%d %c ",val1,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) ",val2,val3);
                val2 = roundf(val2 / val3);
                result = val1 + val2;
                break;
        }
        switch(op3){
            case 0:
                val4 = rand() % 101;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result + val4;
                break;
            case 1:
                val4 = rand() % 101;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result - val4;
                break;
            case 2:
                val4 = rand() % 11;
                printf("%c %d = ?\n",ope[op3],val4);
                result = result * val4;
                break;
        }
        
    }
    else if (op3 == 3){
        switch (op1){
            case 0:
                val2 = rand() % 101;
                printf("%d %c %d ",val1,ope[op1],val2);
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
        switch(opfictif){ // + ; - ; *
            case 0:
                printf("%d %c ",result,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) = ?\n ",val2,val3);
                val2 = roundf(val2 / val3);
                result = result + val2;
                break;

            case 1:
                printf("%d %c ",result,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) = ?\n ",val2,val3);
                val2 = roundf(val2 / val3);
                result = result + val2;
                break;
                
            case 2:
                printf("%d %c ",result,ope[opfictif]); 
                val2 = rand() % 101;
                val3 = rand() % 10 + 1;
                while(val2 % val3 != 0){
                    val2 = rand() % 100 + 1;
                    val3 = rand() % 10 + 1;
                }
                printf("(%d / %d) = ?\n ",val2,val3);
                val2 = roundf(val2 / val3);
                result = result + val2;
                break;
                
        } 
    }
    return result;
}



void comment(int n){
    //Donner l'appréciation selon la note obtenue
    printf("*******************************************************\n*                      %2d / %2d                        *\n", n,TOTALE);
    if (n < 6)
        printf("*             Appreciation : Tres Faible              *\n");
    else if (6 <= n && n < 9)
        printf("*                Appreciation : Faible                *\n");
    else if (9 <= n && n < 10)
        printf("*              Appreciation : Insuffisant             *\n");
    else if (10 <= n && n < 12)
        printf("*               Appreciation : Passable               *\n");
    else if (12 <= n && n < 14)
        printf("*                  Appreciation : Bien                *\n");
    else if (14 <= n && n < 16)
        printf("*               Appreciation : Assez Bien             *\n");
    else if (16 <= n && n < 18)
        printf("*                Appreciation : Tres Bien             *\n");
    else
        printf("*                Appreciation : Excellent             *\n");
    printf("*******************************************************\n");
    printf("\n");
}

int note(char choix){
    //Compte et mettre à jour la note du jeu
    int mark=0;
    int result, answer; 

    for (int i = 0; i < TOTALE; i++){
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
            printf("Faux %d/20     Resultat = %d \n", mark, result);
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