require "ruby_html/version"

module RubyHtml
  class Generator
    # :html is the array holding the HTML Data.
    # :indents is used to generate pretty XML.
    attr_accessor :indents, :html

    # Initializes the :indents, and :html.
    def initialize
      @indents = 0
      @html = "<!DOCTYPE html>"
    end

    # Catch-all method to avoid creating methods
    # for each HTML element.
    #
    # @param (String|Symbol) m, Method Name
    # @param (Array) *args, Array of arguments passed to the method
    # @param (Block) &block, do...end functions
    def method_missing(m, *args, &block)
      # Calls the tag method
      # tag returns the html array.
      tag(m, args, &block)
    end

    # The first method called when creating an
    # HTML document.
    #
    # @param (Array) *args
    # @param (Block) &block
    def document(*args, &block)
      # Calls the tag method
      # tag returns the html array.
      tag(:html, args, &block)
    end

    # HTML Paragraph Handler. Since in Ruby, p, is short hand for puts, I defined
    # par as the paragraph tag.
    #
    # @param (String|Symbol)
    # @param (Array)
    # @param (Block)
    def par(*args, &block)
      tag('p', args, &block)
    end

    private

    # Create the HTML tag
    #
    # @param (String|Symbol) HTML tag (ul, li, strong, etc...)
    # @param (Array) Can contain a String of text or a Hash of attributes
    # @param (Block) An optional block which will further nest HTML
    # @return (Array) html, Array containing the HTML in an array.
    def tag(html_tag, args, &block)
      # Call the find_content, and get the text of an element to be printed.
      content = find_content(args)
      # Call the html_options, which calls the find_options if it contains a hash.
      # This then turns into the HTML tags.
      options = html_options(find_options(args))

      # Populate the :html Array. I'm not sure why its not called with the @html
      html << "\n#{indent}<#{html_tag}#{options}>#{content}"
      if block_given? # If a block was given, execute
        # Increase the number of indents by 1.
        @indents += 1
        instance_eval(&block)
        @indents -= 1
        # Calls the indent method, returning the number of indents.
        html << "\n#{indent}"
      end
      html << "</#{html_tag}>"
    end

    # Searching the tag arguments, find the text/context element.
    #
    # @param (Array) args
    # @return (String)
    def find_content(args)
      # Detects if the argument is a String.
      args.detect{|arg| arg.is_a? String}
    end

    # Searching the tag arguments, find the hash/attributes element
    #
    # @param (Array) args
    # @return (Hash)
    def find_options(args)
      # Detects if the argument is a Hash, or creates an empty one.
      args.detect{|arg| arg.is_a? Hash} || {}
    end

    # Indent output number of spaces
    #
    # @return (String) The number of indents for pretty XML
    def indent
      "  " * indents
    end

    # Build html options string from Hash
    #
    # @param (Hash) options
    # @return (Array) for the <...> options that define HTML Tags
    def html_options(options)
      options.collect{|key, value|
        value = value.to_s.gsub('"', '\"')
        " #{key}=\"#{value}\""
      }.join("")
    end
  end
end
