require File.dirname(__FILE__) + '/../spec_helper'

describe Formatter do
  before do
    @text_blob_hr = <<-EOB
      "first_one" => "def",
      "second" => "jkl",
      "third_and_longest_one" => "mno",
    EOB
    
    @text_blob_scala_hr = <<-EOB
      "first_one" -> "def",
      "second" -> "jkl",
      "third_and_longest_one" -> "mno",
    EOB
    
    @text_blob_equals = <<-EOB
      "first_one" = "def"
      "second" = "jkl"
      "third_and_longest_one" = "mno"
    EOB
  end
  
  it "should raise an error if no separator is found" do
    lambda { Formatter.format("sdlkfjsldkfj asdfihsadfh lskdjflaksdf") }.should raise_error
  end
  
  it "should find the longest length line before the separator" do
    Formatter.longest_length_before_separator(["abc -> 3", "abcdef -> 4"], "->").should == "abcdef".length
  end
  
  it "should find the match before the separator" do
    Formatter.match_before_separator("abc -> 3", "->").should == "abc"
  end
  
  it "should expand multiple lines correctly" do
    @expected = <<-EOB
      "first_one"             => "def",
      "second"                => "jkl",
      "third_and_longest_one" => "mno",
    EOB
    Formatter.format(@text_blob_hr).should == @expected
  end
  
  describe "separator" do
    it "should find the separator" do
      Formatter.separator(@text_blob_hr).should == "=>"
      Formatter.separator(@text_blob_scala_hr).should == "->"
      Formatter.separator(@text_blob_equals).should == "="
    end
  end
end