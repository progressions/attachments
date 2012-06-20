set :haml, :format => :html5

Bundler.require
require 'lib/context'

get "/" do
  limit = params[:limit] || 10000
  @context = Context.new
  @messages = @context.list_messages(:include_body => true, :limit => limit)
  @messages_total = @messages.length

  @attachment_names = @messages.map do |message|
    if message["files"]
      message["files"].map do |file|
        file["file_name"]
      end
    end
  end.flatten.compact

  haml :index
end

get "/download" do
  @context ||= Context.new
  file = @context.get_file(:file_id => params["file_id"])
  file_content = @context.get_file_content(:file_id => params["file_id"])

  attachment file["file_name"]
  file_content
end
