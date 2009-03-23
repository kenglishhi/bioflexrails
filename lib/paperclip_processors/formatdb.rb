module Paperclip
  class Formatdb < Processor

    class InstanceNotGiven < ArgumentError; end

    def initialize(file, options = {}, attachment = nil) 
      super
      @file = file
      @options = options
      @attachment = attachment
      @instance = options[:instance]
      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    def make
       cmd = "formatdb -i #{@file.path} -p F -o F -n #{@file.path} " 
       args = " -i #{@file.path} -p F -o F -n #{@file.path} " 
       puts "[kenglish] HELLO KEVIN  #{@file.path} cmd = #{cmd} file = #{@file.path}" 
       Paperclip.run "formatdb",  args 
  #       puts `#{cmd}` 
       f = File.new( [@file.path,"nin"].compact.join(".")  ) 
       puts "new file = #{f.inspect} " 
#      @format = 'kevin'
#      @file.pos = 0 # Reset the file position incase it is coming out of a another processor      
#      cmd = "formatdb -i #{@file} -p F -o F" 

##      dst << Liquid::Template.parse(@file.read).render(Liquid::Context.new(nil, { :site => @instance.site }))
      f
    end

  end
end

