---
layout: default
title: Adicione design à sua aplicação com HTML e CSS
permalink: design-html-css
---

# Adicione design à sua aplicação com HTML e CSS
*Traduzido por [@MADPT](https://github.com/MADPT) aka [Miguel Ângelo](http://www.miguelangelo.io)*

**Esse guia assume que você já construiu o app do Rails Girls** [**seguindo o tutorial de desenvolvimento do app**](/app).

1.Desenhe o cabeçalho

+ Coloque o seguinte código na parte inferior do arquivo `app/assets/stylesheets/application.css`:

{% highlight css %}
.navbar {
    min-height: 38px;
    background-color: #f55e55;
}
{% endhighlight %}

  Agora atualize a página e verifique as mudanças. Você pode tentar alterar a cor ou fonte do cabeçalho. Você pode verificar a referência de cor aqui [http://color.uisdc.com/](http://color.uisdc.com/).

**Instrutor(a):** fale sobre a propriedade `display`, `inline` e `block`.

+ Em seguida, coloque estas linhas na parte inferior:

{% highlight css %}
.navbar a.brand { font-size: 18px; }
.navbar a.brand:hover {
    color: #fff;
    background-color: transparent;
    text-decoration: none;
}
{% endhighlight %}

**Instrutor(a):** explique os 4 estados de um link


2.Desenhe a tabela

 + Nós simplesmente usamos o Twitter [Bootstrap](http://getbootstrap.com/) para polir a nossa tabela. Encontre esta linha no arquivo `app/views/ideas/index.html.erb` e substitua:

{% highlight html %}
<table>
{% endhighlight %}

   com

{% highlight html %}
<table class="table">`
{% endhighlight %}

 + Modifique o tamanho da imagem usando as seguintes linhas

{% highlight erb %}
<%= image_tag(idea.picture_url, :width => 600) if idea.picture.present? %>
{% endhighlight %}

  Tente mudar a largura e veja o que vai acontecer


 + Adicione as seguintes linhas à parte inferior do arquivo `app/assets/stylesheets/ideas.css.scss`:

{% highlight css %}
.container a:hover {
  color: #f55e55;
  text-decoration: none;
  background-color: rgba(255, 255, 255, 0);
}
{% endhighlight %}


 + Tente adicionar algum estilo ao fundo com a propriedade `background-image`, use como referência
   [http://subtlepatterns.com/](http://subtlepatterns.com/) para alguns padrões.


3.Adicione estilo ao rodapé

+ Adicione as linhas ao fundo do ficheiro `app/assets/stylesheets/application.css`:

{% highlight css %}
footer {
  background-color: #ebebeb;
  padding: 30px 0;
}
{% endhighlight %}

Tente adicionar mais coisas em `footer`, depois ajuste sua posição.

4.Adicione estilo ao botão

  + Abra [http://localhost:3000/ideas/new](http://localhost:3000/ideas/new) e encontre o botão `Create Idea`.

   Adicione estas linhas ao ficheiro `app/assets/stylesheets/ideas.css.scss`

{% highlight css %}
.container input[type="submit"] {
  height: 30px;
  font-size: 13px;
  background-color: #f55e55;
  border: none;
  color: #fff;
}
{% endhighlight %}

   **Instrutor(a)** explique como usar `border` em css, tente modificar o estilo do botão como em volta da esquina, adicione sombra ou cor, etc.
