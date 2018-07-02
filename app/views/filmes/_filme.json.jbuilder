json.extract! filme, :id, :titulo, :diretor, :estudio, :genero, :anoLancamento, :created_at, :updated_at
json.url filme_url(filme, format: :json)
