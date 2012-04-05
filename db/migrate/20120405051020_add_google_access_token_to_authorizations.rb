class AddGoogleAccessTokenToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :google_access_token, :string

  end
end
