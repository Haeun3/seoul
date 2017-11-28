class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :title #제목
      t.text :content #설명
      t.text :img #이미지 주소
      t.text :addr #주소
      # t.string :homepage #홈페이지
      t.string :phone #전화번호
      t.text :parking #주차시설
      
      #place
      t.string :restdate #쉬는날
      # t.string :useseason #이용시기
      t.string :usetime #이용시간
      t.float :mapx 
      t.float :mapy
      
      #sleep
      t.string :checkintime #입실시간
      t.string :checkouttime #퇴실시간
      t.string :pickup #픽업 서비스
      t.string :reservation #예약안내
    
      #food
      t.string :firstmenu #대표메뉴
      t.string :packing #포장가능
      t.string :treatmenu #취급 메뉴

      t.string :category # 장소, 식당, 숙박, 축제

      t.timestamps null: false
    end
  end
end
