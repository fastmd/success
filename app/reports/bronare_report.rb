# encoding: utf-8
class BronareReport < Prawn::Document
  
  
  def makebox(x,y,contract,car,client,al,stmp)
    boxwidth = 270
    boxheight = 360
    bounding_box([boxwidth*x+x*3, boxheight*(y+1)+y*3], :width => boxwidth-3, :height => boxheight-3) do
     transparent(0.5) { stroke_bounds }
     indent(2) do 
       text "<u><link href='http://www.success.md'>success.md</link></u>", :size => 10, :style => :normal, :align => :left,:inline_format => true
       text Time.now.strftime("Документ сгенерирован %e %b %Y в %H:%M"), :align => :right, :style => :italic, :size => 8
       move_down 5
       text "Act de rezervare cu Success&DivesGroup SRL", :size => 11, :style => :bold, :align => :center
       text "№ #{contract.id}#{if contract.cnum!='' then '/' else '' end}#{contract.cnum} din #{contract.stdate.strftime("%d.%m.%Y")}", :align => :center
       move_down 10
       text "Autovehicul <b>#{car.marca} #{car.gnum}</b>", :align => :left, :inline_format => true
       move_down 10
       text "Locator", :align => :center, :style => :bold
       text "Nume       SERGIU               tel.  078777058", :align => :left   
       text "Nume       VLADISLAV         tel.  069777037", :align => :left
       move_down 5
       text "Locatar", :align => :center, :style => :bold
       text " Familia  <b>#{client.sname}</b>", :align => :left, :inline_format => true
       text " Nume <b>#{client.name}</b>", :align => :left,:inline_format => true
       text " tel. #{client.tel}", :align => :left
       move_down 5
       text " Data de la #{contract.stdate.strftime("%d.%m.%Y %R")} pina la #{contract.enddate.strftime("%d.%m.%Y %R")}", :align => :left
       text " Suma #{contract.garant_summ}", :align => :left
       text " Loc: #{case contract.place  when 0 then 'Aeroport' when 1 then 'Oficiu' else '' end}", :align => :left
       move_down 10
       text "Locator", :align => :left, :style => :bold
       move_down 10
       text "Semnatura __________________", :align => :left
     end
     move_down 10
     indent(2+al) do         
         text "Locatar", :align => :left, :style => :bold
         move_down 10
         text "Semnatura __________________", :align => :left
         move_down 10 
     end
     indent(2+stmp) do    
         text "L.Ș.", :align => :left
     end     
    end
  end
    
  def to_pdf(contract,car,client)
    # привязываем шрифты
    if RUBY_PLATFORM == "i386-mingw32" then
      font_families.update(
        "OpenSans" => {
                        :bold => "./app/assets/fonts/OpenSans-Bold.ttf",
                        :italic => "./app/assets/fonts/OpenSans-Italic.ttf",
                        :normal  => "./app/assets/fonts/OpenSans-Light.ttf" })
      font "OpenSans", :size => 12
    else
      font_families.update( 
        "OpenSans" => {
                        :bold => "/home/sergelus/auto/app/assets/fonts/OpenSans-Bold.ttf",
                        :italic => "/home/sergelus/auto/app/assets/fonts/OpenSans-Italic.ttf",
                        :normal  => "/home/sergelus/auto/app/assets/fonts/OpenSans-Light.ttf" })
      font "OpenSans", :size => 12  
    end
   
   # makebox(0,0,contract,car,client,0,230)  
   # makebox(1,0,contract,car,client,100,10)
    makebox(0,1,contract,car,client,0,230)
    makebox(1,1,contract,car,client,100,10)
         
    render
  end
  
end