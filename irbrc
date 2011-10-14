if defined?(::Bundler)
  $:.concat Dir.glob(File.expand_path('gems/*/lib', ENV['rvm_ruby_global_gems_path']))
end

begin
  begin # ANSI codes
    module Colors
      def self.color(colors={})
        (class << self; self; end).module_eval do
          colors.each do |name, code|
            define_method(name) { code }
          end
        end
      end

      color :black      => "\033[0;30m"
      color :gray       => "\033[1;30m"
      color :red        => "\033[0;31m"
      color :lred       => "\033[1;31m"
      color :green      => "\033[0;32m"
      color :lgreen     => "\033[1;32m"
      color :brown      => "\033[0;33m"
      color :yellow     => "\033[1;33m"
      color :blue       => "\033[0;34m"
      color :lblue      => "\033[1;34m"
      color :purple     => "\033[0;35m"
      color :lpurple    => "\033[1;35m"
      color :cyan       => "\033[0;36m"
      color :lcyan      => "\033[1;36m"
      color :lgray      => "\033[0;37m"
      color :white      => "\033[1;37m"

      color :backblack  => "\033[40m"
      color :backred    => "\033[41m"
      color :backgreen  => "\033[42m"
      color :backyellow => "\033[43m"
      color :backblue   => "\033[44m"
      color :backpurple => "\033[45m"
      color :backcyan   => "\033[46m"
      color :backgray   => "\033[47m"

      color :reset      => "\033[0m"
      color :bold       => "\033[1m"
      color :underscore => "\033[4m"
      color :blink      => "\033[5m"
      color :reverse    => "\033[7m"
      color :concealed  => "\033[8m"
    end

    XTERM_SET_TITLE   = "\033]2;"
    XTERM_END         = "\007"
    ITERM_SET_TAB     = "\033]1;"
    ITERM_END         = "\007"
    SCREEN_SET_STATUS = "\033]0;"
    SCREEN_END        = "\007"

    def ansi(*modes, &blk)
      out = []
      modes.each do |mode|
        out << Colors.send(mode)
      end
      out << yield
      out << Colors.reset

      out.join
    end
  end

  if defined? IRB # Custom Prompt
    if IRB and IRB.conf[:PROMPT]
      IRB.conf[:PROMPT][:SD] = {
        :PROMPT_I => ">> ", # normal prompt
        :PROMPT_S => "%l> ",  # string continuation
        :PROMPT_C => " > ",   # code continuation
        :PROMPT_N => " > ",   # code continuation too?
        :RETURN   => ansi(:bold) { "=> %s  " } << "\n\n", # return value
        :AUTO_INDENT => true
      }
      IRB.conf[:PROMPT_MODE] = :SD
    end
  end

  STYLE = ""

  def style(st)
    STYLE.replace(st)
  end

  if defined? Ripl
    module JaysCustomFormatter
      # errors are red and bold
      def format_error(result)
        ansi(:red, :bold) { super }
      end

      # format stdout output
      def loop_eval(*args)
        print Colors.green
        res = super
      ensure
        print Colors.reset
      end
    end

    Ripl::Shell.send(:include, JaysCustomFormatter)

    Ripl.config[:multi_line_prompt] = ' | '

    require 'logger'
    require 'awesome_print'
    Ripl.config[:color_result_engine] = :ap
    Ripl.config[:color_result_ap_options] = {
      :index => false,
      :indent => 2,
      :color => {
        :symbol => :purple
      }
    }

  end

  begin # Utility methods
    class Object
      def own_methods(*options) # Print methods
        parent = if self.class == Module
          Module
        elsif self.class == Class
          Class
        else
          Object
        end

        methods - parent.instance_methods
      end
    end
  end

  begin
    require 'sketches'
    Sketches.config :editor => 'vim'
    alias vim sketch
  rescue LoadError
  end

  begin # pretty printing
    require 'pp'
  end

  # because I got sick of typing this
  begin
    def fixjour!
      require 'ffaker'; require 'fixjour'
      begin
        require 'spec/support/faker_ext.rb'
        require 'spec/support/builders.rb'
      end
      include Fixjour
    end
  end

  begin
    class Fixnum
      def of(el=nil, &blk)
        blk ||= lambda { el.dup rescue el }
        arr = []
        times { |i| arr << blk[i] }
        arr
      end
    end
  end

  # helpful extensions
  begin
    class Symbol
      include Comparable
      def <=>(other)
        self.to_s <=> other.to_s
      end unless :a.respond_to?(:<=>)
    end

    class Fixnum
      def of(&blk)
        (0...self).map(&blk)
      end
    end

    module Enumerable
      def histogram(&blk)
        h = Hash.new(0)
        each do |e|
          h[blk ? blk[e] : e] += 1
        end
        h
      end

      def to_h
        Hash.new(self)
      end

      def hashmap
        h = {}
        each do |e|
          h[e] = yield e
        end
        h
      end
    end
  end

  begin
    class << File
      def write(fname, contents)
        open(fname, 'w') { |f| f.puts contents }
      end
    end
  end

end
