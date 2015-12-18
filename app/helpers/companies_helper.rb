module CompaniesHelper

  #Returns the Gravatar for the given company.
  def gravatar_for_company(company)
    gravatar_id = Digest::MD5::hexdigest(company.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: company.company_name, class: "gravatar")
  end
end
