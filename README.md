# Quarto [![Build status](https://travis-ci.org/Musashi178/quarto_ex.svg?branch=master)](https://travis-ci.org/Musashi178/quarto_ex) [![Coverage Status](https://coveralls.io/repos/github/Musashi178/quarto_ex/badge.svg?branch=master)](https://coveralls.io/github/Musashi178/quarto_ex?branch=master)

# Setup environment

Start a postgres db server

Run the following in the folder apps/quarto_web

mix deps.get
mix ecto.create
mix ecto.migrate

# Running web frontend

Run the following in the folder app/quarto_web
mix phoenix.server

You can the access the web frontend at http://localhost:4000
