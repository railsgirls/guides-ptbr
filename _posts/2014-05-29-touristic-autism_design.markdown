---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_design
---

# Design

_Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)_
_para o projeto [Rails Girls Galway](https://github.com/RailsGirlsGalway)_

_Traduzido por Thaís Falbo, [@thaisfalbo](https://github.com/thaisfalbo)_

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).

**Instrutor(a):** Falar sobre a relação entre HTML e Rails. Qual parte dos views é HTML e qual é Embedded Ruby (ERB)? O que é MVC e como se relaciona com isso? (Models e controllers são responsáveis em gerar os views em HTML.)

O App ainda não está com uma aparência boa. Vamos fazer algo sobre isso. Nós usaremos o projeto Twitter Bootstrap para nos fornecer um estilo melhor com muita facilidade.

Abra o arquivo `app/views/layouts/application.html.erb` no seu editor de texto e acima desta linha

{% highlight erb %}
<%= stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true %>
{% endhighlight %}

adicione

{% highlight erb %}
<link rel="stylesheet" href="//railsgirls.com/assets/bootstrap.css" />
<link rel="stylesheet" href="//railsgirls.com/assets/bootstrap-theme.css" />
{% endhighlight %}

e substitua

{% highlight erb %}
<%= yield %>
{% endhighlight %}

com

{% highlight erb %}
<div class="container">
  <%= yield %>
</div>
{% endhighlight %}

Vamos também adicionar uma barra de navegação e um rodapé (footer) no layout. No mesmo arquivo, acima de `<div class="container">` adicione

{% highlight html %}
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Habilitar navegação</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">App de lugares</a>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="/places">Lugares</a></li>
      </ul>
    </div>
  </div>
</nav>
{% endhighlight %}

e antes do `</body>` adicione

{% highlight html %}
<footer>
  <div class="container">
    Rails Girls Galway 2014
  </div>
</footer>
<script src="//railsgirls.com/assets/bootstrap.js"></script>
{% endhighlight %}

Agora vamos também mudar os estilos da tabela de lugares. Abra o arquivo `app/assets/stylesheets/application.css` e no final adicione

{% highlight css %}
body { padding-top: 100px; }
footer { margin-top: 100px; }
table, td, th { vertical-align: middle; border: none; }
th { border-bottom: 1px solid #DDD; }
{% endhighlight %}

Verifique agora que você salvou seus arquivos e atualize o navegador para verificar o que mudou. Você também pode modificar o HTML e o CSS ainda mais.

Caso seu Terminal mostre uma mensagem de erro que _mais ou menos_ insinua que há algo de errado com seu JavaScript ou CoffeeScript, instale o [nodejs](http://nodejs.org/download/). Este problema não irá aparecer se você utilizou o RailsInstaller (mas quando você instalou Rails através do `gem install rails`)

**Instrutor(a):** Fale um pouco sobre CSS e layouts.

1.Estilize seu header

- coloque o seguinte código no final do `app/assets/stylesheets/application.css`:

  ```css
    .navbar {
      min-height: 38px;
      background-color: #f55e55;
    }
  ```

  Agora atualize a página e confira as mudanças. Você pode tentar mudar a cor ou a fonte do header. Você pode verificar a referência de cores do [http://color.uisdc.com/](http://color.uisdc.com/).

  **Instrutor(a):** fale sobre a propriedade `display`, elementos inline e block.

- Em seguida, coloque estas linhas no final:

  ```css
    .navbar a.brand { font-size: 18px; }
    .navbar a.brand:hover {
      color: #fff;
      background-color: transparent;
      text-decoration: none;
    }
  ```

  **Instrutor(a):** explique os 4 estados de um link

2.Eslitize sua tabela

- Simplesmente usaremos o Twitter [Bootstrap](http://getbootstrap.com/) para aperfeiçoar nossa tabela, ache esta linha do `app/views/places/index.html.erb` e substitua:

  ```html
  <table>
  ```

  com

  ```html
  <table class="table">
  ```

- Modifique o tamanho da imagem utilizando as seguintes linhas

  ```erb
  <%= image_tag(idea.picture_url, :width => 600) if idea.picture.present? %>
  ```

  tente mudar a largura (width) e veja o que vai acontecer

* adicione as seguintes linhas no final do arquivo `app/assets/stylesheets/places.css.scss`:

  ```css
    .container a:hover {
      color: #f55e55;
      text-decoration: none;
      background-color: rgba(255, 255, 255, 0);
    }
  ```

- tente adicionar algum estilo de fundo com a propriedade `background-image`, use como referência o [http://subtlepatterns.com/](http://subtlepatterns.com/) para algumas texturas.

3.Adicione estilo no footer

- adicione estas linhas no final do `app/assets/stylesheets/application.css`

  ```css
    footer {
      background-color: #ebebeb;
      padding: 30px 0;
    }
  ```

  tente colocar mais coisas no `footer` e ajuste sua posição

4.Adicione estilo no botão

  - Abra [http://localhost:3000/places/new](http://localhost:3000/places/new) e procure o botão `Criar Lugar` .

  adicione estas linhas no `app/assets/stylesheets/places.css.scss`

  ```css
  .container input[type="submit"] {
    height: 30px;
    font-size: 13px;
    background-color: #f55e55;
    border: none;
    color: #fff;
  }
  ```

  **Instrutor(a):** explicar como usar `border` em css, tente modificar o estilo do botão como arredondar cantos, adicionar sombra ou cor, etc.

Abra `app/views/layouts/application.html.erb` no seu editor de texto e substitua a linha

{% highlight html %}
<link rel="stylesheet" href="http://railsgirls.com/assets/bootstrap.css">
{% endhighlight %}

com

{% highlight html %}
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap.min.css">
{% endhighlight %}

Abra `app/assets/stylesheets/application.css`, substitua a linha

{% highlight css %}
body { padding-top: 100px; }
{% endhighlight %}

com

{% highlight css %}
body { padding-top: 60px; }
{% endhighlight %}

Por último, remova o arquivo `app/assets/stylesheets/scaffolds.css.scss` por que realmente não precisaremos dos estilos padrões gerados pelo Rails

Agora, atualize a página no [http://localhost:3000/places](http://localhost:3000/places). Você não encontrará muita mudança porém é uma boa preparação para as próximas etapas.

Considerando que "lugar" é um dos objetos mais importantes do seu app, nós colocaremos o botão "Novo Lugar" na barra de navegação para deixar sempre disponível.

Abra `app/views/layouts/application.html.erb`, abaixo da linha

{% highlight erb %}
<li class="active"><a href="/places">Places</a></li>
{% endhighlight %}

adicione

{% highlight erb %}
<li ><%= link_to 'New Place', new_place_path %></li>
{% endhighlight %}

Agora é hora de fazer a página de listar lugares parecer profissional. Para isso, vamos substituir o layout da tabela com layout de div.

**Instrutor(a):** Fale um pouco sobre table vs div.

Abra `app/views/places/index.html.erb` no seu editor de texto e substitua a table com

{% highlight erb %}
<% @places.in_groups_of(3) do |group| %>
  <div class="row">
    <% group.compact.each do |place| %>
      <div class="span4">
        <%= image_tag(place.picture_url, :width => '20%') if place.picture.present? %>
        <h4><%= link_to place.name, place %></h4>
        <%= place.description %>

        <%= place.address %>
        <%= place.latitude %>
        <%= place.longitude %>

        <%= place.user_id %>
        <%= link_to 'Mostrar', place %> |

        <% if user_signed_in? %>
          <% if current_user.id == place.user_id %>
            <%= link_to 'Editar', edit_place_path(place) %> |
            <%= link_to 'Destruir', place, method: :delete, data: { confirm: 'Você tem certeza?' } %>
          <% end %>
        <% end %>

      </div>
    <% end %>
  </div>
<% end %>
{% endhighlight %}

**Instrutor(a):** Explica o que o novo código faz linha por linha, e fale um pouco sobre o grids layout do Bootstrap 12.

Atualize! Nós temos uma lista de ideias bonita. Clique no botão "Nova Ideia" e cria mais ideias com texto reais imagens bonitas - a página vai parecer muito melhor com conteúdo. Existe um princípo de web design contemporâne: conteúdo é a melhor decoração.

Clique no título do lugar e você será direcionado para a página de detalhes do lugar. Agora ainda é um scaffold gerado pelo Rails, portanto vamos fazer isso melhor.

Abra `app/views/places/show.html.erb` no seu editor de texto e substitua todas as linhas com

{% highlight erb %}
<h3>Lugares criados</h3>

<div class="row">
  <div class="span9">
    <%= image_tag(@place.picture_url, :width => "100%") if @place.picture.present? %>
  </div>

  <div class="span3">
    <p><b>Nome: </b><%= @place.name %></p>

    <p><b>Avaliação usuário como autismo amigável: </b><%= rating_for @place, "autismo_amigavel" %></p>
    <p><b>Avaliação geral do usuário: </b><%= rating_for @place, "geral" %></p>
    <p>Seu <b>Voto como autismo amigável: </b><%= rating_for_user @place, current_user, "autismo_amigavel", :star => 7 %></p>
    <p>Seu <b>Voto total: </b><%= rating_for_user @place, current_user, "autismo_amigavel", :star => 7 %></p>

    <p><b>Descrição: </b><%= @place.description %></p>
    <p><b>Endereço: </b><%= @place.address %></p>
    <p><b>Latitude: </b><%= @place.latitude %></p>
    <p><b>Longitude: </b><%= @place.longitude %></p>
    <p><b>ID do criador: </b><%= @place.user_id %></p>

    <p>
      <%= link_to 'Editar lugar', edit_place_path(@place) %> | <%= link_to 'Voltar', places_path %>
    </p>
  </div>
</div>

<h3>Commentários</h3>
<% @comments.each do |comment| %>
  <div>
    <strong><%= comment.user_id %></strong>
    <br />
    <p><%= comment.body %></p>

    <% if user_signed_in? %>
      <% if current_user.id == comment.user_id %>
        <p><%= link_to 'Delete', comment_path(comment), method: :delete, data: { confirm: 'Você tem certeza?' } %></p>
      <% end %>
    <% end %>
  </div>
<% end %>

<%= render 'comments/form' %>
{% endhighlight %}

Continue experimentando com mudanças de Design! ;)
