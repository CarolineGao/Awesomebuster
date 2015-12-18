module TestersHelper

  #Returns the Gravatar for the given tester.
  def gravatar_for(tester)
    gravatar_id = Digest::MD5::hexdigest(tester.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: tester.name, class: "gravatar")
  end
end
