class Dialogues
  def initialize(&block)
    @var = []
    instance_eval &block
  end

  def method_missing(m, *args, &block)
    if args.any?
      args = args.first if args.length == 1
      @var << { m => args }
      instance_variable_set "@#{m}", args
    else
      return instance_variable_get "@#{m}"
    end
  end

end

@dialogues = Dialogues.new do
  backgroundImage :city

  playSound       :fur_umbrogia,
                  :loop => true

  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :animation => :fadeInWithText,
                  :text      => 'Hi!'
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => 'My name is Ambrogia, and yours?'

  input           :what      => :name,
                  :type      => :text,
                  :text      => 'What is your name?'
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => 'Oh, hai #name#!'
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => 'How do you feel?'
                  
  input           :name      => :feel,
                  :type      => :choice,
                  :options   => { :good => 'Good', :bad => 'Bad' }
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => "Oh, I'm glad!",
                  :if        => "'#feel#' == 'good'"
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => "Oh, I'm sorry :(",
                  :if        => "'#feel#' == 'bad'"
                  
  input           :name      => :gender,
                  :type      => :choice,
                  :options   => { :boy => 'Boy', :girl => 'Girl' }
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => 'What a nice guy :D',
                  :if        => "'#gender#' == 'boy' and '#feel#' == 'good'"
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => 'Oh, poor honey :(',
                  :if        => "'#gender#' == 'boy' and '#feel#' != 'good'"
                  
  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :text      => '/cares',
                  :if        => "'#gender#' == 'girl'"

  dialogue        :name      => 'Ambrogia',
                  :character => :girl,
                  :animation => :fadeOutWithText,
                  :text      => 'kktnxbai!'

  stopSound       :fur_umbrogia

  nextChapter     :sequel
end
#require 'pp';pp @dialogues
p @dialogues.class