# encoding: utf-8
class ContractReport < Prawn::Document
    
  def to_pdf(contract,car,client)
    # привязываем шрифты
    if RUBY_PLATFORM == "i386-mingw32" then
      font_families.update(
        "OpenSans" => {
                        :bold => "./app/assets/fonts/OpenSans-Bold.ttf",
                        :italic => "./app/assets/fonts/OpenSans-Italic.ttf",
                        :normal  => "./app/assets/fonts/OpenSans-Light.ttf" })
      font "OpenSans", :size => 9
    else
      font_families.update( 
        "OpenSans" => {
                        :bold => "/home/sergelus/auto/app/assets/fonts/OpenSans-Bold.ttf",
                        :italic => "/home/sergelus/auto/app/assets/fonts/OpenSans-Italic.ttf",
                        :normal  => "/home/sergelus/auto/app/assets/fonts/OpenSans-Light.ttf" })
      font "OpenSans", :size => 9  
    end
 
    text "<u><link href='http://www.success.md'>success.md</link></u>", :size => 9, :style => :normal, :align => :left,:inline_format => true
    text Time.now.strftime("Документ сгенерирован %e %b %Y в %H:%M"), :align => :right, :style => :italic, :size => 8
    text "SERGIU    078777058", :size => 9, :style => :bold, :align => :right
    text "078777059", :size => 9, :style => :bold, :align => :right
    text "<font size='10'>CONTRACT DE LOCAȚIUNE nr.</font> <font size='12'>#{contract.id}/#{contract.cnum}</font> din #{contract.order_date.strftime("%d.%m.%Y")}", :style => :bold, :align => :center, :inline_format => true
    text "I. Părțile contractante:", :align => :center, :style => :bold
    text "<b>SRL  Success & DivesGroup</b>  în  persoana  directorului  Sârbu  Sergiu  în  calitate  de  locator,  pe  de  o  parte,"+
         "  și  cet. <b>#{client.sname} #{client.name} #{client.fname}</b> în calitate de locatar, pe de altă parte, au convenit să încheie prezentul contract de Locațiune, cu respectarea următoarelor clauze: ",:inline_format => true,:align => :justify
    text "II. Obiectul contractului", :align => :center, :style => :bold
    text "Locatorul se obligă să transmită Locatarului în folosință temporară, cu titlu oneros, următorul automobil:" 
    move_down 1
    y_position = cursor
    bounding_box([0, y_position], :width => 260) do
      text "Modelul, marca", :align => :left
      text "Numărul de înmatriculare", :align => :left
      text "Numărul caroseriei", :align => :left     
      text "Numărul motorului", :align => :left 
      text "Anul producerii", :align => :left 
      text "Culoarea", :align => :left 
      text "Capacitatea cilindrică, cm3", :align => :left
      text "Masa totală, kg", :align => :left 
      text "Valoare automobil", :align => :left
    end  #bounding box
    bounding_box([260, y_position], :width => 260) do
      text "#{car.marca}", :align => :left, :style => :bold
      text "#{car.gnum}", :align => :left, :style => :bold
      text "#{car.cuznum}", :align => :left, :style => :bold
      text "#{car.motnum}", :align => :left, :style => :bold
      text "#{car.proddate}", :align => :left, :style => :bold
      text "#{car.color}", :align => :left, :style => :bold
      text "#{car.vmot}", :align => :left, :style => :bold
      text "#{car.tmasa}", :align => :left, :style => :bold
      text "#{car.tsumm} EURO", :align => :left, :style => :bold
    end    #bounding box
    daysinperiod = (contract.enddate - contract.stdate).to_i   #number of days between report dates
    if daysinperiod < 1 then daysinperiod = 1 end
    pretperday = ( contract.summ.to_i / daysinperiod).round(2)   #number of days between report dates  
    text "III. Termenul locațiunii", :align => :center, :style => :bold
    text "3.1.Termenul locațiunii este de <b>#{daysinperiod}</b> zile, începând cu data de <b>#{contract.stdate.strftime("%d.%m.%Y")}</b>, ora <b>#{contract.sttime.strftime('%R')}</b>," + 
          "până pe data de <b>#{contract.enddate.strftime("%d.%m.%Y")}</b>, ora <b>#{contract.endtime.strftime('%R')}</b>.",:inline_format => true,:align => :justify
    text "3.2. Termenul Locațiunii poate fi prelungit doar cu acordul scris al ambelor părți.",:align => :justify       
    text "IV. Drepturile și obligațiunile părților", :align => :center, :style => :bold
    text "4.1. Locatorul este obligat să pună la dispoziția Locatarului autovehiculul în termenii stabiliți și într-o stare corespunzătoare folosirii sale conform destinației.",:align => :justify
    text "4.2. Locatarul este obligat:" 
    text "a) să achite chiria în termenul stabilit;" 
    text "b) să folosească cu diligența unui bun proprietar autovehiculul"
    text "c) să returneze autovehiculul Locatorului împreună cu actele de înmatriculare, cu accesoriile și echipamentul acestuia și în starea în care l-a primit, la ora și data specificată în contract;",:align => :justify           
    text "d) folosind autovehiculul să respecte prevederile Regulamentului circulației rutiere (Hotărârea Guvernului cu privire la aprobarea Regulamentului circulației rutiere, nr. 357 din 13.05.2009);" ,:align => :justify
    text "e) să respecte instrucțiunile și recomandările producătorului;" 
    text "f) să alimenteze autovehiculul doar cu carburant corespunzător și calitativ;"
    text "g) să înapoieze autovehiculul cu același indice al rezervorului de carburant cu care l-a primit în chirie. Orice litru lipsă de combustibil va fi taxat cu 1.20 Euro/litru;",:align => :justify
    text "h) să înapoieze autovehiculul cura în interior și la exterior;"
    text "i) în caz că dorește returnarea anticipată a autovehiculului să preîntâmpine reprezentantul locatorului cu 5 ore înainte de returnare;",:align => :justify
    text "j) să anunțe în decurs de 12 ore din momentul primirii autovehiculului despre orice defecțiune depistată (interior/exterior/tehnic) și nemenționată în actul de predare primire (care nu-i este imputabilă) în caz contrar defecțiunea va fi considerată imputabilă locatarului;",:align => :justify
    text "k) să parcheze doar în locuri neinterzise, iar pe timp de noapte doar la parcări păzite. "
    text "4.3. Locatarului îi sunt interzise următoarele acțiuni: "
    text "a) remorcarea, indiferent dacă este vorba de un alt vehicul sau remorcă;"
    text "b) supraîncărcarea autovehiculului (numărul maxim de persoane care pot fi transportate concomitent este 5);",:align => :justify
    text "c) folosirea autovehiculului sub influența alcoolului, substanțelor narcotice sau psihotrope, barbiturice sau orice alte substanțe care pot afecta concentrarea sau abilitarea de a reacționa efectiv;",:align => :justify
    text "d) folosirea autovehiculului în caz de defecțiune tehnică; "
    text "e) folosirea autovehiculului în curse, teste sau concursuri de automobile;"
    text "f) folosirea autovehiculului în afara drumurilor publice;"
    text "g) lăsarea autovehiculului cu ușile, geamurile și/or portbagajul descuiate;"
    text "h) să transmită autovehiculul pentru a fi condus unei alte persoane fără acordul expres al Locatorului indicat în actul de primire predare (chiria se va mări cu 10 Euro/zi pentru fiecare persoană indicată suplimentar);",:align => :justify
    text "i) să efectueze modificări în construcția autovehiculului sau în privința aspectului exterior al autovehiculului fără acordul scris și prealabil al Locatorului;",:align => :justify
    text "j) să dea în sublocațiune autovehiculul, să cesioneze prezentul contract de Locațiune unui terț, să folosească autovehiculul în scopuri taximetrice.",:align => :justify
    text "V. Chiria și modul de achitare", :align => :center, :style => :bold
    text "5.1. Chiria zilnică constituie <b>#{pretperday} lei</b>, respectiv pentru <b>#{daysinperiod}</b> zile. Locatarul urmează să achite <b>#{contract.summ} lei</b>.",:inline_format => true,:align => :justify
    text "5.2. Plata se va efectua integral în avans."
    text "5.3. Chemarea angajaților Locatorului în afara orelor de program (10.00-18.30) sau în alt punct din mun. Chișinău decât punctele de lucru ale Locatorului, se achită suplimentar cu 15 Euro (cauza chemării poate fi diferită primirea/predarea autovehiculului etc.)",:align => :justify
    text "5.4. Suplimentar, se achită: pentru deplasarea autovehiculului peste hotarele țării – 5,00 Euro/zi (pentru deplasarea peste hotare este obligatoriu acordul scris al Locatorului), scaunul pentru copil Euro/zi, navigatorul gps – 5,00 Euro/zi.",:align => :justify
    text "VI. Garanția de închiriere", :align => :center, :style => :bold
    text "6.1. Locatarul este obligat să transmită Locatorului <b>#{contract.zalog}</b> cu titlu de garanție de închiriere până la începerea termenului Locațiunii.",:inline_format => true,:align => :justify
    text "6.2. Garanția va fi restituită când autovehiculul va fi înapoiat în condițiile în care l-a primit de la Locator. "
    text "6.3. Garanția nu se va restitui în caz de accident. Ea va fi folosită pentru recuperarea prejudiciului cauzat Locatorului prin faptul că acesta din urmă nu se va putea folosi de autovehicul. În cazul în care garanția nu va fi de ajuns pentru recuperarea prejudiciului, Locatarul va fi obligat să achite suplimentar chiria pentru zilele în care autoturismul va sta în reparație.",:align => :justify
    text "6.4. Garanția va putea fi reținută și în alte cazuri în care Locatarul va avea obligații bănești față de Locator. "
    text "VII. Răspunderea părților", :align => :center, :style => :bold
    text "7.1. Dacă autovehiculul va fi returnat murdar, Locatarul va achita o penalitate în mărime de 15 Euro."
    text "7.2. Dacă autovehiculul nu va fi returnat în termenii prevăzuți de prezentul contract, Locatarul va achita o penalitate după cum urmează: prima oră de întârziere va fi taxată cu 5 Euro, următoarele 2 ore cu 7 euro/ora. Pentru mau mult de 3 ore de întârziere Locatarul va fi taxat ca pentru o zi întreagă, iar Locatorul va sesiza organele de poliție, declarând autovehiculul dispărut.",:align => :justify
    text "7.3.Locatarul va fi obligat la achitarea: unei penalități în mărime de 400 Euro / unitate pentru pierderea deteriorarea actelor; 400 Euro / unitate pentru pierderea deteriorarea  cheilor, 10 Euro/unitate pentru pierderea deteriorarea foii de parcurs, 200 Euro / unitate pentru pierderea deteriorarea plăcuțelor de înmatriculare.",:align => :justify
    text "7.4. În cazul în care autovehiculul nu va fi returnat în starea în care a fost primit (indiferent care este  cauza – accident, avarie, furt, calamitate naturală etc.; în caz de accident, nu prezintă importanță dacă Locatarul se face vinovat sau nu de producerea acestuia), iar defecțiunile nu sunt imputabile Locatorului, Locatarul va fi obligat să achite în întregime prejudiciul cauzat autovehiculului, până la valoarea autovehiculului stabilită de părți în prezentul contract (p. 2.1).",:align => :justify
    text "7.5. Locatarul va răspunde deplin și personal și pentru prejudiciul cauzat terților prin folosirea autovehiculului în perioada de acțiune a prezentului contract (până la restituirea autovehiculului).",:align => :justify
    text "7.6. Locatarul va achita suplimentar zilele în care autovehiculul nu va putea fi folosit urmare a cazului prevăzut de p. 7.4. dar și ca urmare a altor fapte ale Locatarului (de ex. nerestituirea cheii, documentelor, etc.) conform chiriei convenite în p. V.",:align => :justify
    text "7.7. Reparația autovehiculului va fi efectuată doar la stațiile tehnice calificate aprobate de Locator și doar cu piese originale noi.",:align => :justify
    text "7.8. Locatorul nu răspunde de pierderea, deteriorarea bunurilor lăsate în autovehicul."
    text "VIII. Accident, avarie, furt", :align => :center, :style => :bold
    text "8.1. În caz de accident Locatarul este obligat:"
    text "a) să nu părăsească autovehiculul fără a lua măsurile de precauție adecvate pentru siguranță și securitate; "
    text "b) să obțină numele și adresa persoanelor implicate, a martorilor;"
    text "c) să anunțe Locatorul prin intermediul telefonului imediat, chiar și în cazul unei defecțiuni minore;"
    text "d) să anunțe imediat organele de poliție și să solicite întocmirea actelor privind cauzele și împrejurările accidentului."
    text "8.2. În caz de accident, furt sau avariere, Locatarul este obligat să prezinte următoarele acte:"
    text "a) cererea privind evenimentul produs înregistrată la asigurator;"
    text "b) copia procesului-verbal întocmit pe marginea accidentului produs;"
    text "c) copia schemei locului accidentului;"
    text "d) hotărârea organului poliției rutiere privind stabilirea persoanei vinovate;"
    text "e) Actul de revizie a mijloacelor de transport auto deteriorate;"
    text "f) Devizul reparației de restabilire;"
    text "g) fotografiile autovehiculului deteriorat;"
    text "h) copia certificatului medical. "
    text "8.3. În caz de accident, avarie sau furt, toată responsabilitatea o poartă Locatarul."
    text "IX. Locul de executare a contractului", :align => :center, :style => :bold
    text "9.1. Locul de executare a prezentului contract este mun. Chișinău, sectorul Botanica."
    text "X. Clauze finale", :align => :center, :style => :bold
    text "10.1. Modificarea prezentului contract se poate face numai prin acord adițional"
    text "10.2. Prezentul contract, împreună cu anexele sale, reprezintă voința părților și înlătură orice altă înțelegere verbală dintre acestea, anterioară sau ulterioară încheierii lui.",:align => :justify
    text "XI. Rechizitele și semnăturile", :align => :center, :style => :bold
    move_down 5
    y_position = cursor
    bounding_box([0, y_position], :width => 260) do
       text "Locator", :align => :center, :style => :bold
       move_down 3
       text "SRL Success&DivesGroup", :align => :left, :style => :bold
       text "MD – 2015 mu. Chișinău str.N.Titulescu 8, ap.22", :align => :left, :style => :bold
       text "c/f  1014600011035", :align => :left, :style => :bold
       text "BC Moldindconbank SA, fil.nr.2", :align => :left, :style => :bold
       text "c/b 225190 / c/d MOLDMD2X301", :align => :left, :style => :bold
    end  #bounding box
    bounding_box([260, y_position], :width => 260) do
       text "Locatar", :align => :center, :style => :bold
       move_down 3
       text "N.P. <font size='10'>#{client.sname} #{client.name} #{client.fname}</font>", :align => :left, :style => :bold,:inline_format => true
       text "ADRESA.  <font size='10'>#{client.address} </font>", :align => :left, :style => :bold,:inline_format => true
       text "SERIA.  <font size='10'>#{client.pseria} </font>", :align => :left, :style => :bold,:inline_format => true
       text "COD.IDNO.  <font size='10'>#{client.idno} </font>", :align => :left, :style => :bold,:inline_format => true
       text "D.N.  <font size='10'>#{client.bdate}</font>", :align => :left, :style => :bold,:inline_format => true
       text "D.E.  <font size='10'>#{client.dn}</font>", :align => :left, :style => :bold,:inline_format => true
       text "EMAIL.  <font size='10'>#{client.pemail}</font>", :align => :left, :style => :bold,:inline_format => true
       text "TEL.  <font size='10'>#{client.tel}</font>", :align => :left, :style => :bold,:inline_format => true
    end  #bounding box
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 40) do
       move_down 10
       text "SRL Success&DivesGroup", :align => :left, :style => :bold
    end  #bounding box
    bounding_box([260, y_position], :width => 260, :height => 40) do
    end  #bounding box
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 40) do
       text "Semnătura ______________________", :align => :left, :style => :bold
    end  #bounding box
    bounding_box([260, y_position], :width => 260, :height => 40) do
       text "Semnătura ______________________", :align => :left, :style => :bold
    end  #bounding box 
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 40) do
    end  #bounding box
    bounding_box([260, y_position], :width => 260, :height => 40) do
       text "Nume Prenume__________________________________________________", :align => :left, :style => :bold, :leading => 5
    end  #bounding box   
    text "L.Ș.", :align => :left, :style => :bold

    start_new_page
    text "ACT DE PREDARE-PRIMIRE A AUTOVEHICULULUI", :align => :center, :style => :bold
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 16) do
       text "Mun. Chișinău", :align => :left, :style => :bold
    end  #bounding box
    bounding_box([260, y_position], :width => 260, :height => 16) do
       text "Data <font size='10'>#{contract.stdate.strftime("%d.%m.%Y")}</font>", :align => :right, :style => :bold, :inline_format => true
    end  #bounding box
    move_down 2
    text "<b>Success&DivesGroup</b> numită în continuare <b><u>Locator</u></b>, pe de o parte și <b>#{client.sname} #{client.name} #{client.fname}</b>," + 
         " numit în continuare <b><u>Locatar</u></b>, pe de altă parte, în baza contractului de locațiune nr. <b>#{contract.id}/#{contract.cnum}</b>" + 
         " din <b>#{contract.order_date.strftime("%d.%m.%Y")}</b> - au încheiat prezentul act despre următoarele:",:align => :justify, :inline_format => true
    text "Partea I. Transmiterea autovehiculului către Locatar", :align => :center, :style => :bold
    indent(5) do
      text "1.  Locatorul a transmis iar Locatarul a primit în folosință temporară următorul autovehicul:", :align => :left
    end
    text "Identificarea autovehiculului", :align => :center, :style => :bold
    move_down 1
    y_position = cursor
    bounding_box([0, y_position], :width => 260) do
      text "Modelul, marca", :align => :left
      text "Numărul de înmatriculare", :align => :left
      text "Numărul caroseriei", :align => :left     
      text "Numărul motorului", :align => :left 
      text "Anul producerii", :align => :left 
      text "Culoarea", :align => :left 
      text "Capacitatea cilindrică, cm3", :align => :left
      text "Masa totală, kg", :align => :left 
      text "Valoare automobil", :align => :left
    end  #bounding box
    bounding_box([260, y_position], :width => 260) do
      text "#{car.marca}", :align => :left, :style => :bold
      text "#{car.gnum}", :align => :left, :style => :bold
      text "#{car.cuznum}", :align => :left, :style => :bold
      text "#{car.motnum}", :align => :left, :style => :bold
      text "#{car.proddate}", :align => :left, :style => :bold
      text "#{car.color}", :align => :left, :style => :bold
      text "#{car.vmot}", :align => :left, :style => :bold
      text "#{car.tmasa}", :align => :left, :style => :bold
      text "#{car.tsumm} EURO", :align => :left, :style => :bold
    end  #bounding box  
    indent(5) do
      text "2.  În prezentul punct sunt identificate defectele exterioare ale autovehiculului.", :align => :left
    end
    # BEGIN OF PICTURE
    #size = bounds.width 
    #bounding_box([0, cursor], :width => size, :height => 300) do
    #  image "#{Rails.root}/app/assets/images/aveo.jpg", :fit => [size, 300]
    #  stroke_bounds
    #end
    image "#{Rails.root}/app/assets/images/aveo.jpg", :width => bounds.width 
    # END OF PICTURE
    move_down 1
    indent(5) do
      text "3.  Autovehiculul se află în stare bună ce permite exploatarea acestuia conform destinației. ", :align => :left
      text "4.  Locatarul declară că funcționarea corespunzătoare a autovehiculului i-a fost demonstrată, de asemenea că s-a convins de integritatea acestuia și că toate defectele (interioare și exterioare) au fost indicate în prezentul act.  ", :align => :left
      text "5.  Autovehiculul va fi condus de Locatar.", :align => :left            
    end
    move_down 2
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 70) do
       text "Locator", :align => :center, :style => :bold
       move_down 15      
       text "Semnătura ______________________", :align => :left, :style => :bold
       move_down 10
       indent(180) do
        text "L.Ș.", :align => :left, :style => :bold
       end
    end #bounding box
    bounding_box([260, y_position], :width => 260, :height => 70) do
       text "Locatar", :align => :center, :style => :bold      
       move_down 15
       text "Semnătura ______________________", :align => :left, :style => :bold
       move_down 10
       text "Nume", :align => :left, :style => :bold
       text "Prenume__________________________________________________", :align => :left, :style => :bold
    end #bounding box
    move_down 10
    text "Partea II. Restituirea autovehiculului ", :align => :center, :style => :bold
    y_position = cursor
    bounding_box([0, y_position], :width => 260, :height => 16) do
       text "Mun. Chișinău", :align => :left, :style => :bold
    end  #bounding box
    bounding_box([360, y_position], :width => 160, :height => 16) do
       text "Data ________________________", :align => :left, :style => :bold, :inline_format => true
    end  #bounding box
    move_down 2 
    indent(5) do
      text "6.  Locatarul a restituit iar Locatorul a primit autovehiculul identificat în Partea I a prezentului Act de predare-primire. ", :align => :left
      text "7.  În afara defecțiunilor indicate în punctul 2 din prezentul Act de predare-primire, au mai fost identificate următoarele defecțiuni:", :align => :left, :leading => 7
      text "1.  _______________________________________________________________________________________________", :align => :left, :leading => 7
      text "2.  _______________________________________________________________________________________________", :align => :left        
    end 
    move_down 20
    y_position = cursor
    bounding_box([0, y_position], :width => 260) do
       text "Locator", :align => :left, :style => :bold   
       text "Semnătura ______________________", :align => :left, :style => :bold
       move_down 20
       text "Locatar", :align => :left, :style => :bold    
       text "Semnătura ______________________", :align => :left, :style => :bold
    end #bounding box
    bounding_box([360, y_position], :width => 160) do     
       move_down 10
       text "L.Ș.", :align => :left, :style => :bold
    end   #bounding box              
    render
  end
  
end
