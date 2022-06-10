# Créez un programme qui reçoit une expression arithmétique dans une chaîne de caractères et en retourne le résultat après l’avoir operationé.


# Mes fonctions
def parenthese(tableau)
    a, b = tableau.index('('), tableau.index(')')
    tableau[a+1..b-1]
end

def supr_parenthese(tableau)
    a, b = tableau.index('('), tableau.index(')')
    tableau[a..b]
end

def ordre(tableau)
    symbol = ["*", "/", "%", "+", "-"]
    a = []
    symbol.each do |signe|
        if tableau.include?(signe)
            a << tableau.index(signe)
        end
    end
    tableau = tableau[(a[0])-1..(a[0])+1]
end

def calcul(tableau)
    nb1, nb2, signe = tableau[0].to_i, tableau[2].to_i, tableau[1]
    if signe == "*"
        nb1 * nb2
    elsif signe == "/"
        nb1 / nb2
    elsif signe == "%"
        nb1 % nb2
    elsif signe == "+"
        nb1 + nb2
    elsif signe == "-"
        nb1 - nb2
    end
end

def remplace(tableau, tableau_a_calculer, calcul)
    tableau = tableau.join(' ').gsub!(tableau_a_calculer, calcul)
    tableau.split(' ')
end

# Gestion erreur
(puts "error"; exit) if ARGV.size > 1
(puts "error only integer"; exit) if !ARGV.join(' ').match?(/\d/)

# Resolution
operation = ARGV[0].gsub('(', '( ').gsub(')', ' )').split(' ')
recup_parenthese = parenthese(operation)

while recup_parenthese.size != 1
    maj = []
    maj << ordre(recup_parenthese)
    maj << calcul(maj[0])
    maj << remplace(recup_parenthese, maj[0].join(' '), maj[1].to_s)
    recup_parenthese.replace(maj[2])
    maj.clear
end

maj2 = supr_parenthese(operation)
maj2 = remplace(operation, maj2.join(' '), recup_parenthese.join(' '))
operation.replace(maj2)

while operation.size != 1
    maj3 = []
    maj3 << ordre(operation)
    maj3 << calcul(maj3[0])
    maj3 << remplace(operation, maj3[0].join(' '), maj3[1].to_s)
    operation.replace(maj3[2])
    maj3.clear
end

# Affichage
puts operation