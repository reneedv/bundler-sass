require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassCreator" do
  before(:all) do
    @root_dir = Dir.getwd
    Dir.mkdir("test_files")
  end
  before(:each) do
    Dir.chdir("test_files")
  end
  
  context "create partials" do
    
    it "should create multiple files" do
      SassCreator.new({"_1.sass" => [], "_2.sass" => []})
      Dir.chdir(@root_dir)
      Dir.entries("test_files").include?("_2.sass").should eq true
    end
    
  end

  context "create files with dependancies" do
    it "should create a file with an //import statement" do
      @partial = SassCreator.new({"_1.sass" => ["_2.sass"], "_2.sass" => []})
      @partial.build_imports
      File.open("_1.sass", 'r').each do |line|
        line.chomp.should eq '//import "_2.sass"'
      end
    end

    it "should create a file with many //import statements" do
      @partial = SassCreator.new({"_1.sass" => ["_2.sass", "_3.sass", "_4.sass"]})
      @partial.build_imports
      File.open("_1.sass", 'r').each_with_index do |line, index|
        @line = line.chomp
      end
      @line.should eq '//import "_4.sass"'
    end
  end

  after(:each) do
    Dir.chdir @root_dir
  end

  after(:all) do
    Dir.foreach("test_files") do |partial|
      File.delete("test_files/" + partial) unless partial == '.' or partial == '..'
    end
    Dir.rmdir("test_files")
  end
end
