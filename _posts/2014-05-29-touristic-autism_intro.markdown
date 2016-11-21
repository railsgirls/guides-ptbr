---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_intro
---

# Rails Girls Touristic Autism-friendly Spots App Tutorial

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*Traduzido por Luiz Santos, [@santosluiz](https://github.com/santosluiz)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*


Este tutorial mescla, adapta e extende alguns dos guias básicos do RailsGirls **para o cenário de**: descrever, exibir e comentar locais turísticos e avaliá-los com o autismo amigável. Esta aplicação foi solicitada por [Galway Autism Partnership](http://www.galwayautismpartnership.com/) para ajudar autistas adultos em suas viagens.

A extensão é composta de **novas funcionalidades**:

* Tutorial de TDD
* Avaliação de Recurso
* Configuração de permissão para ususuário autenticado (via devise)

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).



### [*0.*Instalação](/install)

**Certifique-se de que você possui o Rails e o Git instalados.** [**Siga o tutorial de instação**](/install), em seguinda [**Instale o Git**](http://www.git-scm.com/book/en/Getting-Started-Installing-Git). Então, configure o GitHub inserindo estes comandos no terminal:

{% highlight sh %}
$ git config --global user.name "Seu Nome"
$ git config --global user.email seu.email@example.com
{% endhighlight %}

<p>Etapas de configuração do GitHub.</p>

Crie uma [conta grátis no GitHub](https://github.com/signup/free), caso você ainda não possua uma.


### [*1.*Aplicação Web Básica](/touristic-autism_basic-app)

### [*2.*Controle de versão com Git](/touristic-autism_git)

### [*3.*Modelagem de Recursos](/touristic-autism_resource-modeling)

### [*4.*Avaliação de Recursos](/touristic-autism_resource-rating)

### [*5.*Design](/touristic-autism_design)

### [*6.*Upload de imagens e Thumbnails](/touristic-autism_image-upload)

**Opcional - para Garotas Rails avançadas:**

### [*7.*Implatanção Contínua](/touristic-autism_continuous-deployment)

### [*8.*Teste e Integração Contínua](/touristic-autism_static-pages-tdd)




## Tutoriais Adicionais

* Guide 0: [Macetes de Ruby, Rails, console etc.](http://www.pragtob.info/rails-beginner-cheatsheet/)
* Guide 1: [Coloque o seu app online com o Heroku, por Terence Lee](/heroku) / [Coloque o seu app online com o OpenShift, por Katie Miller](/openshift) / [Coloque o seu app online com o anynines](/anynines) / [Coloque o seu app online com o Trucker.io](/trucker)
* Guide 2: [Adicionando imagens de perfil com o Gravatar](/gravatar)
* Guide 3: [Leia explicações adiciones do app, por Lucy Bain](https://github.com/lbain/railsgirls)


# Anexo

## Desfazendo Coisas

O Rails possui ferramentas que facilitam bastante a recuperação de erros.

Por exemplo, você pode decidir alterar o nome do controller. Uma vez que, ao gerar o controller, o Rails cria muito mais arquivos que o controller. Desfazer essa operação, significa a remoção de um conjunto de arquivos. No Rails, isso pode ser feito com o 'rails destroy'. Em particular, estes dois comandos cancelam um ao outro:

  $ rails generate controller FooBars baz quux
  $ rails destroy  controller FooBars baz quux

De uma forma análoga, depois geramos um modelo assim:

  $ rails generate model Foo bar:string baz:integer

Isso pode ser desfeito utilinzado:

  $ rails destroy model Foo


As migrações alteram o estado do banco de dados:

  $ rake db:migrate

Podemos desfazer uma única migração utilizando:

  $ rake db:rollback

Para voltar ao início, basta inserir:

  $ rake db:migrate VERSION=0

Como você pode imaginar. As you might guess, substituting any other number for 0 migrates to that version number, where the version numbers come from listing the migrations sequentially.

Para apagar a table do banco de dados, digite:

  $ rails console

Então, basta inserir o comando:

  >> ActiveRecord::Migration.drop_table(:<table-name>)

Você pode acessar o banco de dados diretamente (Caso seja sqlite3, digite ".quit" para sair), utilizando:

  $ rails db

