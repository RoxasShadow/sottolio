module Sottolio

  class Database
    attr_accessor :db

    def initialize
      @db = {}
    end

    def add(key, value)
      @db[key] = value
    end

    def delete(key)
      @db.delete key
    end

    def delete_if(key, &block)
      @db.delete_if key, &block
    end

    def get(key)
      @db[key]
    end

    def has?(key)
      @db.include? key
    end
      alias_method :exist?,   :has?
      alias_method :exists?,  :has?
      alias_method :include?, :has?
  end

  class Block
    attr_accessor :block

    def initialize
      @block = false
    end

    def blocked?
      @block
    end

    def free?
      !@block
    end

    def block!
      @block = true
    end

    def free!
      @block = false
    end
  end

  def Sottolio.get(id)
    `document.getElementById(id)`
  end

  def Sottolio.add_listener(event, element, callback)
    `element.addEventListener(event, callback, false)`
  end

end