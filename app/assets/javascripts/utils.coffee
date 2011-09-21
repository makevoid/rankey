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


# utils

Utils = {}

Utils.haml = (selector, object) ->
  template = $(selector).html()
  unless template
    console.log "object: ", object
    throw "can't render null haml (selector: #{selector})" 
  haml = Haml template
  # console.log "haml: ", haml
  # console.log "selector: ", selector
  # console.log "rendering: ", object.attributes
  throw "rendering nil model with selector: #{selector}" unless object
  haml object.attributes