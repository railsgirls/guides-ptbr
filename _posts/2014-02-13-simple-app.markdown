---
layout: default
title: Tutorial para um app Rails Girls mais simples
permalink: simpleapp
---

# Tutorial Rails Girls App 

*Criado por Vesa Vänskä, [@vesan](https://twitter.com/vesan)*

*Editado para incluir [simple_scaffold](https://github.com/Ben-M/simple_scaffold) por Ben Maraney.*

*Traduzido por Laura Rocha Prado, [@arbolitoloco](https://arbolitoloco.github.io)*

**Certifique-se de que o Rails esteja instalado.** [**Siga as instruções no guia de instalação**](/install) para deixar tudo pronto para começar.


## Conhecendo as ferramentas

<div class="indent" markdown="1">

<h3><i class="icon-text-editor">&nbsp;</i></h3>

<h3>Editor de Texto</h3>

[Sublime Text](http://www.sublimetext.com), [Komodo Edit](http://www.activestate.com/komodo-edit), Vim, Emacs, e Gedit são exemplos de editores de texto que você pode usar para escrever código e editar arquivos.

<h3><i class="icon-prompt">&nbsp;</i></h3>

<h3>Terminal (também conhecido como Prompt de Comandos ou Command Prompt no Windows)</h3>
Interface onde você vai iniciar o servidor rails e executar comandos.

<h3><i class="icon-browser">&nbsp;</i></h3>

<h3>Navegador ou browser</h3>
(Firefox, Safari, Chrome) usados para visualizar sua aplicação.

</div>

### Importante

É importante que você siga as instruções especificas ao seu sistema operacional. Os comandos que você precisará executar em um computador rodando Windows são um pouco diferentes daqueles executados no Mac ou no Linux. Se você estiver com dificuldades, clique no alternador de comandos para diferentes sistemas operacionais disponível ao final de cada comando.

## *1.*Criando a aplicação

Vamos criar uma nova aplicação Rails chamada *railsgirls*.

Primeiro, vamos abrir um terminal:

* macOS: Abra o Spotlight, digite *Terminal* e clique na aplicação *Terminal*.
* Windows: Clique em Iniciar (Start) e procure o *Prompt de Comandos* (*Command Prompt*), e então clique em *Prompt de Comandos com Ruby e Rails* (*Command Prompt with Ruby and Rails*).
* Linux (Ubuntu/Fedora): Procure por *Terminal* no dash e clicque em *Terminal*.

Em seguida, digite os comandos abaixo no terminal:

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
mkdir projetos
{% endhighlight %}

    <div>
Você pode checar se uma pasta chamada <code>projetos</code> foi criada com o seguinte comando de listar: <code>ls</code>. Você deve ver a pasta <code>projetos</code> no texto de saída (output). Agora você deve mudar de pasta e entrar na pasta <code>projetos</code> com o comando:
    </div>

{% highlight sh %}
cd projetos
{% endhighlight %}

    <div>
Você pode checar que está em uma pasta vazia usando novamente o comando <code>ls</code>. Agora você deve criar uma nova aplicação chamada <code>railsgirls</code> através do comando:
    </div>

{% highlight sh %}
rails new railsgirls -m http://railsgirls.com/simple_scaffold.rb
{% endhighlight %}

    <div>
        <code>rails new railsgirls</code> diz ao Rails que crie um novo projeto chamado `railsgirls`, com todos os arquivos de que nossa aplicação precisa.
    </div>
    <div>
        <code>-m http://railsgirls.com/simple_scaffold.rb</code> diz ao Rails que baixe um modelo especial a partir de railsgirls.com, o qual deixa os arquivos um pouco mais simples e fáceis para iniciantes entenderem.
    </div>
    <div>

Isso cria uma nova aplicação na pasta <code>railsgirls</code>. Nós devemos, então, novamente mudar de pasta, para entrar na nossa aplicação rails, usando o comando:
    </div>

{% highlight sh %}
cd railsgirls
{% endhighlight %}

    <div>
Se você executar o comando <code>ls</code> dentro dessa pasta, você deve ver outras pastas, como <code>app</code> e <code>config</code>. Você pode então iniciar o servidor rails com o comando:
    </div>

{% highlight sh %}
rails server
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
mkdir projetos
{% endhighlight %}

    <div>
Verifique que uma pasta chamada <code>projetos</code> foi criada com o comando de listar: <code>dir</code>. A pasta <code>projetos</code> deve estar visível no output. Em seguida, mude de pasta, entrando na pasta <code>projetos</code>, usando o comando:
    </div>

{% highlight sh %}
cd projetos
{% endhighlight %}

    <div>
Você pode checar agora que está em uma pasta vazia, ao executar mais uma vez o comando <code>dir</code>. Então crie uma nova aplicação chamada <code>railsgirls</code> com o comando:
    </div>

{% highlight sh %}
rails new railsgirls -m http://railsgirls.com/simple_scaffold.rb
{% endhighlight %}

    <div>
        <code>rails new railsgirls</code> diz ao Rails que crie um novo projeto chamado railsgirls, com todos os arquivos de que nossa aplicação precisa.
    </div>
    <div>
        <code>-m http://railsgirls.com/simple_scaffold.rb</code> diz ao Rails que baixe um modelo especial a partir de railsgirls.com, o qual deixa os arquivos um pouco mais simples e fáceis para iniciantes entenderem.
    </div>
    <div>
Isso cria uma nova aplicação na pasta <code>railsgirls</code>. Nós devemos, então, novamente mudar de pasta, para entrar na nossa aplicação rails, usando o comando:
    </div>

{% highlight sh %}
cd railsgirls
{% endhighlight %}

    <div>
Se você executar o comando <code>dir</code> dentro dessa pasta, você deve ver outras pastas, como <code>app</code> e <code>config</code>. Você pode então iniciar o servidor rails com o comando:
    </div>

{% highlight sh %}
ruby bin\rails server
{% endhighlight %}
  </div>
</div>

**Usuários Windows:** Talvez seja necessário substituir `bin\rails` por `script\rails`, dependendo da versão de Rails que você tem instalada.

Abra o endereço [http://localhost:3000](http://localhost:3000) no seu navegador. A página "Welcome aboard" deve aparecer, o que significa que a criação da sua app funcionou corretamente.

Note que, nessa janela, o prompt de comandos não está visível, porque você está agora no servidor Rails. O prompt de comandos se parece com isso:

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
$
{% endhighlight %}
  </div>
  <div class="win">
{% highlight sh %}
>
{% endhighlight %}
  </div>
</div>

Quando o prompt de comandos não está visível, você não consegue executar novos comandos. Se você tentar executar o comando `cd` ou qualquer outro comando, eles não vão funcionar. Para voltar ao prompt de comandos normal:

Pressione <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal, para parar o servidor.

**Instrutor(a):** Explique o que cada comando faz. O que foi criado? O que o servidor faz? Você pode saber mais sobre o modelo especial no [GitHub](https://github.com/Ben-M/simple_scaffold).

## *2.*Criar o Scaffold de ideias

Usaremos a funcionalidade de scaffold do Rails para criar um ponto de partida que nos permitirá listar, adicionar, remover, editar e ver coisas que, no nosso caso, são ideias.

**Instrutor(a):** O que é a scaffolding em Rails? (Explique o comando, o nome do modelo, as convenções nomenclaturais, atributos e tipos, etc.) O que são migrações e por que elas são necessárias?

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
rails generate scaffold idea name:string description:text picture:string
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
rails generate scaffold idea name:string description:text picture:string
{% endhighlight %}
  </div>
</div>

O scaffold cria novos arquivos na sua pasta de projeto, mas para que eles funcionem adequadamente é preciso executar alguns outros comandos, de forma que atualizemos nosso banco de dados e reiniciemos o servidor.

<div class="os-specific">
  <div class="nix">
{% highlight sh %}
rake db:migrate
rails server
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
rake db:migrate
ruby bin\rails server
{% endhighlight %}
  </div>
</div>

Abra o endereço [http://localhost:3000/ideas](http://localhost:3000/ideas) no seu navegador. Clique nos links disponíveis e teste o que acontece quando você executa os comandos de linha.

Pressione <kbd>Ctrl</kbd>+<kbd>C</kbd> para parar o servidor depois que você já tiver experimentado um pouco.

## *3.*Design

**Instrutor(a):** Fale um pouco sobre a relação entre HTML e Rails. Qual parte das views é HTML e qual parte é Embedded Ruby (ERB)? O que é MVC e como isso se relaciona às views e HTML? (Modelos - models - e controladores - controllers - são responsáveis pela geração das views.)

A nossa aplicação não está muito bonita ainda. Vamos resolver isso. Usaremos o projeto Bootstrap do Twitter para deixar nosso design mais bonito e de forma bem fácil.

Abra `app/views/layouts/application.html.erb` no seu editor de texto e, acima da linha

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

por

{% highlight erb %}
<div class="container">
  <%= yield %>
</div>
{% endhighlight %}

Vamos também adicionar uma barra de navegação e um rodapé ao nosso layout. No mesmo arquivo, abaixo de `<body>`, adicione

{% highlight html %}
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">The Idea app</a>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="/ideas">Ideas</a></li>
      </ul>
    </div>
  </div>
</nav>
{% endhighlight %}

e, antes de `</body>`, adicione

{% highlight html %}
<footer>
  <div class="container">
    Rails Girls 2013
  </div>
</footer>
<script src="//railsgirls.com/assets/bootstrap.js"></script>
{% endhighlight %}


Agora vamos mudar a aparência da nossa tabela de ideias. Abra `app/assets/stylesheets/application.css` e, ao final, adicione

{% highlight css %}
body { padding-top: 100px; }
footer { margin-top: 100px; }
table, td, th { vertical-align: middle !important; border: none !important; }
th { border-bottom: 1px solid #DDD !important; }
{% endhighlight %}

Em seguida certifique-se de que você salvou seus arquivos e atualize o navegador para ver o que mudou. Você também pode fazer alterações adicionais no seu HTML & CSS.

**Instrutor(a):** Fale um pouco sobre CSS e layouts.


## *4.*Adicionando uploads de imagens

Precisamos instalar um módulo de software que nos permita fazer upload de arquivos no Rails.

Abra `Gemfile` na sua pasta de projeto usando seu editor de texto e, abaixo da linha

{% highlight ruby %}
gem 'sqlite3'
{% endhighlight %}

adicione

{% highlight ruby %}
gem 'carrierwave'
{% endhighlight %}

**Instrutor(a):** Explique o que são bibliotecas (libraries) e qual a sua utilidade. Descreva o que é software livre (open source software).

No terminal, execute:

{% highlight sh %}
bundle
{% endhighlight %}

Agora podemos criar o código que lida com uploads. No terminal, execute:

{% highlight sh %}
rails generate uploader Picture
{% endhighlight %}

Nesse ponto você precisa **reiniciar o processo do servidor Rails** no terminal.

Pressione <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal para parar o servidor. Uma vez parado, você pode pressionar a tecla para cima para ver o último comando usado, e então pressionar enter para reiniciar o servidor.

Isso é necessário para que a app carregue as bibliotecas adicionadas.

Abra `app/models/idea.rb` e, abaixo da linha

{% highlight ruby %}
class Idea < ActiveRecord::Base
{% endhighlight %}

adicione

{% highlight ruby %}
mount_uploader :picture, PictureUploader
{% endhighlight %}

Abra `app/views/ideas/_form.html.erb` e mude

{% highlight erb %}
<%= f.text_field :picture %>
{% endhighlight %}

para

{% highlight erb %}
<%= f.file_field :picture %>
{% endhighlight %}

Pode ser que você veja um erro do tipo `TypeError: can't cast ActionDispatch::Http::UploadedFile to string`.

Se isso ocorrer, no arquivo `app/views/ideas/_form.html.erb`, mude a linha

{% highlight erb %}
<%= form_for(@idea) do |f| %>
{% endhighlight %}

para

{% highlight erb %}
<%= form_for @idea, :html => {:multipart => true} do |f| %>
{% endhighlight %}

No seu navegador, adicione uma nova ideia com uma imagem. Quando você faz o upload da imagem, ela não fica muito bonita, porque o site só mostra um caminho para o arquivo. Vamos consertar isso.

Abra `app/views/ideas/show.html.erb` e mude

{% highlight erb %}
<%= @idea.picture %>
{% endhighlight %}

para

{% highlight erb %}
<%= image_tag(@idea.picture_url, :width => 600) if @idea.picture.present? %>
{% endhighlight %}

Agora atualize seu navegador para ver o que mudou.

**Instrutor(a):** Fale um pouco sobre HTML.


## *5.*Acertos finais nas rotas

Se você tentar abrir [http://localhost:3000](http://localhost:3000), a página "Welcome aboard" ainda vai ser mostrada. Vamos fazer com que o endereço redirecione para a nossa página de ideias.

Abra `config/routes.rb` e, após a primeira linha, adicione

{% highlight ruby %}
root :to => redirect('/ideas')
{% endhighlight %}

Teste se houve alteração, abrindo o caminho raiz (isto é, [http://localhost:3000](http://localhost:3000)) no seu navegador.

**Instrutor(a):** Fale sobre rotas (routes), incluindo detalhes sobre a ordem das rotas e sua relação com arquivos estáticos.

**Usuários de Rails 3:** Você precisará deletar o arquivo index.html da pasta `/public/` para que isso funcione.

## Crie uma página estática na sua app

Vamos adicionar uma página estática à nossa app, a qual conterá informações sobre a sua autora — você!

{% highlight sh %}
rails generate controller pages info
{% endhighlight %}

Esse comando criará uma nova pasta em `app/views` chamada `/pages`, e dentro dela um arquivo chamado `info.html.erb`, que será nossa página de informações.

Ele também adiciona uma rota simples no seu routes.rb.

{% highlight ruby %}
get "pages/info"
{% endhighlight %}

Você pode abrir agora o arquivo `app/views/pages/info.html.erb` e adicionar informações sobre você em HTML, e então abrir o endereço [http://localhost:3000/pages/info](http://localhost:3000/pages/info) no seu navegador para ver a sua nova página de informações.

## E depois?

* Adicione design usando HTML &amp; CSS
* Adicione avaliações
* Use CoffeeScript (ou JavaScript) para adicionar interatividade
* Adicione redimensionamento de imagens para que o carregamento das imagens seja mais rápido

{% include other-guides.md page="simpleapp" %}
