---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_intro
---

# Rails Girls Tutorial de uma aplicação turística para Autistas

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*.
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.
*Traduzido por Luiz Santos, [@santosluiz](https://github.com/santosluiz)*.

Este tutorial mescla, adapta e extende alguns dos guias básicos do RailsGirls **para o cenário de**: descrever, exibir e comentar locais turísticos e avaliá-los com o autismo amigável. Esta aplicação foi solicitada por [Galway Autism Partnership](http://www.galwayautismpartnership.com/) para ajudar autistas adultos em suas viagens.

A extensão é composta de **novas funcionalidades**:

* Tutorial de TDD
* Avaliação de Recurso
* Configuração de permissão para usuário autenticado (via devise)

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).


### [0. Instalação](/install)

**Certifique-se de que você possui o Rails e o Git instalados.** [**Siga o tutorial de instação**](/install), em seguinda [**Instale o Git**](http://www.git-scm.com/book/en/Getting-Started-Installing-Git). Então, configure o GitHub inserindo estes comandos no terminal:

{% highlight sh %}
$ git config --global user.name "Seu Nome"
$ git config --global user.email seu.email@example.com
{% endhighlight %}

<p>Etapas de configuração do GitHub.</p>

Crie uma [conta grátis no GitHub](https://github.com/signup/free), caso você ainda não possua uma.


### [1. Aplicação Web Básica](touristic-autism_basic-app)

### [2. Controle de versão com Git](touristic-autism_git)

### [3. Modelagem de Recursos](touristic-autism_resource-modeling)

### [4. Avaliação de Recursos](touristic-autism_resource-rating)

### [5. Design](touristic-autism_design)

### [6. Upload de imagens e Thumbnails](touristic-autism_image-upload)

**Opcional - para Garotas Rails avançadas:**
### [7. Implatanção Contínua](touristic-autism_continuous-deployment)

### [8.Teste e Integração Contínua](touristic-autism_static-pages-tdd)


# Anexo
## Desfazendo Coisas

O Rails possui ferramentas que facilitam bastante a recuperação de erros.

Por exemplo, você pode decidir alterar o nome do controller. Uma vez que, ao gerar o controller, o Rails cria muito mais arquivos que o controller. Desfazer essa operação, significa a remoção de um conjunto de arquivos. No Rails, isso pode ser feito com o `rails destroy`. Em particular, estes dois comandos cancelam um ao outro:

{% highlight sh %}
  $ rails generate controller FooBars baz quux
  $ rails destroy  controller FooBars baz quux
{% endhighlight %}

De uma forma análoga, depois geramos um modelo assim:

{% highlight sh %}
  $ rails generate model Foo bar:string baz:integer
{% endhighlight %}

Isso pode ser desfeito utilinzado:

{% highlight sh %}
  $ rails destroy model Foo
{% endhighlight %}

As migrações alteram o estado do banco de dados:

{% highlight sh %}
  $ rake db:migrate
{% endhighlight %}

Podemos desfazer uma única migração utilizando:

{% highlight sh %}
  $ rake db:rollback
{% endhighlight %}

Para voltar ao início, basta inserir:

{% highlight sh %}
  $ rake db:migrate VERSION=0
{% endhighlight %}

Como você pode imaginar, substituindo o 0 por qualquer outro número, vai fazer com que a migração ocorra para aquela versão. Onde os números de versão listam as migrações sequencialmente.

Para apagar a table do banco de dados, digite:

{% highlight sh %}
  $ rails console
{% endhighlight %}

Então, basta inserir o comando:

{% highlight sh %}
  ActiveRecord::Migration.drop_table(:<table-name>)
{% endhighlight %}

Você pode acessar o banco de dados diretamente (caso seja sqlite3, digite ".quit" para sair), utilizando:

{% highlight sh %}
  $ rails db
{% endhighlight %}

{% include other-guides.md page="touristic-autism_intro" %}
