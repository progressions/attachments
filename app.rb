set :haml, :format => :html5

Bundler.require
require 'lib/context'

get "/" do
  @context ||= Context.new

  @files ||= @context.files
  haml :index
end
