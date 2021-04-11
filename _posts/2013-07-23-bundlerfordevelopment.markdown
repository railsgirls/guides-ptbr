---
layout: default
title: Bundler para Desenvolvimento
permalink: bundlerfordevelopment
---

# Como configurar o _Bundler_ para Desenvolvimento

*Traduzido por Roberta Schmitz Mayer, [@robsmayer](https://github.com/robsmayer)*.


## *1.* Fork do Bundler

Vá para o Github do _Bundler_ [https://github.com/bundler/bundler](https://github.com/bundler/bundler)

Clique no botão Fork.

Fork _Bundler_ para que possa criar _pull requests_ com suas mudanças
<!--
  N.T.: Adicionado alt em imagem. Não estava presente no original. (@robsmayer, 2016-10-12 22:06)
-->

![exibe botão Fork na interface do Github](../images/fork1.jpg)

## *2.* Faça Download de uma cópia do seu fork do Bundler

{% highlight sh %}
$ git clone https://github.com/user_name/bundler.git
{% endhighlight %}

## *3.* Mude para o diretório do Bundler

{% highlight sh %}
$ cd bundler
{% endhighlight %}

## *4.* Configure o remote

{% highlight sh %}
$ git remote add upstream https://github.com/bundler/bundler.git
{% endhighlight %}

Isto conecta seu repositório local com o repósitorio __upstream__ no  Github.

## *5.* Instale as dependências de desenvolvimento do Bundler

{% highlight sh %}
$ rake spec:deps
{% endhighlight %}

O que é rake? [http://rake.rubyforge.org/](http://rake.rubyforge.org/)

## *6.* Rode o teste de validação do Bundler

{% highlight sh %}
$ rake spec
{% endhighlight %}

Isto deve demorar uns 15 minutos.

{% include other-guides.md page="bundlerfordevelopment" %}
