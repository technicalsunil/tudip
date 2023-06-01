class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :update, :destroy]

  # GET /candidates
  def index
    @candidates = Candidate.paginate(:page => 1, :per_page => 10)
    render json: {candidates: @candidates,
             total_pages: @candidates.total_pages,
             total_entries: @candidates.total_entries }
  end

  # GET /candidates/1
  def show
    render json: @candidate
  end

  # POST /candidates
  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      render json: @candidate, status: :created, location: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /candidates/1
  def update
    if @candidate.update(candidate_params)
      render json: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /candidates/1
  def destroy
    @candidate.destroy
  end

  def search
    key = "%#{params[:key]}%"
    @candidates = Candidate.where("name LIKE ? or phone LIKE ? or email LIKE ? or address LIKE ?", key, key, key, key).paginate(:page => 1, :per_page => 10)
    render json: {candidates: @candidates,
             total_pages: @candidates.total_pages,
             total_entries: @candidates.total_entries }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def candidate_params
      params.require(:candidate).permit(:name, :phone, :email, :address)
    end
end
