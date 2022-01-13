class Public::HomesController < ApplicationController
    
    def top
      @new_posts = Post.order(create_at: :desc).limit(8)
    end
    
end
