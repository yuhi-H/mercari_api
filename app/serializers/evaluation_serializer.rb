class EvaluationSerializer < ActiveModel::Serializer
  attributes :id,
              :evaluated_id,
              :evaluate_id,
              :evaluate_status,
              :text
end
