# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cancel_button(options=nil)
    if !options
      url=url_for(:action=>'index')
    else
      url=url_for options
    end
    "<input type=\"button\" value=\"Cancel\" onclick=\"document.location='#{url}';\" />"
  end

end
