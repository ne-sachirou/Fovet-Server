Fovet server
==
"Fovet" is "supports" in Latin, and is "Onomatopoeia" in [Arka](http://www51.atpages.jp/kakx/arka/e_index.html).

Dev Setup
--
```sh
apt install libjpeg-dev
git clone git@github.com:ne-sachirou/Fovet-Server.git && cd Fovet-Server
bundle install
RAILS_ENV=development rake db:migrate
export JWT_SECRET='YOUR FAVORITE SECRET'
rails s
```

Test
--
```sh
RAILS_ENV=test rake db:migrate
rake test
```
