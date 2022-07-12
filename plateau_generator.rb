# Générateur de plateau
# La première ligne du plateau contient les informations pour lire la carte : 
# nombre de lignes du plateau, caractères pour “vide”, “obstacle” et “plein”.


def plateau_generator
    File.delete("plateau")
    (puts "params needed: x, y, density"; exit) if ARGV.count != 3
  
    x, y, density = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i
  
    open('plateau', 'a') {|f| f << "#{y}.xo\n"}
    for i in 1..y do
      for j in 1..x do
        open('plateau', 'a') {|f| f << ((rand(y) * 2 < density) ? 'x' : '.')}
      end
      open('plateau', 'a') {|f| f << "\n"}
    end
end

plateau_generator