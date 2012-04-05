class AddGoogleRefreshTokenToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :google_refresh_token, :string

  end
end
