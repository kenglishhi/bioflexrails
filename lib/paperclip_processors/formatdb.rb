

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
      @format = 'kevin'
      @file.pos = 0 # Reset the file position incase it is coming out of a another processor      
      cmd =
      `touch /tmp/temppppkevin`
      dst = Tempfile.new([@basename, @format].compact.join("."))
#      dst << Liquid::Template.parse(@file.read).render(Liquid::Context.new(nil, { :site => @instance.site }))
      dst
    end

  end
end

