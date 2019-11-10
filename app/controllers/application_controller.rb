class ApplicationController < ActionController::Base
 
# 確認用 
  def test
    render html: "テスト"
  end
  
end
