# La première ligne du labyrinthe contient les informations pour lire la carte :
# LIGNESxCOLS, caractère plein, vide, chemin, entrée et sortie du labyrinthe.


def labyrinthe_generator
    File.delete("labyrinthe")
    height, width, chars = ARGV[0].to_i, ARGV[1].to_i, ARGV[2]
    entry = rand(width - 4) + 2
    entry2 = rand(width - 4) + 2
    open('labyrinthe', 'a') { |f| f << "#{height}x#{width}#{ARGV[2]}\n" }
    height.times do |y|
        width.times do |x|
            if y == 0 && x == entry
            open('labyrinthe', 'a') { |f| f << chars[3].chr }
            elsif y == height - 1 && x == entry2
                open('labyrinthe', 'a') { |f| f << chars[4].chr }
            elsif y.between?(1, height - 2) && x.between?(1, width - 2) && rand(100) > 20
                open('labyrinthe', 'a') { |f| f << chars[1].chr }
            else
                open('labyrinthe', 'a') { |f| f << chars[0].chr }
            end
        end
        open('labyrinthe', 'a') { |f| f << "\n" }
    end
end

(puts "params needed : height width characters" ; exit) if ARGV.count < 3 || ARGV[2].length < 5

labyrinthe_generator