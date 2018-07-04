class Filme
    attr_accessor :id
    attr_accessor :titulo
    attr_accessor :diretor
    attr_accessor :estudio
    attr_accessor :genero
    attr_accessor :ano
    
    #Construtor
    def initialize(filme)
        @id=filme[:id]
		@titulo=filme[:titulo]
        @diretor=filme[:diretor]
        @estudio=filme[:estudio]
        @genero=filme[:genero]
        @ano=filme[:ano]
    end
    
end