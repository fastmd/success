require 'rufus-scheduler'
include ContractsHelper

# Let's use the rufus-scheduler singleton
#
scheduler = Rufus::Scheduler.new
schedulerto = Rufus::Scheduler.new
schedulertest = Rufus::Scheduler.new

# Stupid recurrent task...
schedulertest.every '1h', 
:overlap => false, 
:timeout => '1m',
:first_at => Time.now + 60*1 do
  begin
      # ... do something
      mylog = Mylog.new
      mylog.name = 'test'             
      mylog.description = "Hello! It's time to work #{Time.now}."        
      mylog.save    
  rescue Rufus::Scheduler::TimeoutError
      # ... that something got interrupted after timeout
      mylog = Mylog.new
      mylog.name = 'test'             
      mylog.description = "TimeoutError #{Time.now}."        
      mylog.save
  end        
end

scheduler.every '12h', 
#:overlap => false, 
#:timeout => '3m', 
:first_at => Time.now + 60*10 do
  begin      
      #-------------mail-b-------------------------
      mailtextbody = '#{Time.now}'#mailcontractstext
      mailhtmlbody = mailcontractshtml
          
      mail = Mail.new do
        from     'jdanovalarisa7@gmail.com'
        #to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md'
        #to       'jdanova@moldelectrica.md;octavian.ciobirca@fast.md'
        to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md;sergelus@yandex.ru'
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
             mylog.description = "Mail Contracts delivered bounced=#{mail.bounced?} rec=#{mail.final_recipient} action=#{mail.action}."      
          end
        rescue => e
          mylog.description = "Mail Contracts delivering error because #{e.message} bounced=#{mail.bounced?} rec=#{mail.final_recipient} action=#{mail.action} erstatus=#{mail.error_status} dcode=#{mail.diagnostic_code}!"
          #flash[:warning] = "Mail  Contracts delivering error because #{e.message}!"             
      end
      mylog.save
      #Rails.logger.info "Contracts #{Time.now.strftime('%d.%m.%Y %R')}"
      #Rails.logger.flush   
      #-------------mail-e-------------------------
   rescue Rufus::Scheduler::TimeoutError
      # ... that something got interrupted after timeout
      mylog = Mylog.new
      mylog.name = 'email'             
      mylog.description = "TimeoutError #{Time.now} during Mail Contracts."        
      mylog.save        
   end  
 end
 
 schedulerto.every '1d', 
 :overlap => false, 
 :timeout => '3m', 
 :first_at => Time.now + 60*20 do
  begin   
    #-------------mail-b-------------------------
      mailtextbody = '' #mailtoshtml
      mailhtmlbody = mailtoshtml #'<h1>'+"Брони и контракты AUTO10 на #{Time.now.strftime('%d.%m.%Y %R')}"+'</h1>'
         
      mailto = Mail.new do
        from     'jdanovalarisa7@gmail.com'
        #to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md'
        #to       'jdanova@moldelectrica.md;octavian.ciobirca@fast.md'
        to       'jdanova@moldelectrica.md;successavto@gmail.com;octavian.ciobirca@fast.md;sergelus@yandex.ru'
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
           mylog.description = "Mail TOs delivered bounced=#{mailto.bounced?} rec=#{mailto.final_recipient} action=#{mailto.action}."        
          end
        rescue => e
          mylog.description = "Mail TOs delivering error because #{e.message} bounced=#{mailto.bounced?} rec=#{mailto.final_recipient} action=#{mailto.action} erstatus=#{mailto.error_status} dcode=#{mailto.diagnostic_code}!"
          #flash[:warning] = "Mail TOs delivering error because #{e.message}!"             
      end
      mylog.save
      #Rails.logger.info mailhtmlbody
      #Rails.logger.flush
    #-------------mail-e-------------------------      
    #Rails.logger.info "#{Time.now.strftime('%d.%m.%Y %R')}"
    #Rails.logger.flush
    rescue Rufus::Scheduler::TimeoutError
      # ... that something got interrupted after timeout
      mylog = Mylog.new
      mylog.name = 'email'             
      mylog.description = "TimeoutError #{Time.now} during Mail TOs."        
      mylog.save         
   end    
end

