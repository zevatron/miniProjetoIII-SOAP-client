class Filme
    attr_accessor :titulo
    attr_accessor :diretor
    attr_accessor :estudio
    attr_accessor :genero
    attr_accessor :anoLancamento
    
    #Construtor
	def initialize(filme)
		@titulo=filme[:titulo]
        @diretor=filme[:diretor]
        @estudio=filme[:estudio]
        @genero=filme[:genero]
        @anoLancamento=filme[:anoLancamento]
    end
    
end