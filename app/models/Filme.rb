class Filme
    attr_accessor :titulo
    attr_accessor :diretor
    attr_accessor :estudio
    attr_accessor :genero
    attr_accessor :anoLancamento
    
    #Construtor
	def initialize(titulo, diretor, estudio, genero, anoLancamento)
		@titulo=titulo
        @diretor=diretor
        @estudio=estudio
        @genero=genero
        @anoLancamento=anoLancamento
	end
    
end