#Этот код необходим для русских букв
if Gem.win_platform?
    Encoding.default_external = Encoding.find(Encoding.locale_charmap)
    Encoding.default_internal = __ENCODING__
  
    [STDIN, STDOUT].each do |io|
      io.set_encoding(Encoding.default_external, Encoding.default_internal)
    end
  end
  
  #Библиотеки
  require 'net/http'
  require 'rexml/document'
  
  URL = 'http://www.cbr.ru/scripts/XML_daily.asp'
  
  #Данные с сайта в XML
  response = Net::HTTP.get_response(URI.parse(URL))
  doc = REXML::Document.new(response.body)
  
  #Значения в документе:
  #R01235 — Доллар США
  #R01239 — Евро
  doc.each_element('//Valute[@ID="R01235" or @ID="R01239"]') do |currency_tag|
    
    name = currency_tag.get_text('Name')
    value = currency_tag.get_text('Value')
  
    #Вывод на консоль:
    puts "#{name}: #{value} руб."
  end