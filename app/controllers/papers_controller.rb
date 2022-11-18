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
      categories_filter = {"year" => 2022}
      #categories_filter = {}
      numerical_filter = {"year" => {"lower_bound" => 2000, "upper_bound" => 2023}}
      @papers = search_for_items(params[:search], categories_filter, numerical_filter)
      # for each word and attribute create like clause. Disjuncts attributes and conjucts search_terms.
      #sql_like_clause = all_params.map{|param| relevant_search_attributes.map { |attribute| create_sql_like(param, attribute) }.join(" OR ") }.join(" AND ")
      #@papers = Paper.where(sql_like_clause)
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
    def create_sql_like(search_attribute, search_term)
      "#{search_attribute} LIKE '%#{Paper.sanitize_sql_like(search_term)}%'"
    end

    # retuns equals expression for filter
    def create_sql_equal(search_attribute, search_value)
      "#{search_attribute} = '#{search_value}'"
    end

    def create_sql_lower_upper(search_attribute, lower_bound, upper_bound)
      "#{search_attribute} BETWEEN #{lower_bound} AND #{upper_bound}"
    end

    def relevant_search_attributes
      [:title, :venue]
    end

    def generate_sql_where_clause(search_term, filter_category = {}, filter_numerical = {})
      # split search term by words into list.
      search_terms = search_term.split(" ")
      # for each word and attribute create like, equal and between clause. Disjuncts attributes and conjucts search_terms.
      sql_like_clause = search_terms.map{|term| relevant_search_attributes.map { |attribute| create_sql_like(attribute, term) }.join(" OR ") }.join(" AND ")
      sql_equal_clause = filter_category.map{|key, value| create_sql_equal(key, value)}.join(" AND ")
      sql_between_clause = filter_numerical.map{|key, bounds| create_sql_lower_upper(key, bounds["lower_bound"], bounds["upper_bound"])}.join(" AND ")
      "(#{sql_like_clause})" + "AND" + "(#{sql_equal_clause})" + "AND" + "(#{sql_between_clause})"
    end 

    # search_term: you are looking for relevant search attributes, partially matching search. 
    # Currently results include items where all words of the search term appear in at least one of the relevant search attributes.
    # filter_category: filter search results with a hash in the form {"filter_name_a" => "filter_value_a", "filter_name_b" => "filter_value_b"}.
    # filter_numerical: filter search by numerial range in the form {"search_name" => {"lower_bound" => 8, "upper_bound" => 10}, ...}
    def search_for_items(search_term, filter_category = {}, filter_numerical = {})
      sql_where_clause = generate_sql_where_clause(search_term, filter_category, filter_numerical)
      puts sql_where_clause
      Paper.where(sql_where_clause)
    end
end
