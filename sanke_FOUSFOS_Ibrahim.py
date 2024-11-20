################################### creation de la map +caractéristique de la map
from random import randint,random #ces modules permettent de generer des entier et un nombre à decimal compris entre 0 et 1
from time import sleep # ce module permet de ralentir l'éxecution du code et modifier la vitesse du serpent selon les difficulté grace à la variable 'temps' utiliser par la suite
import os # os permet de donner l'impression de bouger en effacant completement le terminal avant de redessiner la map avec les nouvelle postion du serpent et de la pomme



def config_jeu(): # config_ est une fonction qui permet de gerer les caractéristiques de la map du jeu xx c'est la longuer , yy la largeur , et m le symbole de la bordure de la map 
    global temps
    temps=0.7#la vitesse de base
    print('entrer un nom d\'utilisateur.....')
    global nom_du_joueur
    nom_du_joueur=str(input())
    print('choisissez la difficulté: 1 pour facile , 2 pour moyen , pour difficile 3 et 4 pour aléatoire.')
    global difficulté    
    difficulté=int(input())
    global xx
    global yy
    global m
    
    if difficulté==1:
        m=' #'
        xx=10
        yy=11
    elif difficulté==2:
        m=' §'
        xx=20
        yy=21
    elif difficulté==3:
        m=' %'
        xx=30
        yy=31
    elif difficulté==4:
        m=' $'
        xx=randint(10,40)
        yy=randint(10,40)
def creer_la_map():
    ######## la map:
    global map
    map=[] #liste vide (pour l'instant)
    x=0
    while x<=xx:#la double boucles permets d'avoir une listes de tuples (x,y) compris entre 0 et XX pour x et entre 0 et YY pour y . Cela vas nour permettre de dessiner la map plus tard grace aux cordonnées créer
        y=0
        while y<=yy:#on commence avec x=0 et y=0 que l'on va mettre dans le tuple 'l' puis on va commencer a remplir la list 'map' qui va contenir un premier couple (x,y)=(0,0). on a ajoute 1 à y et on recommence jusqu'à que y=yy (inclus).Maintenant on a ajoute 1 à x qui valait 0 et on remet y à 0 puis on recommence la boucle jusqu'à que x=xx.
            l=(x,y)
            map.append(l)
            y+=1
        x+=1
    ######### les objets

##################################### creation des objets

########## le serpent
def mouvement():# cette fonction permet le mouvement du serpent à chaque mouvement il y a un nouveau tuple qui rentre dans la liste corp_serpent qui le fait allonger de +1 et s'il ne mange pas de pomme ca que retrecit -1 au final on a juste l'impression qu'il a bouger. Lorsque une pomme est manger elle apparait dans un autre endroit de la map
    nouvelle_tete=corp_serpent[0][0]+direction[0],corp_serpent[0][1]+direction[1]
    corp_serpent.insert(0,nouvelle_tete)
    if manger():
        position_de_la_pomme()
    else:
        corp_serpent.pop(-1)
############la pomme
def position_de_la_pomme():# cette fonction permet de donner une nouvelle position a la pomme et elle est lancer quand la tete du seprent est à la meme position qu'elle.
        global pomme
        o=randint(1,xx-1) # nombre aléatoire entre 1 inclus et la bordure de la map exclus (d'où le xx-1 et yy-1)
        i=randint(1,yy-1)
        pomme=(o,i)
        if pomme in corp_serpent: #Si la nouvelle position se trouve dans le serpent alors une nouvelle postion est donner jusqu'à etres à un endroit different
            position_de_la_pomme()
def manger():# si le niveau de difficulter est de 3 ou 4 alors la pomme une fois manger va modifier la vitesse du serpent un chaque fois qu'elle est manger 
    global temps
    if corp_serpent[0]==pomme and difficulté==4 or difficulté==3:
        temps=random()/4 # nombre aléatoire entre 0 et 0,25
    if corp_serpent[0]==pomme:
        return True


###################################### DESSIN DE LA MAP

