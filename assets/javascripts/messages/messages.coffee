class window.Messages
  @update_count: ->
    $("")

  @more: ->
    $(".loading").show()
    Messages.get
      container: Messages.container
      offset: Messages.offset + 500

  @get: (options={}) ->
    @container = $(options["container"])
    @offset = options["offset"] || 0

    $.ajax "/attachments?limit=500&offset=#{Messages.offset}",
      success: (response) ->
        $(".loading").hide()
        messages = JSON.parse(response)["messages"]

        $(messages).each (i, message)->
          files = message["files"]
          if files != undefined
            $(files).each (n, file) ->
              tr = $("<tr></tr>")
              tr.append $("<td>#{file["file_name"]}</td>").addClass("filename")
              tr.append $("<td>#{message["subject"]}</td>").addClass("subject")

              size = file["size"] / 1000

              tr.append $("<td>#{size} KB</td>").addClass("size")
              tr.append $("<td>#{message["date"]}</td>").addClass("date")

              download_link = $("<a>").attr("href", "/download?file_id=#{file['file_id']}&content_type=#{file['type']}")
              download_link.html("Download")

              td = $("<td>")
              td.append($("<i>").addClass("icon-download"))
              td.append(download_link)

              tr.append td.addClass("download")

              Messages.container.append tr
