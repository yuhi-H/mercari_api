class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.following_id = current_user.id
    follow.save!
    serializer = RelationshipSerializer.new(follow)
    render json: serializer.as_json
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    render json: {'message': 'ユーザーフォロー解除したお！！！'}
  end
end
