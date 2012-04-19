set :haml, :format => :html5

Bundler.require
require 'lib/context'

get "/" do
  @context ||= Context.new

  @files ||= @context.list_files(:limit => 10000)
  haml :index
end
