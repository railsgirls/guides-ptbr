---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_google-map
---

# Mostrar todos os lugares no Google Maps

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)* *para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.

*Traduzido por [@MADPT](https://github.com/MADPT) aka [Miguel Ângelo](http://www.miguelangelo.io)*.

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).

É necessário instalar um software que nos permita exibir e interagir com o Google Maps.

Abra `Gemfile` no diretório do projeto usando o editor de texto e adicione
```
{% highlight ruby %}
gem 'gmaps4rails'
{% endhighlight %}
```

Bundle como de costume. Em seguida, adicione a um novo arquivo `app/model/marker.rb`:
```
{% highlight sh %}
class Marker

  include ActiveModel::Validations
  include Gmaps4rails::ActsAsGmappable

  acts_as_gmappable :position => :location

  attr_accessor :location

    def gmaps4rails_infowindow
      'foo'
    end

end
{% endhighlight %}
```

Em seguida, adicione ao arquivo `config/application.rb` dentro do bloco do projeto:
```
{% highlight sh %}
config.active_support.escape_html_entities_in_json = true
config.encoding = "utf-8"
config.filter_parameters += [:password]
config.assets.enabled = true
config.assets.version = '1.0'
{% endhighlight %}
```

Crie o arquivo `app/controllers/google_controller.rb`:
```
{% highlight sh %}
class GoogleController < ApplicationController
  def index; end

  def markers
    @marker ||= (1..10).map {
      m = Marker.new
      m.location = [ (Random.new.rand(-5000..5000) / 100.0),(Random.new.rand(-5000..5000) / 100.0) ]
      m
    }.to_gmaps4rails
  end
  helper_method :markers

end
{% endhighlight %}
```


Crie o arquivo `view/google/index.html.erb`:
```
{% highlight sh %}
<h1>See some marker on your map by default</h1>
<div class="google_map"></div>
<%= gmaps("markers" => {"data" => markers},
          'last_map' => false,
          "map_options" =>  {
            "center_on_user" => true,
            "detect_location" => true,
            "provider" => "google", :id => 'google_map'}) %>

<h1>See on OpenLayer</h1>
<div class="openlayer_map"></div>

<%= gmaps("markers" => {"data" => markers},
          "map_options" =>  {
  "center_on_user" => true,
  "detect_location" => true,
  "provider" => "openlayers", :id => 'openlayer_map'}) %>
{% endhighlight %}
```


Adicione o seguinte código no arquivo `app/views/application.html.erb` depois de `"<%= yield %>"`:
```
{% highlight sh %}
<%= yield :scripts %>
{% endhighlight %}
```


Finalmente, adicione o seguinte ao arquivo `config/routes.rb`:
```
{% highlight sh %}
  get '/google' => 'google#index'
  root :to => 'google#index'
{% endhighlight %}
```
