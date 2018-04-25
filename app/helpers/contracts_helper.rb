module ContractsHelper
  
  def mailcontractstext
    
   #---broni-today---------        
   @broni_today = Contract.where("(car_id is not null AND (stdate < ?) AND flag = 1)", Date.tomorrow.in_time_zone).order(:stdate)
   broni_today_mes = "\nБрони на сегодня #{Date.current.strftime('%d.%m.%Y')}\n"
   if !@broni_today.nil? and @broni_today.count > 0 then 
     @broni_today.each do |item|
       broni_today_mes += "#{item.id} c #{item.stdate.strftime('%d.%m.%Y %R')} по #{item.enddate.strftime('%d.%m.%Y %R')} #{item.car.marca} #{item.car.gnum} #{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}\n"
     end
   else 
     broni_today_mes += "Нет броней на сегодня. \n" 
   end
   #---broni-tomorrow---------
   @broni_tomorrow = Contract.where("(car_id is not null AND (stdate >= ? AND stdate < ?) AND flag = 1)", (Date.tomorrow.in_time_zone), (Date.tomorrow.in_time_zone+1.day)).order(:stdate)
   broni_tomorrow_mes = "\nБрони на завтра #{Date.tomorrow.strftime('%d.%m.%Y')}\n"
   if !@broni_tomorrow.nil? and @broni_tomorrow.count > 0 then 
     @broni_tomorrow.each do |item|
       broni_tomorrow_mes += "#{item.id} c #{item.stdate.strftime('%d.%m.%Y %R')} по #{item.enddate.strftime('%d.%m.%Y %R')} #{item.car.marca} #{item.car.gnum} #{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}\n"
     end
   else 
     broni_tomorrow_mes += "Нет броней на завтра. \n" 
   end 
   #----contract-today---------
   @contracts_close_today = Contract.where("(car_id is not null AND (enddate < ?) AND flag = 2)", Date.tomorrow.in_time_zone).order(:enddate)
   contracts_close_today_mes = "\nКонтракты к закрытию на сегодня #{Date.current.strftime('%d.%m.%Y')}\n"
   if !@contracts_close_today.nil? and @contracts_close_today.count > 0 then 
     @contracts_close_today.each do |item|
       contracts_close_today_mes += "#{item.id} по #{item.enddate.strftime('%d.%m.%Y %R')} c #{item.stdate.strftime('%d.%m.%Y %R')} #{item.car.marca} #{item.car.gnum} #{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}\n"
     end
   else 
     contracts_close_today_mes += "Нет контрактов к закрытию. \n"
   end 
   #---------------------------
