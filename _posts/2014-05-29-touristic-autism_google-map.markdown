---
layout: default
title: Aplicativo de Pontos Turísticos amigável para autistas
permalink: touristic-autism_google-map
---

# Mostrar todo os lugares no Google Map

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*.
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.
*Traduzido por Elaine Martins, [@astronomaelaine](https://twitter.com/astronomaelaine)*.

Os guias básicos que foram mesclados e adaptados são o [Ruby on Rails Tutorial](http://www.railstutorial.org/book), o [RailsGirls app básico](http://guides.railsgirls.com/app/) e os tutoriais para [criar thumbnails (miniaturas)](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando visual](http://guides.railsgirls.com/design), [deploying para OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).


É preciso instalar um software que permite visualizar e interagir com o Google Maps.

Abra `Gemfile` no diretório do projeto utilizando o editor de texto de sua preferência e adicione as linhas

{% highlight ruby %}
gem 'gmaps4rails'
{% endhighlight %}


Agrupe como o de costume. Depois, adicione as linhas abaixo a um novo arquivo `app/model/marker.rb`:

{% highlight ruby %}
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

Depois, adicione a `config/application.rb`, dentro do bloco do seu projeto:

{% highlight ruby %}
config.active_support.escape_html_entities_in_json = true
config.encoding = "utf-8"
config.filter_parameters += [:password]
config.assets.enabled = true
config.assets.version = '1.0'
{% endhighlight %}

Crie o seu `app/controllers/google_controller.rb`:

{% highlight ruby %}
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

Crie o seu `view/google/index.html.erb`:

{% highlight erb %}
<h1>Veja algum marcador no seu mapa por padrao</h1>
<div class="google_map"></div>
<%= gmaps("markers" => {"data" => markers},
          'last_map' => false,
          "map_options" =>  {
            "center_on_user" => true,
            "detect_location" => true,
            "provider" => "google", :id => 'google_map'}) %>

<h1>Veja no OpenLayer</h1>
<div class="openlayer_map"></div>

<%= gmaps("markers" => {"data" => markers},
          "map_options" =>  {
  "center_on_user" => true,
  "detect_location" => true,
  "provider" => "openlayers", :id => 'openlayer_map'}) %>
{% endhighlight %}

Adicione as linhas abaixo em `app/views/application.html.erb` depois de `<%= yield %>`:

{% highlight erb %}
<%= yield :scripts %>
{% endhighlight %}

Para finalizar, adicione as linhas abaixo em `config/routes.rb`:

{% highlight ruby %}
  get '/google' => 'google#index'
  root :to => 'google#index'
{% endhighlight %}

{% include other-guides.md page="touristic-autism_google-map" %}
