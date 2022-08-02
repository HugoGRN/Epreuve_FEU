# Créez un programme qui trouve le plus court chemin entre l’entrée et la sortie d’un labyrinthe en évitant les obstacles.
# Le labyrinthe est transmis en argument du programme. La première ligne du labyrinthe contient les informations pour lire la carte :
# LIGNESxCOLS, caractère plein, vide, chemin, entrée et sortie du labyrinthe. 
# Le but du programme est de remplacer les caractères “vide” par des caractères “chemin” pour représenter
# le plus court chemin pour traverser le labyrinthe. Un déplacement ne peut se faire que vers le haut, le bas, la droite ou la gauche.


# My function
def file_to_array(file_name)
    cat = File.readlines(file_name).map { |line| line.chomp.split('') }
end

def deplacement_possible(map, map2, tab, pos, save)
    r, c, loc = [1,-1,0,0], [0,0,1,-1], pos.shift(2)
    for k in 0..3
        tab.push(loc[0]+r[k], loc[1]+c[k]) if map[loc[0]+r[k]][loc[1]+c[k]] == " " || map[loc[0]+r[k]][loc[1]+c[k]] == "2" and map2[loc[0]+r[k]][loc[1]+c[k]] == 0
    end
    map2[loc[0]][loc[1]] = 1
    save.push(loc[0], loc[1]) if tab.size > 1
end

# Gestion error
(puts "error 1 file expected"; exit) if ARGV.size != 1
(puts "error file doesn't exist"; exit) if !File.exists?(ARGV[0])

# Parsing
labyrinthe = file_to_array(ARGV[0])
infos_labyrinthe = labyrinthe[0].pop(labyrinthe[0].size)
labyrinthe.delete(labyrinthe[0])
a = labyrinthe[0].size
depart, arriver = [0], [labyrinthe.size - 1]
labyrinthe[0].map.with_index { |x, index| depart << index if x == infos_labyrinthe[7] }
labyrinthe[labyrinthe.size - 1].map.with_index { |x, index| arriver << index if x == infos_labyrinthe[8] }
v = Array.new(labyrinthe.size){Array.new(a, 0)}
position, choix, save, path = [depart[0], depart[1]], [], [], [depart]

# Resolution
until position == nil
    break if position == arriver
    deplacement_possible(labyrinthe, v, choix, position, save)
    if choix.size == 0
        position.push(save[0], save[1])
        i = path.index(save)
        path[i..-1].map { |x| path.delete(x) }
    elsif choix.size == 1
        path.push([choix[0], choix[1]])
        position.push(choix.shift(2))
    elsif choix.size > 1
        path.push([choix[0], choix[1]])
        position.push(choix[0], choix[1])
        choix.clear
    end
end

path.map { |loc| labyrinthe[loc[0]][loc[1]].gsub!(' ', 'o') }
labyrinthe.map { |line| puts line.join }
puts "=> SORTIE ATTEINTE EN #{path.size-1} COUPS !"