=begin
=end 
   ("Брони и контракты AUTO10 на #{Time.now.strftime('%d.%m.%Y %R')} \n" + "#{broni_today_mes}" + "#{broni_tomorrow_mes}" + "#{contracts_close_today_mes}" + "\nThat's all this time. Have a nice day! Sincerely Yours, AUTO10.")
  end
  
  def mailcontractshtml
   tstyle = 'style="border: 1px solid black;border-collapse: collapse;padding: 5px;"'  
   #---broni-today---------        
   @broni_today = Contract.where("(car_id is not null AND (stdate < ?) AND flag = 1)", Date.tomorrow.in_time_zone).order(:stdate)
   broni_today_mes = '<h4>' + "\nБрони на сегодня #{Date.current.strftime('%d.%m.%Y')}\n" + '<h4>'
   if !@broni_today.nil? and @broni_today.count > 0 then
     broni_today_mes += "<table #{tstyle}><tr><th #{tstyle}>№</th><th #{tstyle}>c</th><th #{tstyle}>по</th><th #{tstyle}>машина</th><th #{tstyle}>клиент</th></tr>"
     @broni_today.each do |item|
       broni_today_mes += '<tr>'+"<td #{tstyle}>"+"#{item.id}</td>"+"<td #{tstyle}>"+"#{item.stdate.strftime('%d.%m.%Y %R')}</td>"+
                           "<td #{tstyle}>#{item.enddate.strftime('%d.%m.%Y %R')}</td><td #{tstyle}>#{item.car.marca} #{item.car.gnum}</td>"+
                           "<td #{tstyle}>#{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}</td>"+"</tr>"
     end
     broni_today_mes += '</table>' 
   else 
     broni_today_mes += "Нет броней на сегодня. \n" 
   end
   #---broni-tomorrow---------
   @broni_tomorrow = Contract.where("(car_id is not null AND (stdate >= ? AND stdate < ?) AND flag = 1)", (Date.tomorrow.in_time_zone), (Date.tomorrow.in_time_zone+1.day)).order(:stdate)
   broni_tomorrow_mes = '<h4>' + "\nБрони на завтра #{Date.tomorrow.strftime('%d.%m.%Y')}\n" + '<h4>'
   if !@broni_tomorrow.nil? and @broni_tomorrow.count > 0 then
     broni_tomorrow_mes += "<table #{tstyle}><tr><th #{tstyle}>№</th><th #{tstyle}>c</th><th #{tstyle}>по</th><th #{tstyle}>машина</th><th #{tstyle}>клиент</th></tr>" 
     @broni_tomorrow.each do |item|
       broni_tomorrow_mes += '<tr>'+"<td #{tstyle}>"+"#{item.id}</td>"+"<td #{tstyle}>"+"#{item.stdate.strftime('%d.%m.%Y %R')}</td>"+
                             "<td #{tstyle}>#{item.enddate.strftime('%d.%m.%Y %R')}</td><td #{tstyle}>#{item.car.marca} #{item.car.gnum}</td>"+
                             "<td #{tstyle}>#{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}</td>"+"</tr>"
     end
     broni_tomorrow_mes += '</table>'
   else 
     broni_tomorrow_mes += "Нет броней на завтра. \n" 
   end 
   #----contract-today---------
   @contracts_close_today = Contract.where("(car_id is not null AND (enddate < ?) AND flag = 2)", Date.tomorrow.in_time_zone).order(:enddate)
   contracts_close_today_mes = '<h4>' + "\nКонтракты к закрытию на сегодня #{Date.current.strftime('%d.%m.%Y')}\n" + '<h4>'
   if !@contracts_close_today.nil? and @contracts_close_today.count > 0 then
     contracts_close_today_mes += "<table #{tstyle}><tr><th #{tstyle}>№</th><th #{tstyle}>по</th><th #{tstyle}>c</th><th #{tstyle}>машина</th><th #{tstyle}>клиент</th></tr>"  
     @contracts_close_today.each do |item|
       contracts_close_today_mes += '<tr>'+"<td #{tstyle}>"+"#{item.id}</td>"+"<td #{tstyle}>"+"#{item.enddate.strftime('%d.%m.%Y %R')}</td>"+
                                           "<td #{tstyle}>#{item.stdate.strftime('%d.%m.%Y %R')}</td><td #{tstyle}>#{item.car.marca} #{item.car.gnum}</td>"+
                                           "<td #{tstyle}>#{item.client.sname} #{item.client.name} #{item.client.fname} #{item.client.tel} #{item.client.pemail}</td>"+"</tr>"
     end
     contracts_close_today_mes += '</table>'
   else 
     contracts_close_today_mes += "Нет контрактов к закрытию. \n"
   end 
   #---------------------------
