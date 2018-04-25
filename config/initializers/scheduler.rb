require 'rufus-scheduler'
include ContractsHelper

# Let's use the rufus-scheduler singleton
#
scheduler = Rufus::Scheduler.singleton
schedulerto = Rufus::Scheduler.singleton

# Stupid recurrent task...

scheduler.every '12h', :first_at => Time.now + 60*1 do
   # if (Time.now.strftime("%H")=='00' or Time.now.strftime("%H")=='12') then      
    #-------------mail-b-------------------------
      mailtextbody = '#{Time.now}'#mailcontractstext
      mailhtmlbody = mailcontractshtml
          
      mail = Mail.new do
        from     'jdanovalarisa7@gmail.com'
        #to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md'
        #to       'jdanova@moldelectrica.md;octavian.ciobirca@fast.md'
        to       'jdanova@moldelectrica.md'
        subject  "contracts AUTO10 #{Time.now.strftime('%d.%m.%Y %R')}"
      end
      
      text_part = Mail::Part.new do
        body mailtextbody
      end
      
      html_part = Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body mailhtmlbody
      end
      
    #  mail.text_part = text_part
      mail.html_part = html_part    
      
      mylog = Mylog.new
      mylog.name = 'email'    
      begin
          if mail.deliver! then 
             #flash[:notice] = "Mail Contracts delivered."
             mylog.description = "Mail Contracts delivered"      
          end
        rescue => e
          mylog.description = "Mail Contracts delivering error because #{e.message}!"
          #flash[:warning] = "Mail  Contracts delivering error because #{e.message}!"             
      end
      mylog.save
      #Rails.logger.info "Contracts #{Time.now.strftime('%d.%m.%Y %R')}"
      #Rails.logger.flush   
    #-------------mail-e-------------------------
 end
 
 schedulerto.every '1d', :first_at => Time.now + 60*2 do
    #if (Time.now.strftime("%H")=='07')
    #-------------mail-b-------------------------
      mailtextbody = '' #mailtoshtml
      mailhtmlbody = mailtoshtml #'<h1>'+"Брони и контракты AUTO10 на #{Time.now.strftime('%d.%m.%Y %R')}"+'</h1>'
         
      mailto = Mail.new do
        from     'jdanovalarisa7@gmail.com'
        #to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md'
        #to       'jdanova@moldelectrica.md;octavian.ciobirca@fast.md'
        to       'jdanova@moldelectrica.md'
        subject  "TO AUTO10 #{Time.now.strftime('%d.%m.%Y %R')}"
      end
      
      text_part = Mail::Part.new do
        body mailtextbody
      end
      
      html_part = Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body mailhtmlbody
      end
      
      #mailto.text_part = text_part
      mailto.html_part = html_part    

      mylog = Mylog.new
      mylog.name = 'email'             
      begin
          if mailto.deliver! then 
           #flash[:notice] = "Mail TOs delivered."
           mylog.description = "Mail TOs delivered."        
          end
        rescue => e
          mylog.description = "Mail TOs delivering error because #{e.message}!"
          #flash[:warning] = "Mail TOs delivering error because #{e.message}!"             
      end
      mylog.save
      #Rails.logger.info mailhtmlbody
      #Rails.logger.flush
    #-------------mail-e-------------------------      
    #Rails.logger.info "#{Time.now.strftime('%d.%m.%Y %R')}"
    #Rails.logger.flush  
end
