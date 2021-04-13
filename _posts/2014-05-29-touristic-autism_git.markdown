---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_git
---

# Controle de Vesão com o Git

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*  
*Traduzido por Luiz Santos, [@santosluiz](https://github.com/santosluiz)*

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e o tutorial para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando um design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) e [adicionando comentários](http://guides.railsgirls.com/commenting).


Navegue até o diretório principal do primeiro app e inicialize um novo repositório:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
$ git init
{% endhighlight %}
  </div>
</div>

Antes de adicionar o projeto ao repositório, vamos dizer ao Git quais arquivos ele deve ignorar listando no arquivo .gitignore. O comando "rails new" já cria o arquivo .gitignore, mas vamos estendê-lo com seguinte comando:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
# Ignore outros arquivos desnecessários.
database.yml
# Ignore a documentação do Rails
doc/
# Ignore Vim e Emacs
*.swp
*~
.project
# Ignore (para usuários de macOS) o diretório .DS_Store criado pelo Mac Finder application
.DS_Store
.idea
.secret
{% endhighlight %}
  </div>
</div>

Adicione as alterações (recursivamente, adicionando todos os sub-diretórios).
<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
git add .
{% endhighlight %}
  </div>
</div>

O comando `git add`, adiciona os arquivos do projeto área de stage, onde contém as alterações pendentes no seu projeto; Você pode ver quais arquivos estão na área de stage utilizando o comando status:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
$ git status
{% endhighlight %}
  </div>
</div>

Agora, faça o commit justificando o motivo de tal ação:
<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
$ git commit -m "Inicializando Repositório"
{% endhighlight %}
  </div>
Os commits do Git são locais. Eles são gravados apenas na máquina utilizada, na máquina em que os commits ocorrem. Você pode ver a lista com todos os commits com o `git log`, digitando `q` para sair.
</div>

Agora, queremos enviar nossas alterações para um repositório remoto:
[Criando um repositório](http://github.com/new) chamado "railsgirls-galway" e inserindo informações. Não inicie um repositório com o arquivo "README", pois o comando `rails new` já cria automaticamente.
Envie as alterações locais para o repositório remoto desta forma:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
$ git remote add origin https://github.com/<username>/railsgirls-galway.git
$ git push -u origin master
{% endhighlight %}
  </div>
O resultado é uma página no GitHub (por exemplo, [aqui está o meu](https://github.com/iammyr/railsgirls-galway-2014)) para o repositório da nossa aplicação, que fornece renderização agradável, compartilhando funcionalidades e estatísticas. Veja aqui: https://github.com/<your username>/railsgirls-galway
</div>

**Instrutor(a):** Explique como funciona o branch, edit, commit e merge no GitHub: altere seu projeto adicionando uma descrição no README.
([Slides por Myriam Leggieri @iammyr]())

{% include other-guides.md page="touristic-autism_git" %}
