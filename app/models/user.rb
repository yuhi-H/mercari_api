class User < ApplicationRecord
    has_secure_password
    has_secure_token

    has_many :items
    has_many :purchases
    has_many :favorites
    has_many :fav_items, through: :favorites, source: :item

    # ====================自分がフォローしているユーザーとの関連 ===================================
    #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
    has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
    # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
    has_many :followings, through: :active_relationships, source: :follower
    # ========================================================================================

    # ====================自分がフォローされるユーザーとの関連 ===================================
    #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
    has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
    # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
    has_many :followers, through: :passive_relationships, source: :following
    # =======================================================================================

    def followed_by?(user)
        # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
        passive_relationships.find_by(following_id: user.id).present?
    end


    # ====================自分が評価しているユーザーとの関連 ===================================
    #評価する側のUserから見て、評価される側のUserを(中間テーブルを介して)集める。なので親はevaluate_id(評価する側)
    has_many :active_evaluation, class_name: "Evaluation", foreign_key: :evaluate_id
    # 中間テーブルを介して「evaluated」モデルのUser(評価された側)を集めることを「evaluate」と定義
    has_many :evaluate, through: :active_evaluation, source: :evaluated
    # ========================================================================================

    # ====================自分が評価されるユーザーとの関連 ===================================
    #評価される側のUserから見て、評価してくる側のUserを(中間テーブルを介して)集める。なので親はevaluated_id(評価される側)
    has_many :passive_evaluation, class_name: "Evaluation", foreign_key: :evaluated_id
    # 中間テーブルを介して「evaluate」モデルのUser(評価する側)を集めることを「evaluated」と定義
    has_many :evaluated, through: :passive_evaluation, source: :evaluate
    # =======================================================================================
end
