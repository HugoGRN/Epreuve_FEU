# Créez un programme qui trouve et affiche la solution d’un Sudoku.


# My function
def file_to_array(file_name)
    cat = File.readlines(file_name).map { |line| line.chomp.split('') }
end

def complete_sudoku(file)
    remplacement, i = [], 0
    until i == 8
        liste = ("1".."9").map { |nb| nb }
        file.map.with_index do |ligne, x|
            ligne.map.with_index do |colonne, i|
                if file[x].count('.') == 1
                    if !file[x].include?(liste[i])
                        remplacement << file[x].join('').sub!('.', liste[i])
                        file[x].replace(remplacement[0].split(''))
                        remplacement.clear
                    end
                elsif file[x].count('.') > 1
                    y, a = file[x].index('.'), 0
                    until remplacement.size == 9
                        remplacement << file[a][y]
                        a += 1
                    end
                    if !remplacement.include?(liste[i])
                        file[x][y].sub!('.', liste[i])
                        remplacement.clear
                    end
                end
            end
        end
        i += 1
    end
    file.map { |line| line.join('') }
end

# Gestion error
(puts "error 1 file expected"; exit) if ARGV.size != 1
(puts "error file doesn't exist"; exit) if !File.exists?(ARGV[0])

# Parsing
sudoku = file_to_array(ARGV[0])
resolve = complete_sudoku(sudoku)

# Resolution
puts resolve