---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_resource-rating
---

# Avaliação de Recurso

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*.
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.
*Traduzido por Beatriz Rezener, [@beatrizrezener](https://github.com/beatrizrezener)*.

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e os tutoriais para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando design](http://guides.railsgirls.com/design), [implantando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).

O que queremos que nosso app faça? Primeiramente, nós gostaríamos de:
* autenticar **usuários**
* permitir usuários autenticados a criar uma nova descrição de **local** turístico
* permitir usuários autenticados a **comentar** esses lugares
* permitir usuários autenticados a **avaliar** até que ponto esses locais são ou não amigáveis ao autismo.

Até então, nós modelamos e implementamos recursos de comentários, usuários e locais. Vamos agora habilitar a avaliação para lugares.

## Avaliando Locais

## Passo 0: Adicionar a gem letsrate

Abra o seu `Gemfile` e adicione a linha:

{% highlight ruby %}
gem "letsrate", :git => "git://github.com/iammyr/letsrate.git"
{% endhighlight %}
e execute
{% highlight sh %}
bundle install
{% endhighlight %}
para instalar a gem. **Além disso, lembre-se de reiniciar o servidor Rails**.

## Passo 1: Configure o letsrate em seu app

Execute o comando a seguir no terminal (estamos assumindo que já habilitamos a autenticação de usuários usando a gem `Devise`).

{% highlight sh %}
rails g letsrate user
{% endhighlight %}

## Step 2: Aplique letsrate a seu recurso

Você deve adicionar a função `letsrate_rateable`, com sua opção de dimensões, ao modelo do recurso que você deseja avaliar, por exemplo, local. Você pode ter múltiplas dimensões.

Em `app/models/place.rb` adicione

{% highlight ruby %}
letsrate_rateable "autismo_amigavel", "geral"
{% endhighlight %}

Então você precisa adicionar uma chamada a `letsrate_rater` no modelo de usuário:

{% highlight ruby %}
letsrate_rater
{% endhighlight %}

## Step 3: Render the Views

Há um método auxiliar chamado `rating_for` para adicionar as estrelas de avaliação. Por padrão, `rating_for` irá mostrar a média das avaliações e aceitará uma nova avaliação de um usuário autenticado.

Abra `app/views/places/show.html.erb` e adicione

{% highlight erb %}
<p>
  <strong>Votos:</strong><br />
  Autismo amigável : <%= rating_for @local, "autismo_amigavel" %> <br />
  Geral : <%= rating_for @local, "geral" %>
</p>
<hr />
<p>
  <strong>Seus votos:</strong><br />
  Autismo amigável : <%= rating_for_user @local, current_user, "autismo_amigavel", :star => 7 %>
  Geral : <%= rating_for_user @local, current_user, "geral", :star => 7 %>
</p>
<hr />
{% endhighlight %}

Você pode usar o método auxiliar `rating_for_user` para mostrar a avaliação de estrelas para o usuário.


É isso aí! ^__^
Experimente reiniciar o servidor, dê um add, commit e push no GitHub. Se tudo estiver funcionando, você também pode implantar ;)

{% include other-guides.md page="touristic-autism_resource-rating" %}
