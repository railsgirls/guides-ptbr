---
layout: default
titulo: Rails Girls Sinatra tutorial
permalink: sinatra-app
---

# Crie sua primeira app de votação com Sinatra

*Criado por Piotr Szotkowski, [@chastell](https://twitter.com/chastell)*
*Traduzido por Nathalia Pinheiro Mesquita, [@nathi_pinheiro](https://twitter.com/nathi_pinheiro)*

Nós vamos criar um pequeno app de votação do zero usando um framework de desenvolvimento web para Ruby chamado Sinatra, e que é muito parecido com Ruby on Rails. Mas é só outra ferramenta para fazermos nosso trabalho e uma bem divertida também!

Imagine seu grupo de amigos tentando decidir o que pedir para sua maratona de filmes semanal. Com tantas opções de fast food para pedir, isso pode se tornar uma discussão e tanto. É nessa hora que entra o nosso app!

__INSTRUTOR(A)__: Breve explicação sobre o que é o [Sinatra](http://www.sinatrarb.com).

## Instalação Sinatra

Lembra como nós precisávamos instalar Ruby on Rails? Da mesma maneira precisamos instalar o Sinatra:

{% highlight sh %}
gem install sinatra
{% endhighlight %}

### Crie sua primeira aplicação Sinatra

Crie o arquivo `sufragista.rb` com o seguinte conteúdo:

{% highlight ruby %}
require 'sinatra'

get '/' do
  'Olá, eleitor!'
end
{% endhighlight %}

Você pode chamar seu arquivo Ruby do que preferir. `voto.rb` por exemplo funcionaria bem também. Mas [Sufragista](http://www.vocabulary.com/dictionary/suffragist) é uma referencia a um evento super importante no movimento a favor do direito das mulheres, então vamos usar este por agora!

### Rode sua app

Vá para o diretório onde você colocou sua app e execute `ruby sufragista.rb`
Agora você pode visitar <a href="localhost:4567" target="_blank">localhost:4567</a>. Onde você deverá
ver a página "Olá, eleitor!", o que significa que a geração do seu novo
app está funcionando corretamente. Aperte <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal para parar o servidor. Se <kbd>Ctrl</kbd>+<kbd>C</kbd> não funcionar para você significa que você provavelmente está usando Windows e <kbd>Ctrl</kbd>+<kbd>Z</kbd>/ <kbd>Ctrl</kbd>+<kbd>Pause</kbd> / <kbd>Ctrl</kbd>+<kbd>Break</kbd> deve resolver esse problema.

__INSTRUTOR(A)__: Explique o método POST e GET e como eles se comunicam com o browser.



### Adicione o index view

Para manter tudo em ordem vamos criar um
diretório para nossas views (e nomear como `views`).

Coloque esse código no arquivo `index.erb` dentro do diretório `views`:

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Sufragista</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <p>O que tem para jantar?</p>
    <form action='cast' method='post'>
      <ul class='unstyled'>
        <% Opcoes.each do |id, text| %>
          <li>
            <label class='radio'>
              <input type='radio' name='vote' value='<%= id %>' id='vote_<%= id %>' />
              <%= text %>
            </label>
          </li>
        <% end %>
      </ul>
      <button type='submit' class='btn btn-primary'>Votar!</button>
    </form>
  </body>
</html>
{% endhighlight %}

e dentro do `sufragista.rb`:

{% highlight ruby %}
Opcoes = {
  'HAM' => 'Hambúrger',
  'PIZ' => 'Pizza',
  'SUS' => 'Sushi',
  'LAM' => 'Lámen',
}
{% endhighlight %}

Mude a ação `get`:

{% highlight ruby %}
get '/' do
  erb :index
end
{% endhighlight %}

Execute `ruby sufragista.rb`, cheque seus
resultados e pare o servidor com <kbd>Ctrl</kbd>+<kbd>C</kbd>.

__INSTRUTOR(A)__: Fale um pouco sobre HTML e erb. Explique
sobre templates e sobre o que são constantes globais.



### Templates

Ajuste o arquivo `index.erb` no diretório `views`
e adicione a linha `<h1>…</h1>`:

{% highlight erb %}
  <body class='container'>
    <h1><%= @titulo %></h1>
    <p>O que tem para jantar?</p>
{% endhighlight %}

Mude a ação `get`:

{% highlight ruby %}
get '/' do
  @titulo = 'Bem vindo ao Sufragista!'
  erb :index
end
{% endhighlight %}

__INSTRUTOR(A)__: Explique o que são instancias de variáveis
e como Sinatra faz elas visíveis nas views.



### Adicione a habilidade de fazer um POST dos resultados

Coloque isto no `sufragista.rb`:

{% highlight ruby %}
post '/cast' do
  @titulo = 'Obrigada por votar!'
  @voto  = params['voto']
  erb :cast
end
{% endhighlight %}

Crie um novo arquivo `cast.erb` no diretório `views`,
e coloque lá um pouco de HTML com código Ruby junto:

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Suffragist</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <h1><%= @titulo %></h1>
    <p>Seu voto: <%= Opcoes[@voto] %></p>
    <p><a href='/results'>Veja os Resultados!</a></p>
  </body>
</html>
{% endhighlight %}

__INSTRUTOR(A)__: Explique como o POST funciona. Como buscar o que
foi mandado no formulário? de onde veio o `params`?



### Construa um layout comum

Crie o arquivo `layout.erb` no diretório `views`.
Coloque o seguinte lá:

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Suffragist</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <h1><%= @titulo %></h1>
    <%= yield %>
  </body>
</html>
{% endhighlight %}

Remova a parte acima dos outros dois templates
(`index.erb` e `cast.erb` que estão no diretório `views`).

__INSTRUTOR(A)__: Fale sobre a estrutura de documentos HTML e sobre como a construção de código comum
funciona. Explique o que `yield` faz.



### Adicione o resultado route e o resultado view

Cole o seguinte código em `sufragista.rb`:

{% highlight ruby %}
get '/results' do
  @votos = { 'HAM' => 7, 'PIZ' => 5, 'SUS' => 3 }
  erb :results
end
{% endhighlight %}

Crie um novo arquivo no diretório `views`, chamado `results.erb`.

{% highlight erb %}
<table class='table table-hover table-striped'>
  <% Opcoes.each do |id, text| %>
    <tr>
      <th><%= text %></th>
      <td><%= @voto[id] || 0 %>
      <td><%= '#' * (@voto[id] || 0) %></td>
    </tr>
  <% end %>
</table>
<p><a href='/'>Vote Mais!</a></p>
{% endhighlight %}

Execute `ruby sufragistat.rb`, cheque
seus resultados e pause o servidor com <kbd>Ctrl</kbd>+<kbd>C</kbd>.

__INSTRUTOR(A)__: Explique tabelas HTML e como os valores faltando vem como zero.



### Guarde os resultados usando YAML::Store

Hora de algo novo! Vamos salvar nossas escolhas.

No topo de `sufragista.rb`, adicione o seguinte:

{% highlight ruby %}
require 'yaml/store'
{% endhighlight %}

Adicione mais código em `sufragista.rb` – substitua
`post '/cast'` e `get '/results'` com o seguinte:

{% highlight ruby %}
post '/cast' do
  @titulo = 'Obrigada por votar!'
  @votos  = params['voto']
  @store = YAML::Store.new 'votos.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @titulo = 'Resultados até agora:'
  @store = YAML::Store.new 'votos.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end
{% endhighlight %}

__INSTRUTOR(A)__: Explique o que é YAML.


### Veja como o arquivo YAML muda quando votos são salvos

Vamos abrir `votos.yml`. E votar. E checar novamente.

__INSTRUTOR(A)__: Vai ter situações onde um ou mais estudantes vão
esquecer de pausar o servidor antes de rodá-lo novamente. É uma boa
oportunidade para procurar na Internet por uma solução. Eles não tem
que saber de tudo sobre "matar" processos para achar a solução.

__INSTRUTOR(A)__: No final explique brevemente a diferença entre Sinatra e Rails.



## Brinque com o app

Tente mudar algumas coisas no app como:

* Adicionar alguma lógica adicional nas views.
* Redirecionar para os resultados.
* Adicione outra votação; como o arquivo YAML precisaria mudar?
* Tente estilizar o arquivo de diferente maneiras.

{% include other-guides.md page="sinatra-app" %}
