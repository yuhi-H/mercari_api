class Evaluation < ApplicationRecord
    belongs_to :evaluate, class_name: "User"
    belongs_to :evaluated, class_name: "User"
end
