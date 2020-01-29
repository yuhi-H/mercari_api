class EvaluationsController < ApplicationController
  def create
    eva = current_user.active_evaluation.new(eva_params)
    eva.evaluate_id = current_user.id
    eva.evaluated_id = params[:user_id]
    eva.save!
    serializer = EvaluationSerializer.new(eva)
    render json: serializer.as_json
  end

  def eva_params
    params.require(:eva_params).permit(
      :evaluate_status,
      :text
    )
  end
end
