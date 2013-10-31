require 'rubygems'
require 'sinatra'
require "rexml/document"
include REXML
require 'pp'

get '/' do
    #FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefile
end

get '/nua' do
    #FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefileNUA
end

get '/dqr' do
    #FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefileDQR
end

post '/showfirstfileNUA' do
    #pp params
    $thefiles = []
    $thetempfiles = []
    params["chosenfiles"].each {|file|
        #pp file
        $thefiles << file[:filename]
        $thetempfiles << file[:tempfile].read
    }

    $currentfile = 0
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash
    }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisNUA
end

post '/shownextfileNUA' do
    $currentfile = $currentfile + 1 if $currentfile < $thefiles.size - 1
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash
    }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisNUA
end

post '/showprevfileNUA' do
    $currentfile = $currentfile - 1 if $currentfile > 0
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash
    }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisNUA
end

post '/showevidenceNUA' do
    
    $thefile = params["selectedfile"]
    aString = params['myfile'][:tempfile].read
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash
    }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisNUA
end

##########################
post '/showfirstfile' do
    #pp params
    $thefiles = []
    $thetempfiles = []
    params["chosenfiles"].each {|file|
        #pp file
        $thefiles << file[:filename]
        $thetempfiles << file[:tempfile].read
    }
    $currentfile = 0
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash if ahash[:confidence] == 3
    }
    erb:showclaris
end

post '/shownextfile' do
    $currentfile = $currentfile + 1 if $currentfile < $thefiles.size - 1
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash if ahash[:confidence] == 3
    }
    erb:showclaris
end

post '/showprevfile' do
    $currentfile = $currentfile - 1 if $currentfile > 0
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash if ahash[:confidence] == 3
    }
    erb:showclaris
end


post '/showclaris' do
    
    #    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
    #    f.write(params['myfile'][:tempfile].read)
    #    end
    #@file = "uploads/" + params["myfile"][:filename]
    #afile = File.new( @file )
    
    #aString = params['myfile'][:filename][:body]
    #doc = REXML::Document.new afile
    
    $thefile = params["myfile"][:filename]
    aString = params['myfile'][:tempfile].read
    doc = REXML::Document.new aString
    
    $claris = []
    doc.elements.each("ns3:cclad/ns3:canonicalClarificationDocument/ns3:clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["family"].get_text
        ahash[:kind] = element.elements["kind"].get_text if element.elements["kind"]
        ahash[:type] = element.elements["type"].get_text if element.elements["type"]
        ahash[:confidence] = element.elements["confidence"].text.to_i
        ahash[:documentationText] = element.elements["documentationText"].get_text
        $claris << ahash if ahash[:confidence] == 3
    }
    erb:showclaris
end
####################################

post '/showfirstfileDQR' do
    #pp params
    $thefiles = []
    $thetempfiles = []
    params["chosenfiles"].each {|file|
        #pp file
        $thefiles << file[:filename]
        $thetempfiles << file[:tempfile].read
    }
    $currentfile = 0
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    themrn = doc.elements["ns2:DqrClarifications/Person/Id"].get_text
    thevisit = doc.elements["ns2:DqrClarifications/EncounterId"].get_text
    theauthor = ""
    thecorrelationid = ""
    thelastname = ""
    thefirstname = ""
    thedateofbirth =  doc.elements["ns2:DqrClarifications/Person/DOB"].get_text
    thegender = doc.elements["ns2:DqrClarifications/Person/Gender"].get_text
    thevisitstart = ""
    thediscard = ""
    thepor = ""
    
    $claris = []
    doc.elements.each("ns2:DqrClarifications/Clarification") { |element|
        ahash = {}
        ahash[:mrn] = themrn
        ahash[:visit] = thevisit
        ahash[:author] = theauthor
        ahash[:correlationid] = thecorrelationid
        ahash[:lastname] = thelastname
        ahash[:firstname] = thefirstname
        ahash[:dateofbirth] = thedateofbirth
        ahash[:gender] = thegender
        ahash[:visitstart] = thevisitstart
        ahash[:discard] = thediscard
        ahash[:por] = thepor
        
        ahash[:docid] = element.elements["Document/Id"].get_text
        ahash[:family] = element.elements["Family"].get_text
        ahash[:kind] = element.elements["Kind"].get_text if element.elements["Kind"]
        ahash[:type] = element.elements["Type"].get_text if element.elements["Type"]
        ahash[:confidence] = element.elements["Confidence"].text.to_i
        ahash[:documentationText] = element.elements["ClarificationResponse/DocumentationText"].get_text
        $claris << ahash
    }
    #puts "family: #{element.elements["family"]}, kind: #{element.elements["kind"]}, type: #{element.elements["type"]}, confidence: #{element.elements["confidence"]}" }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisDQR
end

post '/selectresponse' do
    
    
    erb:chooseresponseDQR
end

post '/shownextfileDQR' do
    $currentfile = $currentfile + 1 if $currentfile < $thefiles.size - 1
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns2:DqrClarifications/Clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["Family"].get_text
        ahash[:kind] = element.elements["Kind"].get_text if element.elements["Kind"]
        ahash[:type] = element.elements["Type"].get_text if element.elements["Type"]
        ahash[:confidence] = element.elements["Confidence"].text.to_i
        ahash[:documentationText] = element.elements["ClarificationResponse/DocumentationText"].get_text
        $claris << ahash
    }
    #puts "family: #{element.elements["family"]}, kind: #{element.elements["kind"]}, type: #{element.elements["type"]}, confidence: #{element.elements["confidence"]}" }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisDQR
end

post '/showprevfileDQR' do
    $currentfile = $currentfile - 1 if $currentfile > 0
    
    $thefile = $thefiles[$currentfile]
    aString = $thetempfiles[$currentfile]
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns2:DqrClarifications/Clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["Family"].get_text
        ahash[:kind] = element.elements["Kind"].get_text if element.elements["Kind"]
        ahash[:type] = element.elements["Type"].get_text if element.elements["Type"]
        ahash[:confidence] = element.elements["Confidence"].text.to_i
        ahash[:documentationText] = element.elements["ClarificationResponse/DocumentationText"].get_text
        $claris << ahash
    }
    #puts "family: #{element.elements["family"]}, kind: #{element.elements["kind"]}, type: #{element.elements["type"]}, confidence: #{element.elements["confidence"]}" }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisDQR
end

post '/showclarisDQR' do
    $thefile = params["myfile"][:filename]
    aString = params['myfile'][:tempfile].read
    doc = REXML::Document.new aString
    $claris = []
    doc.elements.each("ns2:DqrClarifications/Clarification") { |element|
        ahash = {}
        ahash[:family] = element.elements["Family"].get_text
        ahash[:kind] = element.elements["Kind"].get_text if element.elements["Kind"]
        ahash[:type] = element.elements["Type"].get_text if element.elements["Type"]
        ahash[:confidence] = element.elements["Confidence"].text.to_i
        ahash[:documentationText] = element.elements["ClarificationResponse/DocumentationText"].get_text
        $claris << ahash
    }
    #puts "family: #{element.elements["family"]}, kind: #{element.elements["kind"]}, type: #{element.elements["type"]}, confidence: #{element.elements["confidence"]}" }
    $claris = $claris.sort_by {|aclari| -aclari[:confidence]}
    erb:showclarisDQR
end


post '/showfiles' do
    erb:choosefile
end

post '/showchoosefilesNUA' do
    erb:choosefileNUA
end

post '/showfilesDQR' do
    erb:choosefileDQR
end
