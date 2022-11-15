class PapersController < ApplicationController
  before_action :set_paper, only: %i[ show edit update destroy ]

  
  
  # GET /papers
  def index
    #if params['year']
    #  @papers = Paper.year(params['year'])
    #elsif params['search']
    #  @papers = Paper.where("title LIKE ?", "%" + Paper.sanitize_sql_like(params['search']) + "%").or(Paper.where("venue LIKE ?", "%" + Paper.sanitize_sql_like(params['search']) + "%"))
    #else
    if params[:search]
      # split search term by words into list.
      all_params = params[:search].split(" ")
      # for each word and attribute create like clause. Disjuncts attributes and conjucts search_terms.
      sql_like_clause = all_params.map{|param| relevant_search_attributes.map { |attribute| create_sql_like(param, attribute) }.join(" OR ") }.join(" AND ")
      @papers = Paper.where(sql_like_clause)
    else
      @papers = Paper.all
    end
  end

  # GET /papers/1
  def show
  end

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  def create
    @paper = Paper.new(paper_params)

    if @paper.save
      redirect_to @paper, notice: "Paper was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /papers/1
  def update
    if @paper.update(paper_params)
      redirect_to @paper, notice: "Paper was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /papers/1
  def destroy
    @paper.destroy
    redirect_to papers_url, notice: "Paper was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paper_params
      params.require(:paper).permit(:title, :venue, :year, :author_ids => [])
    end

    # returns LIKE partial matching search
    def create_sql_like(search_term, search_attribute)
      "#{search_attribute} LIKE '%#{search_term}%'"
    end

    # retuns equals expression for filter
    def create_sql_equal(search_value, search_attribute)
      "#{search_attribute} = '#{search_value}'"
    end

    def relevant_search_attributes
      [:title, :venue]
    end


end
