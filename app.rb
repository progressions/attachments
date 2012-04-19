set :haml, :format => :html5

Bundler.require
require 'lib/context'


get "/" do
  @context ||= Context.new
  @files ||= @context.list_files(:limit => 10)
  haml :index
end

get "/download" do
  @context ||= Context.new
  file = @context.get_file(:file_id => params["file_id"])
  file_content = @context.get_file_content(:file_id => params["file_id"])

  attachment file["file_name"]
  file_content
end
