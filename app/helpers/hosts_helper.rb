module HostsHelper
	def gravata_for (host, option = {:size => 50 })
		gravatar_image_tag(host.email.downcase, :alt => host.first_name, 
												:alt => host.last_name,
												:class => 'gravatar',
												:gravatar => obtions )
											end

end
