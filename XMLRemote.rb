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
    erb:chooseinputoutputDQR
end

post '/dqr' do
    #FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:chooseinputoutputDQR
end

post '/outputDQR' do
    erb:chooseoutputfileDQR
end

post '/inputDQR' do
    $visitadd= ""
    erb:chooseinputfileDQR
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
    #$thePath = "/Users/jamesflanagan/Documents/RubyRelated/RubyProjects/XMLRemote"
    $thePath = ""
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

post '/showfirsttestfileDQR' do
    #pp params
    $thefiles = []
    $thetempfiles = []
    params["chosenfiles"].each {|file|
        #pp file
        $thefiles << file[:filename]
        $thetempfiles << file[:tempfile].read
    }
    $currentfile = 0
    #$thePath = "/Users/jamesflanagan/Documents/RubyRelated/RubyProjects/XMLRemote"
    $thePath = ""
    #$afile = $thefiles[$currentfile]
    aString = StringIO.new(string=$thetempfiles[$currentfile])
    $rows = aString.readlines.map { |line| line }
    $theFile = {}
    $theFile[:docname] = $thefiles[$currentfile]
    $theFile[:mrn] = $rows[0].gsub("mrn=","").chomp
    mrnstring = $theFile[:mrn]
    $theFile[:visit] = $rows[1].gsub("visitcode=","")
    $theFile[:setvisitadd] = $theFile[:visit].gsub(/#{mrnstring}/,"")
    $theFile[:visitadd] = $theFile[:setvisitadd].gsub(/_.+_/, "").gsub('_','')
    if $theFile[:setvisitadd].scan(/_.+_/)[0]
        $theFile[:setadd] = $theFile[:setvisitadd].scan(/_.+_/)[0].gsub('_','')
    else
        $theFile[:setadd] = ""
    end
    $theFile[:author] = $rows[2].gsub("authorid=","")
    $theFile[:correlationid] = $rows[3].gsub("correlationid=","")
    $theFile[:lastname] = $rows[4].gsub("lastName=","")
    $theFile[:firstname] = $rows[5].gsub("firstName=","")
    $theFile[:dateofbirth] = $rows[6].gsub("dateOfBirth=","")
    $theFile[:gender] = $rows[7].gsub("gender=","")
    $theFile[:visitstart] = $rows[8].gsub("visitStart=","")
    $theFile[:discard] = $rows[9].gsub("isDiscard=","")
    $theFile[:por] = $rows[10].gsub("isPOR=","")
    $theFile[:text] = ""
    $rows.each_index {|arownumber|
    $theFile[:text] = $theFile[:text] + $rows[arownumber] if arownumber > 10}
    
    erb:showtestfileDQR
end

post '/shownexttestfileDQR' do
    $currentfile = $currentfile + 1 if $currentfile < $thefiles.size - 1
    aString = StringIO.new(string=$thetempfiles[$currentfile])
    $rows = aString.readlines.map { |line| line }
    $theFile = {}
    $theFile[:docname] = $thefiles[$currentfile]
    $theFile[:mrn] = $rows[0].gsub("mrn=","").chomp
    mrnstring = $theFile[:mrn]
    $theFile[:visit] = $rows[1].gsub("visitcode=","")
    $theFile[:setvisitadd] = $theFile[:visit].gsub(/#{mrnstring}/,"")
    if $visitadd == ""
        $theFile[:visitadd] = $theFile[:setvisitadd].gsub(/_.+_/, "").gsub('_','')
        else
        $theFile[:visitadd] = $visitadd
    end
    if $theFile[:setvisitadd].scan(/_.+_/)[0]
        $theFile[:setadd] = $theFile[:setvisitadd].scan(/_.+_/)[0].gsub('_','')
        else
        $theFile[:setadd] = ""
    end
    $theFile[:author] = $rows[2].gsub("authorid=","")
    $theFile[:correlationid] = $rows[3].gsub("correlationid=","")
    $theFile[:lastname] = $rows[4].gsub("lastName=","")
    $theFile[:firstname] = $rows[5].gsub("firstName=","")
    $theFile[:dateofbirth] = $rows[6].gsub("dateOfBirth=","")
    $theFile[:gender] = $rows[7].gsub("gender=","")
    $theFile[:visitstart] = $rows[8].gsub("visitStart=","")
    $theFile[:discard] = $rows[9].gsub("isDiscard=","")
    $theFile[:por] = $rows[10].gsub("isPOR=","")
    $theFile[:text] = ""
    $rows.each_index {|arownumber|
        $theFile[:text] = $theFile[:text] + $rows[arownumber] if arownumber > 10}
    
    erb:showtestfileDQR
end

post '/showprevtestfileDQR' do
    $currentfile = $currentfile - 1 if $currentfile > 0
    aString = StringIO.new(string=$thetempfiles[$currentfile])
    $rows = aString.readlines.map { |line| line }
    $theFile = {}
    $theFile[:docname] = $thefiles[$currentfile]
    $theFile[:mrn] = $rows[0].gsub("mrn=","").chomp
    mrnstring = $theFile[:mrn]
    $theFile[:visit] = $rows[1].gsub("visitcode=","")
    $theFile[:setvisitadd] = $theFile[:visit].gsub(/#{mrnstring}/,"")
    if $visitadd == ""
        $theFile[:visitadd] = $theFile[:setvisitadd].gsub(/_.+_/, "").gsub('_','')
    else
        $theFile[:visitadd] = $visitadd
    end
    if $theFile[:setvisitadd].scan(/_.+_/)[0]
        $theFile[:setadd] = $theFile[:setvisitadd].scan(/_.+_/)[0].gsub('_','')
        else
        $theFile[:setadd] = ""
    end
    $theFile[:author] = $rows[2].gsub("authorid=","")
    $theFile[:correlationid] = $rows[3].gsub("correlationid=","")
    $theFile[:lastname] = $rows[4].gsub("lastName=","")
    $theFile[:firstname] = $rows[5].gsub("firstName=","")
    $theFile[:dateofbirth] = $rows[6].gsub("dateOfBirth=","")
    $theFile[:gender] = $rows[7].gsub("gender=","")
    $theFile[:visitstart] = $rows[8].gsub("visitStart=","")
    $theFile[:discard] = $rows[9].gsub("isDiscard=","")
    $theFile[:por] = $rows[10].gsub("isPOR=","")
    $theFile[:text] = ""
    $rows.each_index {|arownumber|
        $theFile[:text] = $theFile[:text] + $rows[arownumber] if arownumber > 10}
    
    erb:showtestfileDQR
end


post '/chooseresponseDQR' do
    $theClari = $claris[params["clarification"].to_i]
    erb:chooseresponseDQR
end

post '/createtestfilesDQR' do
    $visitadd = params["visitadd"]
    $createdfiles = []
    #$thePath = params["path"]
    #$theMod = params["mod"]
    #$theVisitAdd = params["visit"]
    while $currentfile < $thefiles.size
    {
    getcurrentfile
    afilename = "./inputarchive/#{$theFile[:docname]}.#{$theMod}_capd.txt"
    $createdfiles << afilename
    afile = File.open(afilename, "w")
    afile.puts("mrn=#{$theFile[:mrn]}")
    thefullvisit = "#{$theFile[:mrn]}_#{$theFile[:setadd]}_#{$visitadd]}"
    afile.puts("visitcode=#{thefullvisit}")

    afile.puts("authorid=#{$theFile[:author]}")
    afile.puts("correlationid=#{$theFile[:correlationid]}")
    afile.puts("lastName=#{$theFile[:lastname]}")
    afile.puts("firstName=#{$theFile[:firstname]}")
    
    afile.puts("dateOfBirth=#{$theFile[:dateofbirth]}")
    afile.puts("gender=#{$theFile[:gender]}")
    afile.puts("visitStart=#{$theFile[:visitstart]}")
    afile.puts("isDiscard=#{$theFile[:discard]}")
    afile.puts("isPOR=#{$theFile[:por]}")   
    $theFile[:text] = $theFile[:text].gsub(/<EncounterId>.+<\/EncounterId>/, "<EncounterId>#{thefullvisit}<\/EncounterId>")
    afile.puts("#{$theFile[:text]}")
    afile.close
    send_file(afilename, :disposition => 'attachment')
    $currentfile = $currentfile + 1
    }
    erb:showfinaltestfileDQR
end

post '/downloads' do
    $createfles.each {|afilename| send_file(afilename, :disposition => 'attachment')}
end

def getcurrentfile
    aString = StringIO.new(string=$thetempfiles[$currentfile])
    $rows = aString.readlines.map { |line| line }
    $theFile = {}
    $theFile[:docname] = $thefiles[$currentfile]
    $theFile[:mrn] = $rows[0].gsub("mrn=","").chomp
    mrnstring = $theFile[:mrn]
    $theFile[:visit] = $rows[1].gsub("visitcode=","")
    $theFile[:setvisitadd] = $theFile[:visit].gsub(/#{mrnstring}/,"")
    if $theFile[:setvisitadd].scan(/_.+_/)[0]
        $theFile[:setadd] = $theFile[:setvisitadd].scan(/_.+_/)[0].gsub('_','')
        else
        $theFile[:setadd] = ""
    end
    $theFile[:author] = $rows[2].gsub("authorid=","")
    $theFile[:correlationid] = $rows[3].gsub("correlationid=","")
    $theFile[:lastname] = $rows[4].gsub("lastName=","")
    $theFile[:firstname] = $rows[5].gsub("firstName=","")
    $theFile[:dateofbirth] = $rows[6].gsub("dateOfBirth=","")
    $theFile[:gender] = $rows[7].gsub("gender=","")
    $theFile[:visitstart] = $rows[8].gsub("visitStart=","")
    $theFile[:discard] = $rows[9].gsub("isDiscard=","")
    $theFile[:por] = $rows[10].gsub("isPOR=","")
    $theFile[:text] = ""
    $rows.each_index {|arownumber|
        $theFile[:text] = $theFile[:text] + $rows[arownumber] if arownumber > 10}
end

post '/createresponsefileDQR' do
    #$thePath = params["path"]
    afilename = "#{params["path"]}/inputarchive/#{$theClari[:docid]}.#{params["response"]}_capd.txt"
    afile = File.open(afilename, "w")
    afile.puts("mrn=#{$theClari[:mrn]}")
    afile.puts("visitcode=#{$theClari[:visit]}")
    afile.puts("authorid=#{$theClari[:author]}")
    afile.puts("correlationid=#{$theClari[:correlationid]}")
    afile.puts("lastName=#{$theClari[:lastname]}")
    afile.puts("firstName=#{$theClari[:firstname]}")
    afile.puts("dateOfBirth=#{$theClari[:dateofbirth]}")
    afile.puts("gender=#{$theClari[:gender]}")
    afile.puts("visitStart=#{$theClari[:visitstart]}")
    afile.puts("isDiscard=#{$theClari[:discard]}")
    afile.puts("isPOR=#{$theClari[:por]}")
    afile.puts("<p:ResolvedDqrClarifications xmlns:p=\"http://www.nuance.com/clu/capd/clarifications/document/dqr/resolved\" xsi:schemaLocation=\"http://www.nuance.com/clu/capd/clarifications/document/dqr/resolved ../../../../clu-capd-model-clarification/src/main/schema/resolved-capd-clarifications-document-dqr.xsd \" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">")
    afile.puts("<  EncounterId>#{$theClari[:visit]}</EncounterId>")
    afile.puts("<  ResolvedClarification>")
    afile.puts("    <Document>")
    afile.puts("      <Id>#{$theClari[:docid]}</Id>")
    afile.puts("    </Document>")
    afile.puts("    <Family>#{$theClari[:family]}</Family>")
    afile.puts("    <Kind>#{$theClari[:kind]}</Kind>")
    afile.puts("    <ReviewerResponse>#{params["response"]}</ReviewerResponse>")
    afile.puts("   </ResolvedClarification>")
    afile.puts("  </p:ResolvedDqrClarifications>")
    afile.close
    erb:showclarisDQR
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
    erb:chooseoutputfileDQR
end
