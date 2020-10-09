---
layout: default
title: Contribua com um tutorial
permalink: contributing
---

# Instruções para contribuir com um tutorial

*Traduzido por Maujor, [site do Maujor](http://www.maujor.com)*

O site de tutoriais usa a tecnologia [jekyll](https://github.com/mojombo/jekyll) para renderizar suas páginas e todos os documentos do site são escritos com uso da sintaxe [markdown](http://daringfireball.net/projects/markdown/). Para contribuir com um ou mais  ( ;-) ) tutoriais siga os seguinte passos:

1. Dê um fork no [repositório do github](https://github.com/railsgirlsmaceio/railsgirlsguides) clicando no botão "Fork".
2. Execute o comando `git clone` no seu fork.

## Se você quer criar um novo tutorial

- Crie um arquivo denominado `YYYY-MM-DD-nome_do_tutorial.markdown` e salve no diretório `_posts` do seu fork.
- No início do arquivo recém criado use a sintaxe YAML para serializar alguns dados que são padronizados para os tutoriais. Veja um exemplo destes dados que se aplica a este documento que você está visualizando:

{% highlight yaml %}
  ---
  layout: default
  title: Contribua com um tutorial
  permalink: contributing
  ---
{% endhighlight %}

- A seguir escreva seu tutorial usando a sintaxe markdown.

Você pode tomar como base para seu tutorial a estrutura do tutorial [Rails Girls App Tutorial](https://github.com/railsgirlsmaceio/railsgirlsguides/blob/gh-pages/_posts/2012-04-18-app.markdown).

## Se você quer melhorar um tutorial já existente:
Faça as mudanças no arquivo que você quer mudar! Você não precisa criar um novo arquivo se você quer mudar alguma coisa em um arquivo que já existe.

## Depois...

1. Commit seu tutorial para o seu repositório.
2. Feito o commit envie-o para seu fork.
3. Finalmente abra um pull request e nele acrescente uma breve descrição do seu tutorial. Feito!

Nossos mais efusivos agradecimentos por dedicar seu tempo em favor do enriquecimento dos conteúdos do site Rails Girls.
