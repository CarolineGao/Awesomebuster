module ApplicationHelper

  #Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Work for Curiosity"
    if page_title.empty?
      base_title
    else
      page_title
    end
  end
end

module ApplicationHelper
  # this method will embed the code from the partial
  def youtube_video(url)
    render :partial => 'shared/video', :locals => { :url => url }
  end
end
