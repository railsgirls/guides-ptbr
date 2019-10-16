---
layout: default
title: Adicionando back-end com Active Admin
permalink: backend-with-active-admin
---

# Adicionando back-end com Active Admin

_Criado por [Rasmus Kjellberg](https://www.rasmuskjellberg.se)_

**Este guia pressupõe que você já tenha criado um aplicativo Rails Girls** [**seguindo o guia de desenvolvimento**](/app).

O Active Admin é um plugin do Ruby on Rails para gerar interfaces de estilo de administração. Ele abstrai padrões comuns de aplicativos de negócios para simplificar a implementação de interfaces bonitas e elegantes com muito pouco esforço. Você pode ler mais sobre o Active Admin [aqui](http://activeadmin.info/).

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

# (0.3ms) begin transaction

# SQL (0.4ms) INSERT INTO "admin_users" ...

# (0.9ms) commit transaction

{% endhighlight %}

Você pode sair da sessão do console com um simples comando `exit`:
{% highlight sh %}
irb(main):002:0> exit
{% endhighlight %}

## Acessando seu painel de administrador

Visite [http://localhost:3000/admin](http://localhost:3000/admin) e faça login utilizando suas credenciais.

Voila! Você está no seu novo painel de controle do Active Admin.

## Adicione "Ideas" ao back-end

Para registrar seu model `Ideas` com Active Admin, rode:
{% highlight sh %}
$ rails generate active_admin:resource Ideas
{% endhighlight %}
Atualize sua página de admin e você encontrará [Ideas](http://localhost:3000/admin/ideas) na navegação.

_Você pode substituir "Ideas" por qualquer model que você quiser registrar com o Active Admin._

### Configurando Strong Parameters

Para prevenir a exceção **ActiveModel::ForbiddenAttributesError in Admin::IdeasController#update** ao atualizar o model, você tem que utilizar o método [permit_params](http://activeadmin.info/docs/2-resource-customization.html) para definir quais atributos podem ter sido alterados:

Abra seu arquivo `app/admin/ideia.rb` e adicione `:nome`, `:descricao` e `:imagem` ao `permit_params`:
{% highlight ruby %}
ActiveAdmin.register Ideia do
permit_params :nome, :descricao, :imagem
end
{% endhighlight %}

## Remova "new", "edit" e "destroy" para usuários.

Se você não quer que usuários não administradores atualize suas ideias, você pode facilmente consertar isso atualizando seu arquivo de todas para permitir apenas "index" e "show". Adicione `only: [:show, :index]` ao `config/route.rb`:
{% highlight ruby %}
resources :ideias, only: [:show, :index]
{% endhighlight %}

**Não se esqueça de remover os links agora quebrados, do seu código front-end, como:** `<%= link_to 'Nova Ideia', new_ideia_path %>`, `<%= link_to 'Editar', edit_idea_path(ideia) %>`, `<%= link_to 'Excluir', ideia, method: :delete, data: { confirm: 'Você tem certeza?' } %>`

Voila! Você pode agora gerenciar uas ideias do seu novo painel de administrador!

## E agora?

- Adicione outro recurso ao admin como Blog e Comentarios
