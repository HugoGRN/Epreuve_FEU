# Créez un programme qui remplace les caractères vides par des caractères plein pour représenter
# le plus grand carré possible sur un plateau. Le plateau sera transmis dans un fichier. 
# La première ligne du fichier contient les informations pour lire la carte : 
# nombre de lignes du plateau, caractères pour “vide”, “obstacle” et “plein”.


# My function
def file_to_array(file_name)
    cat = File.readlines(file_name).map { |line| line.chomp.split('') }
end

def find_obstacles(array)                                       # Récupere les coordonnées des obstacles dans loc
    loc = []
    array.map.with_index do |line, x|
        line.each_index do |y|
            loc << [x, y] if array[x][y].include?('x')
        end
        loc << [x, array[x].size] if !array[x].include?('x')
    end
    loc
end

def sort_obstacles(array)                                       # Trie le tableau loc ligne par ligne
    a = 0
    array.map.with_index do |tab, x|
        tab.each_index do |y|
            until a == array.size - 1
                if array[a][0] == array[a+1][0]
                    array[a].insert(-1, array[a+1])
                    array.delete_at(a+1)
                else array[a][0] != array[a+1][0]
                    a += 1
                end
            end
        end
    end
    array
end

def range_free(array, array2)                                                                                   # Creer des range ou il n'y a pas d'obstacles
    array.map { |ligne| ligne.insert(0, [ligne[0], ligne[1]]) ; ligne.delete_at(1) ; ligne.delete_at(1) }
    a = []
    array.map.with_index do |tab, x|
        tab.each_index do |y|
            if array[x].size < 2
                a << [x, 0...array[x][y][1]] if array[x][0][1] > 3
                a << [x, (array[x][y][1]+1)...array2[0].size] if array2[0].size - array[x][0][1] > 3
            elsif array[x].size > 2
                a << [x, 0...array[x][0][1]] if array[x][0][1] > 3
                a << [x, (array[x][array[x].size - 1][1]+1)...array2[0].size]
                a << [x, (array[x][y][1]+1)...array[x][y.next][1]] if array[x][y.next][1] - array[x][y][1] > 3
            elsif array[x].size == 2
                a << [x, 0...array[x][0][1]] if array[x][0][1] > 3
                a << [x, array[x][1][1]...array2[0].size] if array2[0].size - array[x][1][1] > 3
                a << [x, (array[x][y][1]+1)...array[x][1][1]] if array[x][1][1] - array[x][0][1] > 3
            end
            break if array[x].size - 2 == y
        end
    end
    a = a.uniq
end

def big_square(array, array2)                                   # Test si les range peuvent former un carré
    loc_square, square, a = [], [], 0
    array.map do |loc|
        if loc[1].size < 8
            loc_square = [[]]
            array2.each_index do |x|
                loc_square[0] << [x, loc[1]] if !array2[x][loc[1]].include?('x') ; break if array2[x][loc[1]].include?('x')
            end
            square << loc_square
        elsif loc[1].size > 8
            loc_square, a = [[]], 0
            loc[1].map do |n|
                array2.each_index { |x| loc_square[a] << [x, n..n+8] if !array2[x][n..n+8].include?('x') ; break if n+8 == loc[1].end || array2[x][n..n+8].include?('x') } 
                a += 1 and loc_square << []
            end
            square << loc_square
        end
    end
    square
end

def show_square(array, infos_array, array2)                     # Recup le plus grand carré et change les points par des o
    carre = []
    array.map { |line| line.delete_if { |tab| tab.size <= 1 } }
    array.map.with_index do |line, x|
        line.each_index { |y| carre << array[x][y] if array[x][y].size > 4 ; break if array[x][y].size == infos_array[0].to_i }
    end
    carre.uniq!.map.with_index { |line, x| carre = line if carre[x].size > carre[0].size }
    carre.map { |line| array2[line[0]][line[1]].map { |e| e.gsub!('.', 'o') } }
    return array2.map { |i| puts i.join(' ') }
end

# Gestion error
(puts "error 1 file expected"; exit) if ARGV.size != 1
(puts "error file doesn't exist"; exit) if !File.exists?(ARGV[0])

# Parsing
plateau = file_to_array(ARGV[0])
infos_plateau = plateau[0].pop(plateau[0].size)
plateau.delete(plateau[0])
obstacles_found = find_obstacles(plateau)
sort_obstacle = sort_obstacles(obstacles_found)
free_space = range_free(sort_obstacle, plateau)
los_square = big_square(free_space, plateau)
the_carre = show_square(los_square, infos_plateau, plateau)

# Resolution
the_carre