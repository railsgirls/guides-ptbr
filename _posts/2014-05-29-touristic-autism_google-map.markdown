---
layout: default
title: Touristic Autism-friendly Spots App 
permalink: touristic-autism_google-map
---

# Mostrar todos os lugares em um mapa do Google

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*
Os guias básicos que foram mesclados e adaptados são os [Ruby on Rails Tutorial](http://www.railstutorial.org/book), [basic RailsGirls app](http://guides.railsgirls.com/app/) e os tutoriais são [creating thumbnails](http://guides.railsgirls.com/thumbnails), [authenticating users](http://guides.railsgirls.com/devise/), [adding design](http://guides.railsgirls.com/design), [deploying to OpenShift](http://guides.railsgirls.com/openshift/) e [adding comments](http://guides.railsgirls.com/commenting).

nós precisamos instalar um software para que nos de a permissão de exibir e interagir com o Google Maps.

Abra `Gemfile` na sua pasta do projeto usando seu editor de texto e adicione:

```
gem 'gmaps4rails'
```

Execute o Bundle como de costume. Em seguida adicione um novo arquivo: app/model/marker.rb

```
class Marker

  include ActiveModel::Validations
  include Gmaps4rails::ActsAsGmappable

  acts_as_gmappable :position => :location

  attr_accessor :location

    def gmaps4rails_infowindow
      'foo'
    end

end
```


Em seguida, adicione o config/application.rb dentro do seu escopo do projeto:

```
config.active_support.escape_html_entities_in_json = true
config.encoding = "utf-8"
config.filter_parameters += [:password]
config.assets.enabled = true
config.assets.version = '1.0'
```
Crie seu app/controllers/google_controller.rb:

```
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
```
Crie seu view/google/index.html.erb:


<h1>Veja alguns indicadores defaults no seu mapa</h1>
<div class="google_map"></div>

```
<%= gmaps("markers" => {"data" => markers},
          'last_map' => false,
          "map_options" =>  {
            "center_on_user" => true,
            "detect_location" => true,
            "provider" => "google", :id => 'google_map'}) %>
```

<h1>Veja em camadas abertas</h1>
<div class="openlayer_map"></div>

```
<%= gmaps("markers" => {"data" => markers},
          "map_options" =>  {
  "center_on_user" => true,
  "detect_location" => true,
  "provider" => "openlayers", :id => 'openlayer_map'}) %>
```

Adicione o seguinte no app: app/views/application.html.erb after "<%= yield %>":

```
<%= yield :scripts %>
```

Para finalizar, adicione o seguinte na sua config/routes.rb:

```
get '/google' => 'google#index'
root :to => 'google#index'
```