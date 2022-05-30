# Créez un programme qui affiche un rectangle dans le terminal.

# Ma fonction
def longueur_rectangle(tableau, centre, nb)
    taille = nb - 2
    taille.times { tableau.insert(1, centre) }
    return tableau
end

def largeur_rectangle(tableau)
    etages = []
    taille = ARGV[1].to_i - 2
    taille.times { etages << tableau.join }
    return etages
end

def afficher_rectangle(longueur, largeur, nb, nb2, centre)
    if nb <= 1 and nb2 <= 1
        puts longueur[0]
    elsif nb > 1 and nb2 == 1
        puts longueur.join
    elsif nb > 1 and nb2 == 2
        puts longueur.join
        puts centre.join
    else nb > 1 and nb2 > 2
        puts longueur.join
        puts largeur
        puts longueur.join
    end
end

# Gestion erreur
(puts "error, two number expected"; exit) if ARGV.size != 2
(puts "error only integer"; exit) if !ARGV.join(' ').match?(/\d/)

# Parsing
angle, cote = ["o","o"], ["|","|"]
haut, milieu = "-", " "
nb, nb2 = ARGV[0].to_i, ARGV[1].to_i
longueur = longueur_rectangle(angle, haut, nb)
centre_rectangle = longueur_rectangle(cote, milieu, nb)
largeur = largeur_rectangle(centre_rectangle)

# Affichage
afficher_rectangle(longueur, largeur, nb, nb2, centre_rectangle)