---
layout: default
title: Adicionando back-end com Active Admin
permalink: backend-with-active-admin
---

# Adding a back-end with Active Admin

*Created by [Rasmus Kjellberg](https://www.rasmuskjellberg.se)*

**This guide assumes that you have already built a Rails Girls app by** [**following the app development guide**](/app).

Active Admin is a Ruby on Rails plugin for generating administration style interfaces. It abstracts common business application patterns to make it simple for developers to implement beautiful and elegant interfaces with very little effort. You can read more about Active Admin [here](http://activeadmin.info/).

## Adicionando a gem "Active Admin"
Abra seu `Gemfile` e adicione as seguintes linhas

{% highlight ruby %}
gem 'devise'
gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
{% endhighlight %}
e rode
{% highlight sh %}
$ bundle install
{% endhighlight %}
para instalar as gems.

Depois de atualizar sem bundle, rode o instalador
{% highlight sh %}
$ rails generate active_admin:install
{% endhighlight %}

O instalador cria um inicializador utilizado para configurar os padrões utilizados pelo Active Admin e uma nova pasta em `app/admin` para colocar todas as suas configrações de administrador.

Migre seu banco e inicie o servidor:
{% highlight sh %}
$ rake db:migrate
$ rails server
{% endhighlight %}

## Criando sua primeira conta de administrador
Abra o Rails console e crie seu novo usuário utilizando o model `AdminUser`:
{% highlight sh %}
$ rails console
irb(main):001:0> AdminUser.create(:email => 'admin@railsgirls.com', :password => 'password123', :password_confirmation => 'password123')
{% endhighlight %}

Você deverá ver alguma coisa como:
{% highlight sh %}
# (0.3ms)  begin transaction
# SQL (0.4ms)  INSERT INTO "admin_users" ...
# (0.9ms)  commit transaction
{% endhighlight %}

Você pode sair da sessão do console com um simples comando `exit`:
{% highlight sh %}
irb(main):002:0> exit
{% endhighlight %}

## Acessando seu painel de administrador
Visite [http://localhost:3000/admin](http://localhost:3000/admin) e faça login utilizando suas credenciais.

Voila! Você está no seu novo painel de controle do Active Admin.

## Adicione "Ideas" ao back-end
Para registrar seu model `Ideia` com Active Admin, rode:
{% highlight sh %}
$ rails generate active_admin:resource Ideia
{% endhighlight %}
Atualize sua página de admin e você encontrará [Ideias](http://localhost:3000/admin/ideias) na navegação.

*Você pode substituir "Ideia" por qualquer model que você quiser registrar com o Active Admin.*

### Setting up Strong Parameters
Para prevenir a exceção **ActiveModel::ForbiddenAttributesError in Admin::IdeasController#update** ao atualizar o mode, você tem que utilizar o método [permit_params](http://activeadmin.info/docs/2-resource-customization.html) para definir quais atributos podem ter sido alterados:

Abra seu arquivo `app/admin/ideia.rb` e adicione `:nome`, `:descricao` e `:imagem` ao `permit_params`:
{% highlight ruby %}
ActiveAdmin.register Ideia do
  permit_params :nome, :descricao, :imagem
end
{% endhighlight %}

## Remova "new", "edit" e "destroy" para usuários.
Se você não quer que usuários não administradores atualize suas ideias, você pode facilmente consertar isso atualizando seu arquivo de todas para permidir apenas "index" e "show". Adicione `only: [:show, :index]` ao `config/route.rb`:
{% highlight ruby %}
resources :ideias, only: [:show, :index]
{% endhighlight %}

**Não se esqueça de remover os links agora quebrados, do seu código front-end, como:** `<%= link_to 'Nova Ideia', new_ideia_path %>`, `<%= link_to 'Editar', edit_idea_path(ideia) %>`, `<%= link_to 'Excluir', ideia, method: :delete, data: { confirm: 'Você tem certeza?' } %>`

Voila! Você pode agora gerenciar uas ideias do seu novo painel de administrador!

## E agora?

* Adicione outro recurso ao admin como Blog e Comentarios
