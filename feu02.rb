# Créez un programme qui affiche la position de l’élément le plus en haut à droite (dans l’ordre) d’une forme au sein d’un plateau.


# Functions
def file_to_array(file_name)
    cat = File.readlines(file_name).map { |line| line.chomp.split('') }
end

def location(file1, file2, plan)
    file1.map.with_index do |ligne, x|
        ligne.map.with_index do |colonne, i|
            if file1[x][i] == file2[0][0] and file1[x][i+1] == file2[0][1] and file1[x+1][i+1] == file2[1][1]
                plan[x][i].gsub!('-', colonne) and plan[x][i+1].gsub!('-', colonne) and plan[x+1][i+1].gsub!('-', colonne)
                return "Trouvé !\nCoordonnées : #{x}, #{i+1}\n #{plan[0].join}\n #{plan[1].join}\n #{plan[2].join}\n"
            end
        end
    end
    puts 'Introuvable' ; exit
end

def plan(file)
    a, b = [], []
    file.size.times { a << ["-" * file[0].size] }
    for i in 0..2
        b << a[i][0].split('')
    end
    b
end

# Gestion error
(puts "error 3 files expected"; exit) if ARGV.size != 2
(puts "error file doesn't exist"; exit) if !File.exists?(ARGV[0])  or !File.exists?(ARGV[1])

# Parsing
plateau = file_to_array(ARGV[0])
forme = file_to_array(ARGV[1])
plan = plan(plateau)

# Resolution
trouver_une_forme = location(plateau, forme, plan)

# Affichage
puts trouver_une_forme