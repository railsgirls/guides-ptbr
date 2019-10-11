---
layout: default
title: App para turismo de autismo amigável 
permalink: touristic-autism_resource-modeling
---

# Modelagem de Recursos

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.
Os guias básicos que foram mergeados e adaptados são [Tutorial de Ruby on Rails](http://www.railstutorial.org/book), o [RailsGirls app básico](http://guides.railsgirls.com/app/) e os tutorias para [criar thumbnails](http://guides.railsgirls.com/thumbnails), [autenticar usuários](http://guides.railsgirls.com/devise/), [adicionar design](http://guides.railsgirls.com/design), [deploy ao OpenShift](http://guides.railsgirls.com/openshift/) e [adicionar comentários](http://guides.railsgirls.com/commenting).
Traduzido por Elaine Mattos, [elainemattos](https://github.com/elainemattos).

O que nós queremos que nossa aplicação faça? Primeiramente, nós gostariamos de
* autenticar **users** (usuários)
* permitir que users autenticados criem uma nova descrição turística do **place** (local)  
* permitir que user autenticados possam **comment** (comentar) nestes locais
* permitir que users autenticados **rate** (classifiquem) os locais que sejam amigáveis ​​ao autismo ou não.

Observe que esses requisitos nos ajudam a identificar quatro recursos diferentes: usuário (users), local (place), comentário (comment), classificação (rate). Agora vamos modelar suas propriedades e suas associações entre si.

Iremos permitir classificações no próximo tutorial.

## Tourists/Users Autenticados

Vamos gerar nosso primeiro recurso: usuários e requerer a sua autenticação.

## Passo 0: Adicionar a gem devise

Abra a sua `Gemfile` e adicione esta linha

{% highlight ruby %}
gem 'devise'
{% endhighlight %}
e rode
{% highlight sh %}
bundle install
{% endhighlight %}

para instalar a gem. **Lembre-se de reiniciar o servidor Rails**.

## Passo 1: Configurar o devise na sua aplicação

Rode o seguinte comando no terminal.

{% highlight sh %}
rails g devise:install
{% endhighlight %}

## Passo 2: Configurar o Devise

Verifique se você definiu opções de URL padrão nos arquivos dos ambientes. Abra `config/environment/development.rb` e adicione esta linha:

{% highlight ruby %}
   config.action_mailer.default_url_options = { :host => 'localhost:3000' }
{% endhighlight %}

antes da palavra `end`.

Abra `app/views/layouts/application.html.erb` e adicione:

{% highlight erb %}
<% if notice %>
  <p class="alert alert-success"><%= notice %></p>
<% end %>
<% if alert %>
  <p class="alert alert-danger"><%= alert %></p>
<% end %>
{% endhighlight %}

logo acima de
{% highlight ruby %}
   <%= yield %>
{% endhighlight %}

## Passo 3: Configurar User model

Usaremos um script de geração de código para criar a User model.

{% highlight sh %}
   rails g devise user
   rake db:migrate
{% endhighlight %}

**Instrutor(a):** Explique qual user model foi gerada. O que são os campos? Observe que a model herda habilidades para interagir com o BD através do `ActiveRecord::Base` super-class (ref. MVC).

## Passo 4: Crie seu primeiro usuário

Agora que você configurou tudo já pode criar seu primeiro user. Devise criará todo o código e rotas necessárias para criação de contas, log in, log out, etc.

Certifique-se de que seu servidor rails está rodando, abra [http://localhost:3000/users/sign_up](http://localhost:3000/users/sign_up) e crie a sua conta de user (usuário). 

## Passo 5: Adicione links de sign-up e login

Tudo que precisamos fazer agora é adicionar os links apropriados e notificar sobre o user estar logado no topo direito da barra de navegação.

Para fazer isso, edite `app/views/layouts/application.html.erb` adicionando no começo do body:

{% highlight erb %}
<p class="navbar-text pull-right">
<% if user_signed_in? %>
  Logado como <strong><%= current_user.email %></strong>.
  <%= link_to 'Edit profile', edit_user_registration_path, :class => 'navbar-link' %> |
  <%= link_to "Logout", destroy_user_session_path, method: :delete, :class => 'navbar-link'  %>
<% else %>
  <%= link_to "Sign up", new_user_registration_path, :class => 'navbar-link'  %> |
  <%= link_to "Login", new_user_session_path, :class => 'navbar-link'  %>
<% end %></p>
{% endhighlight %}

Finalmente, force o user para redirecionar para a página de login se o usuário não estiver logado. Abra `app/controllers/application_controller.rb` e adicione:

{% highlight ruby %}
  before_action :authenticate_user!
{% endhighlight %}

após `protect_from_forgery with: :exception`.

Abra seu navegador e tente logar e deslogar.

**Instrutor(a):** Fale sobre os helpers `user_signed_in?` e `current_user`. Por que eles são úteis?

Vamos add-commit-push para o seu repositório no Github! Veja que todas as alterações agora estão no seu perfil no Github? :) 

## Locais Turísticos

Agora vamos usar a funcionalidade de scaffold do Rails para gerar e configurar tudo que é necessário para listar, adicionar, remover, editar e visualizar nosso segundo recurso: "locais turísticos".

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
rails generate scaffold place name:string address:string latitude:decimal longitude:decimal description:text picture:string user_id:integer
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
rails generate scaffold place name:string address:string latitude:decimal longitude:decimal description:text picture:string user_id:integer
{% endhighlight %}
  </div>
</div>

Observe que a coluna `user:references` que é criada para suportar a associação 1-para-muitos com usuários.

O scaffold cria novos arquivos diretório do seu projeto. No entanto, nós definimos uma "estrutura" (modelada) para o nosso recurso "place" e queremos que todas as instâncias futuras desse recurso atinjam essa estrutura e sejam armazenadas em algum lugar, ou seja, em um banco de dados. 
Nós já estamos usando um banco de dados (veja `gem 'sqlite'` na sua Gemfile). Vamos adicionar a estrutura de "place" como uma tabela para nosso banco de dados com o seguinte.

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
bin/rake db:migrate
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
ruby bin/rake db:migrate
{% endhighlight %}
  </div>
</div>

Então inicie o servidor novamente. Abra [http://localhost:3000/places](http://localhost:3000/places) no seu navegador e veja todas as novas funcionalidades que a nossa aplicação web está agora suportando o recurso de "places". Tudo graças ao que o Ruby on Rails automaticamente gera com `generate scaffold`.
Cada nova instância de "place" que será salva no banco de dados, irá automaticamente atribuir um identificador único chamado "chave primária", sem a necessidade de especificá-lo como um dos campos (junto com imagem, nome etc.)  
  

**Instrutor(a):** O que é o scaffolding do Rails? O que são as migrations e por que você precisa delas? 
Observe as páginas que foram criadas para manipular o recurso de "place" e suas convenções de nomeclatura.
Olhe os logs do servidor e explique-o como um relatório das seguintes interações (no contexto do padrão MVC): 
* o navegador emite uma solicitação para o URL /places.
* Rails roteia /places para o ação de index em Places controller.
* A ação de index requisita a model Place para receber todos os places (Place.all).
* A model Place extraí todos os places do banco de dados.
* A model Place retorna a lista de places para a controlller.
* A controller captura os users na variável `@users`, na qual é passada para a index view.
* A view utiliza o Ruby incorporado para renderizar a página como HTML.
* A controller passa o HTML para o navegador.

Observe que a controller criada é RESTful (explique)

Note que a controller herda habilidades (grande número de funcionalidade, como a possibilidade de manipular model objects, filtrar requisições HTTP, e renderizar views como HTML) oriunda da `ApplicationController` super-class (ref. MVC).

Abra `app/views/places/show.html.erb` e remova a linha que diz:

{% highlight erb %}
<p id="notice"><%= notice %></p>
{% endhighlight %}

Essa linha não é necessária pois nós já colocamos o aviso de user no arquivo `app/views/layouts/application.html.erb`.

Vamos add-commit-push para o repositório do Github!

### Associações de Recursos

Observe que places ainda não estão associados corretamente aos users. Por exemplo, ao criar um novo place, o campo "User" deverá ser preenchido por nós mesmos e, ao visualizar um perfil de user, não haverá lista de places criados por ele e vice-versa. Além disso, ao excluir uma conta de user, todos os places que ele criou não são excluídos automaticamente.

Vamos apropriadamente criar a associação 1-para-muitos entre User e Places. 

#### Passo 1. Adicionar Associação 1-para-muitos  

Você precisa ter certeza que o Rails sabe a relação entre o recurso de User e Place.
Como um user pode criar muitos places, precisamos ter certeza de que a user model sabe disso. 
Abra `app/models/user.rb` e depois da linha

{% highlight ruby %}
class User < ActiveRecord::Base
{% endhighlight %}
Adicione

{% highlight ruby %}
has_many :places
{% endhighlight %}

O place também tem que saber que ela pertence a um user. Então, abra `app/models/place.rb` e depois 

{% highlight ruby %}
class Place < ActiveRecord::Base
{% endhighlight %}
adicione a linha

{% highlight ruby %}
belongs_to :user
{% endhighlight %}

#### Passo 2: Renderizar as views

Abra `app/views/places/_form.html` e depois

{% highlight erb %}
<div class="field">
  <%= f.label :user_id %><br>
  <%= f.number_field :user_id %>
</div>
{% endhighlight %}

adicione a linha

{% highlight erb %}
<%= f.hidden_field :user_id, :value => current_user.id %>
{% endhighlight %}

agora, remova

{% highlight erb %}
<div class="field">
  <%= f.label :user_id %><br>
  <%= f.number_field :user_id %>
</div>
{% endhighlight %}

## Passo 3: Coloque permissões para editar/deletar 

Permita que apenas o criador de place possa editar/deletar um place.

Abra `app/views/places/index.html.erb` e substitua

{% highlight sh %}
<td><%= link_to 'Edit', edit_place_path(place) %></td>
		<td><%= link_to 'Destroy', place, method: :delete, data: { confirm: 'Tem certeza?' } %></td>
{% endhighlight %}

por

{% highlight sh %}
 <% if user_signed_in? %>
	  <% if current_user.id == place.user_id %>
		  <td><%= link_to 'Edit', edit_place_path(place) %></td>
		  <td><%= link_to 'Destroy', place, method: :delete, data: { confirm: 'Tem certeza?' } %></td>
	  <% end %>
	<% end %>
{% endhighlight %}

É isso aí. Agora veja um user que você inseriu na sua aplicação e você deverá ver o formulário para criar um place e excluir places mais antigos.

## Comentários de Place

Assim como nós criamos um recurso "place" e os associamos com users, nós podemos criar um recurso de "comment" e associá-lo com places e seu autor.

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
rails generate scaffold comment body:text user_id:integer place_id:integer
bin/rake db:migrate
{% endhighlight %}
  </div>
Inicie o servidor, veja o novo serviço no seu navegador. E então, add-commit-push para o github.
</div>

**Instrutor(a):** mostre que o scaffold atualizou os arquivos de rotas do Rails com uma regra para o recurso de Review 

##Associação de Recursos

#### Passo 1. Adicione Associação de 1-para-muitos

Abra `app/models/place.rb` e depois da linha

{% highlight ruby %}
belongs_to :user
{% endhighlight %}
adicione

{% highlight ruby %}
has_many :comments
{% endhighlight %}

Abra `app/models/comment.rb` e após

{% highlight ruby %}
class Comment < ActiveRecord::Base
{% endhighlight %}

adicione a linha

{% highlight ruby %}
belongs_to :user
belongs_to :place
{% endhighlight %}

#### Passo 2: Renderize as views

Abra `app/views/comments/_form.html` e substitua

{% highlight erb %}
<div class="field">
  <%= f.label :user_id %><br>
  <%= f.number_field :user_id %>
</div>
{% endhighlight %}

com a linha

{% highlight erb %}
<%= f.hidden_field :user_id, :value => current_user.id %>
{% endhighlight %}

então, substitua
{% highlight erb %}
  <div class="field">
    <%= f.label :place_id %><br>
    <%= f.number_field :place_id %>
  </div>
{% endhighlight %}

com a linha

{% highlight erb %}
<%= f.hidden_field :place_id%>
{% endhighlight %}

Abra `app/views/places/show.html.erb` e antes últimos links adicione

{% highlight erb %}
<h3>Comentários</h3>

<% @comments.each do |comment| %>
  <div>
    <strong><%= comment.user_id %></strong>
    <br />
    <p><%= comment.body %></p>
    <p><%= link_to 'Delete', comment_path(comment), method: :delete, data: { confirm: 'Tem certeza?' } %></p>    
  </div>
<% end %>
<%= render 'comments/form' %>
{% endhighlight %}

Em `app/controllers/places_controller.rb` adicione para ter a ação de mostrar após a linha
{% highlight ruby %}
@place = Place.find(params[:id])
{% endhighlight %}

este

{% highlight ruby %}
@comments = @place.comments.all
@comment = @place.comments.build
{% endhighlight %}

## Passo 3: Colocar Permissões para editar/deletar

Permita que apenas o criador do comment (comentário) possa editar/deletar um comentário.

Abra `app/views/places/show.html.erb` e substitua

{% highlight sh %}
<p><%= link_to 'Delete', comment_path(comment), method: :delete, data: { confirm: 'Tem certeza?' } %></p>
{% endhighlight %}

com

{% highlight sh %}
 <% if user_signed_in? %>
	  <% if current_user.id == comment.user_id %>
      <p><%= link_to 'Delete', comment_path(comment), method: :delete, data: { confirm: 'Tem certeza?' } %></p>
    <% end %>
	<% end %>
{% endhighlight %}

## Recurso de Validação de Campos

No momento, commets, places e users são caracterizados por informações que nunca são validadas por sua retificação. Ainda assim, por exemplo, deve haver um limite na tamanho dos comments no review ou no formato do endereço de e-mail de um usuário.

Então vamos adicionar uma restrição sobre o tamanho do corpo do campo de comentário (vamos usar a palavra 'validates')

Abra `app/models/comment.rb` e entre 'class' e 'end':

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
  validates :body, length: { maximum: 140 }
{% endhighlight %}
  </div>
Se nós agora tentarmos enviar mais de 140 caracteres, teremos um erro (veja só! ;) ) 
</div>

## Ajuste as rotas

Se você tentar abrir [http://localhost:3000](http://localhost:3000) ainda mostrará a página "Bem-vindo a bordo". Vamos fazer ela redirecionar para a página de places.

Abra `config/routes.rb` e após a primeira linha adicione

{% highlight ruby %}
root :to => redirect('/places')
{% endhighlight %}

Teste a alteração abrindo o caminho raiz (que é, http://localhost:3000/) no seu navegador.

**Instrutor(a):** Fale sobre as rotas, e inclua detalhes sobre as rotas e sua relação com arquivos estáticos.
**Usuários do Rails 3:** Você precisará deletar o index.html da pasta `/public/` para que funcione corretamente.
