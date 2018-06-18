require "sinatra"
require "sinatra/reloader" if development?

def encode(string, key)
  cipher_text = ""
  string.each_char do |c|
    if c =~ /[a-z]/
      cipher_text += (((c.ord + key - 97) % 26) + 97).chr
    elsif c =~ /[A-Z]/
      cipher_text += (((c.ord + key - 65) % 26) + 65).chr
    else
      cipher_text += c
    end
  end
  cipher_text
end

get "/" do
  original_text = params["org_text"]
  key = params["key"].to_i
  encoded = encode(original_text, key) if key != nil && original_text != nil
  erb :index, :locals => {:original_text => original_text, :encoded => encoded}
end