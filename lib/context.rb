class Context
  attr_accessor :connection

  def initialize(key=nil, secret=nil)
    unless key
      @config = YAML.load_file("./config/contextio.yml")
      key = @config["key"]
      secret = @config["secret"]
    end
    @connection = ContextIO::Connection.new(key, secret)
  end

  def accounts
    @accounts ||= JSON.parse(connection.list_accounts({}).body)
  end

  def account_id
    @account_id ||= accounts.first["id"]
  end

  [
    :list_contacts,
    :get_contact,
    :list_contact_files,
    :list_contact_messages,
    :list_contact_threads,
    :list_files,
    :get_file,
    :get_file_content,
    :get_file_changes,
    :list_file_revisions,
    :list_file_related,
    :list_messages,
    :get_message,
    :get_message_headers,
    :get_message_flags,
    :get_message_body,
    :get_message_thread,
    :list_threads,
    :get_thread,
    :list_account_email_addresses,
    :delete_email_address_from_account,
    :set_primary_email_address_for_account,
    :add_email_address_to_account,
    :modify_source,
    :reset_source_status,
    :list_sources,
    :get_source,
    :add_source,
    :delete_source,
    :sync_source,
    :get_sync,
    :add_folder_to_source,
    :list_source_folders,
    :list_webhooks,
    :get_webhook,
    :add_webhook,
    :delete_webhook
  ].each do |method|
    send(:define_method, method) do |args|
      args ||= {}
      handle_response connection.send(method, {:account => account_id}.merge(args))
    end
  end

  def handle_response(response)
    case response.code
    when '200'
      JSON.parse( response.body )
    when '500'
      raise Exceptions::Response500
    else
      raise "problem with response, code: #{response.code}"
    end
  end
end
