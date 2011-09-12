module ViewsHelper
  def body_class
    path = request.path.split("/")[1..2]
    path = path.join(" ") unless path.nil?
    request.path == "/" ? "home" : path
  end
end