def dessiner_map():
    for case in map: # cette boucle for va verifier case par case ou tuple par tuple ou encore couple (x,y) par couple si certaine condition sont remplies
        if case == corp_serpent[0]: # si le couple (x,y) = aux cordonee du premier tuple du serpent alors on va dessiner la tete avec un 'D'
            print(' D',end='') #la tete sera afficher avec un D
        elif case == corp_serpent [-1]: # si le couple (x,y) = aux cordonee du dernier tuple du serpent alors on va dessiner la queu avec un 'c'
            print(' c', end= '')
        elif case in corp_serpent[1:len(corp_serpent)-1:]: # si le couple (x,y) = aux cordonee des tuple du deuxième à l'avant dernier tuple du serpent alors on va dessiner la queu avec un '='
            print(' =',end='')
        elif case[0] in (0,xx) or case[1] in [0,yy]:# ici il y a deux condition la premiere c'est de dessiner les bords sur la premiere et derniere colonnes (quand x=0 et x=xx) puis la deuxieme condition c'est de dessiner les bords des lignes donc quand y=0 et y=yy. cela est fait grace à (end='') qui permet de rester sur la meme ligne
            print(m,end='')
        elif case==pomme:# si la case à les meme coordonnées que la pomme alors on print un ' o' qui représente la pomme 
            print(' o', end='')
        else: #on remplie la map "d'éspace" quand x!=0 ,x!=xx et y!=0 , y!=yy
            print(' .',end='')
        if case[1] == yy: # on revient a la ligne un fois arriver a la derniere case de la ligne, on ne fait pas ('\n') car cela va faire revenir a la ligne deux fois
            print('')

############################################

def lacer_snake():
    config_jeu()
    creer_la_map()
    global pomme
    global direction
    global corp_serpent
    global DIRECTIONS
    pomme=(xx//2,yy//3) # la position de base de la pomme est à environ au centre de la map
    DIRECTIONS={'gauche':(0,-1),'bas':(1,0),'haut':(-1,0),'droite':(0,1)}#dictionnaire avec les different direction possibles
    direction=DIRECTIONS['droite']# la direction de base est vers la droite (y+=1)
    corp_serpent=[(5,5),(4,5),(3,5)] # le serpent qui va apparaître au debut de chaque partie aux coordonnés suivante (5,5),(4,5),(3,5)
    while True: #la boucle est infini jusqu'à ce que le serpent touche la bordure ou son propre corps.la boucle s'arretera et la partie sera perdu
        os.system('cls')
        print(f'joueur{nom_du_joueur}')
        print(f'score joueur:{len(corp_serpent)-3}points')
        mouvement()
        dessiner_map()
        sleep(temps)#c'est ce qui modifie la vitesse du serpent en faisant des "pauses" entre chaques actions
        b=str(input())# grace à ce input on peut controler le serppent si on clique sur d et entrer on va à droite , s en bas, z en haut et a à gauche
        droite='d'# ces variables valent chacune une lettre precise , cela n'est pas nécessaire mais pour que ca soit plus explicite et facile à comprendre j'ai decider de la faire ainsi
        gauche='q'
        haut='z'
        bas='s'
        if droite==b:
            direction=DIRECTIONS['droite']
        if gauche==b:
            direction=DIRECTIONS['gauche']
        if haut==b:
            direction=DIRECTIONS['haut']
        if bas==b:
            direction=DIRECTIONS['bas']
        if corp_serpent[0][0]== (0) or corp_serpent[0][1]== (0) or corp_serpent[0][0]== (xx) or corp_serpent[0][1]== (yy) or corp_serpent[0] in corp_serpent[1::1]:# c'est les conditions de la fin de la partie si la tete du serpent touche la bordure de la map ou son propre cors c'est la fin.
            print(f'dommage {nom_du_joueur} !vous avez perdu à {len(corp_serpent)-3}points!')
            break # c'est ce qui permet d'arreter la boucle infini
        
lacer_snake()