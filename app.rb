Bundler.require
require 'lib/context'

get "/" do
  limit = params[:limit] || 10000
  @context = Context.new
  @messages = @context.list_messages(:include_body => true, :limit => limit)
  @messages_total = @messages.length

  @attachments = @messages.map do |message|
    if message["files"]
      message["files"].map do |file|
        file["file_name"]
      end
    end
  end.flatten.compact

  haml :index
end

get "/files" do
  limit = params[:limit] || 10000
  @context = Context.new
  @files = @context.list_files(:include_body => true, :limit => limit)

  @grouped_files = {}

  @files.each do |file|
    file_name = file["file_name"]

    group = @grouped_files[file_name] || []

    group << file
    @grouped_files[file_name] = group
  end

  @filenames = @files.map do |file|
    file["file_name"]
  end.compact.flatten.uniq

  haml :files
end

get "/download" do
  @context ||= Context.new
  file = @context.get_file(:file_id => params["file_id"])
  file_content = @context.get_file_content(:file_id => params["file_id"])

  attachment file["file_name"]
  file_content
end
