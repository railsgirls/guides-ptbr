---
layout: default
title: Mostrando a lista de Café
permalink: sinatra-html
---

# Mostrando a lista de Café

*Criado por Tim McEwan, [@tjmcewan](https://twitter.com/tjmcewan)*

*Traduzido por Marina Limeira, [@marinalimeira_](http://twitter.com/marinalimeira_)*

Utilizar `.inspect` funciona para depurar, mas nós não queremos utilizá-lo em produção. Por um motivo, é muito difícil estilizar a saída. Vamos colocar nossa lista de cafés dentro do HTML correto.

## 1. Configuração

Primeiro vamos fazer um método que irá retornar nossos café dentro de tags HTML. Nós iremos nomear o método `coffees_html`, e o que ele faz é meio óbvio. Defina ele como:

{% highlight ruby %}
def coffees_html
  # construa o HTML aqui
end
{% endhighlight %}

E no seu template altere a linha `#{ $coffees.inspect }` para chamar nosso novo método:

{% highlight ruby %}
#{ coffees_html }
{% endhighlight %}

## 2. Adicione algum HTML

Escreva alguma coisa para tornar a variável global `$coffees` em HTML que pareça assim:

{% highlight HTML %}
<div>Flat White $3.50</div>
<br>
<div>Cappuccino $2.50</div>
{% endhighlight %}

**Dica:** Lembre-se, a variável `$coffees` é um array de hashes.

Nós queremos iterar o array `$coffees` e transformar cada hash em uma string HTML, dentro de `<div>`s, que deveriam ser todos separados por `<br/>`s. Nós também queremos ter certeza de estar retornando uma string.

Para alguma ideias de solução, [cheque isto](http://tjmcewan.github.io/coffeecalc/snippets/coffees_html.rb.txt).

{% include other-guides.md page="sinatra-html" %}
