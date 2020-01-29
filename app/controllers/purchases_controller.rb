class PurchasesController < ApplicationController
    before_action :authorize!
    before_action :set_item, only:[:create]
    before_action :status_check

    def create# 購入
        ActiveRecord::Base.transaction do# メソッド内に二つのDBをsaveする記述があるからトランザクション処理を書く
        purchase = Purchase.new
        purchase.user_id = current_user.id
        purchase.item_id = params[:id]
        purchase.owner_id = @item.user_id
        purchase.status = @item.status
        @item.status = true
        @item.save!
        purchase.message = '無事商品を購入できました！！'
        purchase.save!
        serializer = PurchaseSerializer.new(purchase)
        render json: serializer.as_json
        end
    end

    def status_check
        if @item.status == true
            raise ActionController::BadRequest.new("多重購入できません！")
        end
    end

    def set_item
        @item = Item.find_by(id: params[:id])
    end
end
