class FilmesController < ApplicationController
  before_action :set_filme, only: [:show, :edit, :update ]
  before_action :conectar_soap

  # GET /filmes
  # GET /filmes.json
  def index
    if(filme_params.empty?)
      response = @soap.call(:buscar_filmes)
      @filmes =  response.body[:buscar_filmes_response][:return]
      logger.info "@filmes ============> #{@filmes}"
    else
      response = @soap.call(:buscar_filme, message:{
        titulo: filme_params[:busca_titulo],
        diretor: filme_params[:busca_diretor],
        estudio: filme_params[:busca_estudio],
        genero: filme_params[:busca_genero],
        ano: filme_params[:busca_ano]
      })
      @filmes =  response.body[:buscar_filme_response][:return]
    end
    if (@filmes.nil? == true)
      @filmes = []
    end
    if !@filmes.kind_of?(Array)
      a=[]
      a.push(@filmes)
      @filmes = a
    end
  end

  # GET /filmes/1
  # GET /filmes/1.json
  def show
  end

  # GET /filmes/new
  def new
    @filme = Filme.new(filme_params)
  end

  # GET /filmes/1/edit
  def edit
  end

  # POST /filmes
  # POST /filmes.json
  def create
    @filme = Filme.new(filme_params)
    response = @soap.call(:cadastrar, message:{
      filme: {
        id:filme_params[:id].to_i,
        titulo:filme_params[:titulo],
        diretor:filme_params[:diretor],
        estudio:filme_params[:estudio],
        genero:filme_params[:genero],
        ano:filme_params[:ano]
        }})
    logger.debug "params ===> #{ActiveSupport::JSON.encode(filme_params)}"
    logger.info "filme ====> #{@filme.to_json}"
    respond_to do |format|
      format.html { redirect_to filmes_path, notice: 'Filme was successfully created.' }
    end


    # respond_to do |format|
    #   if @filme.save
    #     format.html { redirect_to filmes_path, notice: 'Filme was successfully created.' }
    #     #format.json { render :show, status: :created, location: @filme }
    #   else
    #     format.html { render :new }
    #     #format.json { render json: @filme.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /filmes/1
  # PATCH/PUT /filmes/1.json
  def update
    respond_to do |format|
      if @filme.update(filme_params)
        format.html { redirect_to @filme, notice: 'Filme was successfully updated.' }
        format.json { render :show, status: :ok, location: @filme }
      else
        format.html { render :edit }
        format.json { render json: @filme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filmes/1
  # DELETE /filmes/1.json
  def destroy
    #@filme.destroy
    response = @soap.call(:excluir, message:{id:filme_params[:id].to_i})
    respond_to do |format|
      format.html { redirect_to filmes_path, notice: 'Filme was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filme
      @filme = Filme.new(filme_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filme_params
      params.permit(:id,:titulo, :diretor, :estudio, :genero, :ano,
      :utf8, :authenticity_token, :commit,
      :busca_titulo, :busca_diretor, :busca_estudio, :busca_genero, :busca_ano)
      params.delete :utf8
      params.delete :authenticity_token
      params.delete :commit
      params.delete :controller
      params.delete :action
      params
    end

    def conectar_soap
      @soap = Savon.client(wsdl: 'https://filmesoap.herokuapp.com/service?wsdl')
    end
end
