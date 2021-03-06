# extend Backbone.View

class Backbone.HamlView extends Backbone.View
  haml: (view, data) ->
    Utils.haml_plain view, data
    
  elf: (arg) ->
    $(@el).find(arg)
    
  rend: (template, html) ->
    this.elf(template).html(html)
    
  append: (template, html) ->
    this.elf(template).append(html)
  
Backbone.View = Backbone.HamlView


#use console.log safely
unless console
  console = {} 
  console.log = {}
  console.debug = {}
  console.error = {}


# number

Number::format = ->
  $.map(_(this.toString().split("")).reverse(), (d, idx) -> 
    if ((idx%3)==0 && idx!=0) then p = "." else p=""  
    return p+d
  ).join("").split("").reverse().join("")

# arrays

Array::first = ->
  this[0]
  
Array::last = ->
  this[-1]
  
  
String::trim = ->
  # TODO: add trimming at the end of the line
  this.replace(/^\s+/, '') 

# inflections

String::pluralize = -> 
  this+"s"
String::singularize = -> 
  if this[-1] && this[-1].toLowerCase() == "s" then this[0..-2] else this

# casing

String::capitalize = -> 
  "#{this[0].toUpperCase()}#{this[1..-1]}"

# rails csfr token

$.ajaxSetup({
  beforeSend: (xhr) ->
    xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
})


# utils

Utils = {}

Utils.haml = (selector, object) ->
  template = $(selector).html()
  unless template
    console.log "object: ", object
    throw "can't render null haml (selector: #{selector})" 
  haml = Haml template
  throw "rendering nil model with selector: #{selector}" unless object
  haml object.attributes
  
Utils.haml_plain = (selector, object) ->
  template = $(selector).html()
  unless template
    console.log "object: ", object
    throw "can't render null haml (selector: #{selector})" 
  haml = Haml template
  throw "rendering nil model with selector: #{selector}" unless object
  haml object
  
  
# automations to speed up development, comment them in production
  
# setTimeout ->
#   Rankey.main_view.siteView.keysView.edit_keys()
# , 1000