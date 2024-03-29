class window.Messages
  @messages_count: 0
  @files_count: 0

  @per_page: 500

  @update_count: ->
    $(".files_count").html(Messages.files_count)
    $(".messages_count").html(Messages.messages_count)
    $(".count").show()

  @more: ->
    $(".loading").show()
    Messages.get
      container: Messages.container
      offset: Messages.offset + Messages.per_page

  @get: (options={}) ->
    @container = $(options["container"])
    @offset = options["offset"] || 0

    $.ajax "/attachments?limit=#{Messages.per_page}&offset=#{Messages.offset}",
      success: (response) ->
        $(".loading").hide()
        messages = JSON.parse(response)["messages"]

        Messages.messages_count += messages.length

        $(messages).each (i, message)->
          files = message["files"]
          if files != undefined
            Messages.files_count += files.length

            $(files).each (n, file) ->
              entry = new Entry(message, file)
              Messages.container.prepend entry.tr()
              Messages.update_count()
