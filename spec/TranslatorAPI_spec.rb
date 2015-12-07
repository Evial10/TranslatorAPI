require 'spec_helper'

describe TranslatorAPI::TextProcessing do
  
  it 'has a version number' do
    expect(TranslatorAPI::VERSION).not_to be nil
  end
 
  it 'Incorrect reduction' do
    translator = TranslatorAPI::TextProcessing.new('trnsl.1.1.20151124T095711Z.d41f13a82e427408.736db2b43c90575b5934e1b988554b94947240e1',"Incorrect reduction")
    expect(translator).to be_instance_of NilClass  
  end
  
  it 'Invalid key' do
    translator = TranslatorAPI::TextProcessing.new('Invalid key')
    expect(translator).to be_instance_of NilClass  
  end
  
  before :each do
      @translator = TranslatorAPI::TextProcessing.new 'trnsl.1.1.20151124T095711Z.d41f13a82e427408.736db2b43c90575b5934e1b988554b94947240e1'      
  end 
  
  describe "#get_list" do
    
    it 'return value' do
      langs, dirs = @translator.get_list
      expect(langs).to be_instance_of Hash
      expect(dirs).to be_instance_of Array
    end
    
  end
  
  describe "#translate" do
  
    before :each do
      @text = "भाषा" # Marathi language 
    end
 
    it 'translate with parametr text' do
    expect(@translator.translate("Something text")).to be_instance_of String
    end    
    
    it 'translate without parametrs' do
     lambda{ @translator.translate }.should raise_exception ArgumentError
    end 
    
    it 'translate not suppot language without parametra lang' do       
    expect(@translator.translate(@text)).to eql @text 
    end 
    
    it 'translate not suppot language with valid parametra lang' do        
    expect(@translator.translate(@text, "zh-ru")).to eql @text 
    end
    
    it 'translate not suppot language with invalid parametra lang' do       
    expect(@translator.translate(@text, "invalid parametra lang")).to be nil 
    end
    
    it 'translate suppot language with invalid parametra lang' do       
    expect(@translator.translate("English", "invalid parametra lang")).to be nil 
    end
    
  end
  
  describe "#detect" do
  
    it 'detect without parametrs' do
      lambda{@translator.detect }.should raise_exception ArgumentError 
    end
    
    it 'detect with parametr text' do
    expect(@translator.detect("Something text")).to be_instance_of String 
    end
    
    it 'not suppot language' do        
    expect(@translator.detect("भाषा")).to be nil 
    end     
    
  end   
  
  it 'double request according to one uri' do
    expect(@translator.translate("One")).to be_instance_of String
    expect(@translator.translate("Two")).to be_instance_of String
  end
  
end
