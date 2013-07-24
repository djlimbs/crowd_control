User.create(email: 'admin@admin.com', password: 'hophippo', password_confirmation: 'hophippo', name: 'admin', is_admin: true)

# Setup Michael Jackson
Artist.create(name: 'Michael Jackson')
AltName.create(alt_name: 'MJ', diff_nameable: Artist.find_by(name: 'Michael Jackson')