=begin
=end 
   ('<h3>'+"Брони и контракты AUTO10 на #{Time.now.strftime('%d.%m.%Y %R')}"+'</h3>' + "#{broni_today_mes}" + "#{broni_tomorrow_mes}" + "#{contracts_close_today_mes}" + 
                 '<p>That\'s all this time. Have a nice day! Sincerely Yours, AUTO10.</p>')
  end  
  
  def mailtoshtml
    to_mes = ''
    curmonthb = Date.today.at_beginning_of_month
    curmonthe = Date.today.at_beginning_of_month.next_month
    curyearb =  Date.today.at_beginning_of_year
    curyeare =  Date.today.at_beginning_of_year.next_year    
    @report = Array[]
    i = 1
    @cars = Car.all.order(:marca,:gnum)    
    if @cars.count != 0 then
       @cars.each do |caritem|         
         #---parcurs----------
         lastparcurs = Wlong.where("car_id = ? and wdate is not null", caritem.id).order(:wdate).last
         #----to--------------
         maxtosdate = Tehservice.where("car_id = ? and sdate is not null and stype=3", caritem.id).maximum(:sdate)
         dtto = nil
         if maxtosdate then
          toparcurs = Wlong.where("car_id = ? and wdate is not null and wdate <= ?", caritem.id, maxtosdate).order(:wdate).last
          if toparcurs and lastparcurs then
            dtto = (lastparcurs.parcurs.to_i - toparcurs.parcurs.to_i)
            if dtto < 0 then 
              if    toparcurs.parcurs.to_i < 10000    then dtto += 10000
              elsif toparcurs.parcurs.to_i < 100000   then dtto += 100000
              elsif toparcurs.parcurs.to_i < 1000000  then dtto += 1000000
              elsif toparcurs.parcurs.to_i < 10000000 then dtto += 10000000
              else dtto += 100000000 end   
            end             
          end
         end          
         if (dtto.nil? or (!dtto.nil? and dtto > 8000))  then
           tored = 1
           to_mes += "<p>#{caritem.marca} #{caritem.gnum} - необходимо ТехОбслуживание - " + (if dtto.nil? then "не меняли еще ни разу" else "пробег уже #{dtto}" end) + "</p>"
         end 
         #---oil------------------
         maxoilsdate = Tehservice.where("car_id = ? and sdate is not null and stype=1", caritem.id).maximum(:sdate)
         if maxoilsdate then
          oilparcurs = Wlong.where("car_id = ? and wdate is not null and wdate <= ?", caritem.id, maxoilsdate).order(:wdate).last
          if oilparcurs and lastparcurs then
            dtoil = (lastparcurs.parcurs.to_i - oilparcurs.parcurs.to_i)
            if dtoil < 0 then 
              if    oilparcurs.parcurs.to_i < 10000    then dtoil += 10000
              elsif oilparcurs.parcurs.to_i < 100000   then dtoil += 100000
              elsif oilparcurs.parcurs.to_i < 1000000  then dtoil += 1000000
              elsif oilparcurs.parcurs.to_i < 10000000 then dtoil += 10000000
              else dtoil += 100000000 end   
            end            
          end          
         end
         if (dtoil and dtoil > 8000) or dtoil.nil? then
           oilred = 1
           to_mes += "<p>#{caritem.marca} #{caritem.gnum} - необходима Замена Масла - " + (if dtoil.nil? then 'не меняли еще ни разу' else "пробег уже #{dtoil}" end)  + "</p>"
         end
         #----asigurare-------------         
         maxasigsdate = Tehservice.where("car_id = ? and sdate is not null and stype=2", caritem.id).maximum(:sdate)
         if maxasigsdate then
           asigdt = (Date.today.to_date - maxasigsdate.to_date).to_i   #number of days between report dates
         end
         if !(maxasigsdate) or (asigdt>360) then
           asigred = 1
           to_mes += "<p>#{caritem.marca} #{caritem.gnum} - необходима Страховка - " + (if asigdt.nil? then 'не страховали еще ни разу' else "прошло уже #{asigdt} дней" end) + "</p>"
         end
         #---testare-tehnica------------
         maxtosmsdate = Tehservice.where("car_id = ? and sdate is not null and stype=4", caritem.id).maximum(:sdate)
         if maxtosmsdate then
           tosmdt = (Date.today.to_date - maxtosmsdate.to_date).to_i   #number of days between report dates
         end
         if !(maxtosmsdate) or (tosmdt>360) then
           tosmred = 1
           to_mes += "<p>#{caritem.marca} #{caritem.gnum} - необходим Технический Осмотр - " + (if tosmdt.nil? then 'не делали техосмотр еще ни разу' else "прошло уже #{tosmdt} дней" end) + "</p>"
         end
         monthsprice = Tehservice.where("car_id = ? and sdate >= ? and sdate < ?", caritem.id, curmonthb, curmonthe).sum("sprice")
         yearsprice = Tehservice.where("car_id = ? and sdate >= ? and sdate < ?", caritem.id, curyearb, curyeare).sum("sprice")
         report_rind = {:i => i, :car_id => caritem.id, :marca_gnum => "#{caritem.marca} #{caritem.gnum}", 
                        :to => {:maxtosdate => if maxtosdate then maxtosdate.strftime('%d.%m.%Y') else nil end, :parcurs => if toparcurs then toparcurs.parcurs else nil end, :tored => tored}, 
                        :oil => {:maxoilsdate => if maxoilsdate then maxoilsdate.strftime('%d.%m.%Y') else nil end, :parcurs => if oilparcurs then oilparcurs.parcurs else nil end, :oilred => oilred},
                        :asig => {:maxasigsdate => if maxasigsdate then maxasigsdate.strftime('%d.%m.%Y') else nil end, :asigdt => if asigdt then "#{asigdt} дней" else nil end, :asigred => asigred }, 
                        :tosm => {:maxtosmsdate => if maxtosmsdate then maxtosmsdate.strftime('%d.%m.%Y') else nil end, :tosmdt => if tosmdt then "#{tosmdt} дней" else nil end, :tosmred => tosmred},  
                        :monthsprice => monthsprice, :yearsprice => yearsprice, 
                        :parcurs =>{:parcurs => if lastparcurs then "#{lastparcurs.parcurs}" else nil end, :wdate => if lastparcurs then "#{lastparcurs.wdate.strftime('%d.%m.%Y')}" else nil end }
                       }                                                   
         i += 1
         @report << report_rind 
       end # cars.each
     end # if cars.count    
    ('<h3>'+"TO AUTO10 на #{Time.now.strftime('%d.%m.%Y %R')}" + '</h3>' + "#{to_mes}" + '<p>That\'s all this time. Have a nice day! Sincerely Yours, AUTO10.</p>')
  end
  
end
