# Mega-shop
-------------------

### How to install

Clone repo to your local machine


####With HTTPS:

```
$ git clone https://github.com/rockettron/mega-shop.git
```

####With SSH:

```
$ git clone git@github.com:rockettron/mega-shop.git
```

### Setting

The first one, copy files `init/database.yml` and `init/secrets.yml` to `config/`

```
$ cp init/database.yml config/
$ cp init/secrets.yml config/
```

Change your settings in `config/database.yml'

### Run

``` 
$ bundle install
$ rake db:create
$ rake db:migrate
```
