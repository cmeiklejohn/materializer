# encoding: UTF-8

require "materializer/version"
require "materializer/base"
require "materializer/core_ext"

module Materializer # :nodoc:
  extend ActiveSupport::Concern 

  included do
    include Materializer::Base
  end
end
