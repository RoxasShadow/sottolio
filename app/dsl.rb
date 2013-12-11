#--
# Copyright(C) 2013 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# This file is part of sottolio.
#
# sottolio is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# sottolio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with sottolio.  If not, see <http://www.gnu.org/licenses/>.
#++
class Script
  include Enumerable
  attr_accessor :var

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

  def first
    @var.first
  end

  def last
    @var.last
  end

  def pop
    @var.pop
  end

  def reverse
    @var.reverse
  end

  def reverse!
    @var.reverse!
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