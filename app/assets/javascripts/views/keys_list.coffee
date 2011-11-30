class KeysListView extends Backbone.View

  el: ".keysListView"
  
  initialize: (opts) ->
    @collection = opts["collection"]
    @collection.bind("reset", this.render, this)
    
    @new_keys = []
    @last_list = 0
    
  render: ->
    content = Utils.haml "#keysListView", {}
    $(@el).html content
    @rows = []
    for key in @collection.models
      row = new KeyRow(model: key)
      @rows.push row 
      content = row.render().el
    
      $(content).addClass "odd" if @odd
      @odd = !@odd
      this.$(".keysList").append content    
      
    $(@el).find(".btn.edit").bind "click", => this.edit_keys()  
  
  update_keys: ->
    # console.log @new_keys
    this.elf(".spinner_img").animate({opacity: 1}, 1000)
    data = { keys: JSON.stringify @new_keys }
    req = $.ajax { url: "/sites/#{@site_id}/keys_src.json", type: "put", data: data }
    req.done (data) =>
      console.log data
      this.elf(".spinner_img").animate({opacity: 0}, 500)   
      
  
  edit_keys: ->  
    $(@el).find(".btn.edit").unbind("click")
    model = @collection.models.first()
    # @site_id = model.attributes.site_id
    id_from_path = _(location.pathname.split(/\//)).last()
    @site_id = id_from_path
    if model
      $.get "/sites/#{@site_id}/keys_src.json", (data) =>
        this.got_keys data
    else
      this.got_keys []
    
      
  got_keys: (keys) ->    
    template = "#keys_src"
    html = this.haml "#keys_srcView", {}
    this.rend template, html
    this.elf(".btn.add").bind "click", => this.update_keys()
      
    this.add_list()
    
    this.add_existing_keys keys
      
    input = this.elf("input[name='keys_site[]']")
    input.focus()
    input.on "keypress", (evt) =>
      this.on_enter evt
      
  add_existing_keys: (kkeys) ->
    _(kkeys).each (keys) =>
      last_list = this.elf(".keys_list:last").data("list")
      if _(keys).isArray()
        _(keys).each (key) =>
          this.elf("input:last[name='keys_site[]']").val(key)
          this.add_keyword last_list
          # console.log key
      else
        # console.log keys
        this.elf("input:last[name='keys_site[]']").val(keys)
        this.add_keyword last_list

      this.add_list(last_list)

    this.save_keys()
      
  on_enter: (evt) ->
    return  unless evt.keyCode == 13 # enter
    input = $(evt.target)
    last_key = this.elf(".keys_list[data-list=#{@last_list}] .keys").length
    this_list = input.parent().parent().data("list")
    last_input = this.elf(".keys_list[data-list=#{this_list}] input:last").val()
    this.add_keyword this_list unless last_input == ""
    
    this.elf(".keys_lists input:first")
    empty_fields = _($(".keys_lists input:first-child")).filter (el) -> 
      $(el).val() == ""
    unless empty_fields.length > 0
      this.add_list(this_list)
      
    this.save_keys()
    
    input = this.elf("input[name='keys_site[]']")
    input.off "keypress"
    input.on "keypress", (evt) =>
      this.on_enter evt
    
  add_list: (prev_list) ->
    html = this.haml "#keyslist_srcView", { list: @last_list }
    this.append ".keys_lists", html
    if $(".keys_list[data-list=#{@last_list}] input").size() == 0
      this.add_keyword @last_list, 0
    @last_list = $(".keys_list").size()
    if $(".keys_list[data-list=#{@last_list}] input").size() == 0
      this.add_keyword @last_list, 0
  
  add_keyword: (level, site) ->  
    html = this.haml "#key_srcView", { klass: "key_src_#{level}_#{site}", site: site, level: level }
    # console.log "adding: ", level
    this.append ".keys_list[data-list=#{level}] .keys", html
    
  # save and preview 
  
  save_keys: ->  
    @new_keys = []
    this.elf(".keys_list").each (idx, el) =>
      keys = _($(el).find("input[value!='']")).map (el) =>
        $(el).val()
      @new_keys.push keys unless keys.length == 0

    this.update_preview()

  update_preview: ->    
    data = { keys: JSON.stringify @new_keys }
    req = $.ajax { url: "/keys.json", type: "post", data: data }
    req.done (keys) =>
      array = _(keys).map (key) -> 
        if _.isArray(key) then key.join(", ") else key
            
      this.elf(".combinations").html array.join(", ")
      this.elf(".keys_num").html array.length
