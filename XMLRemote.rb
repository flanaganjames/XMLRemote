require 'rubygems'
require 'sinatra'
require "rexml/document"
include REXML


get '/' do
    FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefile
end

get '/nua' do
    FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefileNUA
end

get '/dqr' do
    FileUtils.rm_rf(Dir.glob('uploads/*'))
    erb:choosefileDQR
end


post '/showclaris' do
    
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
        f.write(params['myfile'][:tempfile].read)
    end
    $thefile = params["myfile"][:filename]
    
    @file = "uploads/" + params["myfile"][:filename]
    afile = File.new( @file )
    doc = REXML::Document.new afile
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

post '/showevidenceNUA' do
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
        f.write(params['myfile'][:tempfile].read)
    end
    $thefile = params["myfile"][:filename]
    
    @file = "uploads/" + params["myfile"][:filename]
    afile = File.new( @file )
    doc = REXML::Document.new afile
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
    erb:showclarisNUA
end

post '/showclarisDQR' do
    File.open('uploads/' + params['myfile'][:filename], "w") do |f|
        f.write(params['myfile'][:tempfile].read)
    end
    $thefile = params["myfile"][:filename]
    
    @file = "uploads/" + params["myfile"][:filename]
    afile = File.new( @file )
    doc = REXML::Document.new afile
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

post '/showfilesNUA' do
    erb:choosefileNUA
end

post '/showfilesDQR' do
    erb:choosefileDQR
end
