class Script
  include Enumerable

  def initialize(procs = [])
    @var = []
    instance_eval &block         if block_given?
    procs.each { |p| self << p } if procs.any?
  end

  def each(&block)
    @var.each(&block)
  end

  def append(block)
    instance_eval &block
  end
    alias_method :<<, :append

  def has?(type)
    @var.any?   { |h| h.keys.first.to_sym == type.to_sym }
  end
    alias_method :include?, :has?

  def how_many?(type = nil)
    if block_given?
      @var.count &block
    elsif type == nil
      @var.count
    else
      @var.count  { |h| h.keys.first.to_sym == type.to_sym }
    end
  end
    alias_method :count, :how_many?

  def get(type)
    @var.select { |h| h.keys.first.to_sym == type.to_sym }
  end

  def get_all
    @var
  end

  def to_s
    @var.inspect
  end

  def method_missing(m, *args, &block)
    if args.any?
      args = args.first if args.length == 1
      @var << { m.to_sym => args }
      instance_variable_set "@#{m}", args
    else
      instance_variable_get "@#{m}"
    end
  end
end