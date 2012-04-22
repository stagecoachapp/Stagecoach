Paperclip.interpolates :asset_object_type do |attachment, style|
  attachment.instance.asset_object_type # or whatever you've named your User's login/username/etc. attribute
end

Paperclip.interpolates :asset_object_id do |attachment, style|
  attachment.instance.asset_object_id # or whatever you've named your User's login/username/etc. attribute
end

