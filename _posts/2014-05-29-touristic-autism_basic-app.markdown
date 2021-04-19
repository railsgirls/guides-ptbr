---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_basic-app
---

# Aplicação Web Básica

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para o projeto [Rails Girls Galway](https://github.com/RailsGirlsGalway)*

*Traduzido por Luiz Santos, [@santosluiz](https://github.com/santosluiz)*

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).

## Conheça as ferramentas

<div class="indent" markdown="1">

<h3><i class="icon-text-editor">&nbsp;</i></h3>

<h3>Editor de Texto</h3>

<p><a href="http://www.sublimetext.com">Sublime Text</a>, <a href="http://www.activestate.com/komodo-edit">Komodo Edit</a>, Vim, Emacs, e Gedit são exemplos de editores de texto que você pode usar para codar e editar arquivos.</p>

<h3><i class="icon-prompt">&nbsp;</i></h3>

<h3>Terminal (conhecendo os comandos do Prompt no Windows)</h3>
Onde você irá iniciar o servidor rails e rodar os comandos.

<h3><i class="icon-browser">&nbsp;</i></h3>

<h3>Navegadores - Browsers</h3>
(Firefox, Safari, Chrome) para visualizar sua aplicação.

<h3>GitHub</h3>
[Slides - por Kevin Lyda @]()

</div>

### Importante

É importante que você selecione as instruções específicas do seu sistema operacional - os comandos que você roda no Windows são superficialmente diferentes dos comandos do Mac ou do Linux. Se você estiver tendo algum problema, verifique o comutador do sistema operacional no rodapé dos comandos.


## 1. Criando a aplicação

Nós iremos criar um novo app Rails chamado *railsgirls-galway*.

Primeiro, vamos abrir o terminal:

* macOS: Abra o Spotlight, digite *Terminal* e clique em *Terminal*.
* Windows: Clique no Menu Iniciar e digite *Prompt* e clique em *Command Prompt with Ruby and Rails*.
* Linux (Ubuntu/Fedora): Procure por *Terminal* no dashboard e clique em *Terminal*.

Próximo, digite estes comandos no terminal:

<!-- <div class="os-specific">
  <div class="nix"> -->
{% highlight sh %}
mkdir projetos
{% endhighlight %}

<!-- <div>
  <p>-->
Você pode verificar o diretório `projetos` (que acabou de ser criado), utilizando o comando: `ls`. Se tudo ocorreu bem, você deverá ver o diretório `projetos` na listagem. Agora, devemos acessar o conteúdo do diretório `projetos` que acabamos de criar, utilizando o seguinte comando:
<!--  </p>
</div>-->

{% highlight sh %}
cd projetos
{% endhighlight %}

<!-- <div>
  <p>-->
Você pode verificar se está em um diretório vazio utilizando o comando `ls`. Agora, você pode criar uma nova aplicação chamada  `railsgirls-galway` com o comando:
<!--  </p>
</div>-->

{% highlight sh %}
rails new railsgirls-galway
{% endhighlight %}

<!-- <div>
  <p>-->
Este comando irá criar uma nova aplicação na pasta `railsgirls`. Então, nós devemos sair do diretório atual para entrarmos no diretório principal da nossa aplicação. Podemos fazer isso com o seguinte código:
<!--  </p>
</div>-->

{% highlight sh %}
rvm rubygems latest
cd railsgirls-galway
{% endhighlight %}

<!-- <div>
  <p>-->
Se você digitar o comando `ls` dentro do diretório, você deverá ver as pastas `app` e `config`. Então, você pode iniciar o servidor Rails com o comando:
<!--   </p>
</div>-->

{% highlight sh %}
rails server
{% endhighlight %}
  <!-- </div> -->

  <!-- <div class="win">
  </div>
</div> -->

Acesse [http://localhost:3000](http://localhost:3000) no seu navegador. Deverá aparecer a página de boas-vindas: "Welcome aboard". Isso significa que a sua aplicação em Rails está funcionando perfeitamente.

Perceba que nesta janela, o prompt de comando não está visível porque você está em um servidor Rails. O prompt de comando será mais ou menos assim:

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

Enquanto o prompt de comando não estiver visível, você não poderá executar novos comandos. Se você tentar inserir algum comando como `cd` ou algum outro comando, ele não irá funcionar. Para retornar ao prompt de comando normal:

Pressione <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal para sair do servidor.

**Instrutor(a):** Explique o que cada comando faz.
[O que é um servidor e uma aplicação web - Slides por @]()
O esqueleto gerado por `rails new` reflete o padrão de arquitetura [Model-View-Controller(MVC) - Slides por @]().

{% include other-guides.md page="touristic-autism_basic-app" %}

