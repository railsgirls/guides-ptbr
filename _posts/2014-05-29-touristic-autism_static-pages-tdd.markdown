---
layout: default
title: App para turismo de autismo amigável
permalink: touristic-autism_static-pages-tdd
---

# Desenvolvimento Guiado por Teste - TDD (Test-Driven Development)

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*

*Traduzido por Beatriz Rezener, [@beatrizrezener](https://github.com/beatrizrezener)*

Os tutoriais básicos que foram mesclados e adaptados são: [Tutorial Ruby on Rails](http://www.railstutorial.org/book), [App RailsGirls](http://guides.railsgirls.com/app/) e os tutoriais para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticando usuários](http://guides.railsgirls.com/devise/), [adicionando design](http://guides.railsgirls.com/design), [implantando com o OpenShift](http://guides.railsgirls.com/openshift/), [adicionando comentários](http://guides.railsgirls.com/commenting) e [tutorial do Mark McDonnell](http://code.tutsplus.com/tutorials/testing-your-ruby-code-with-guard-rspec-pry--cms-19974).

O Rails inclui um framework `Test::Unit` padrão usado para testar seu código. Usaremos um framework de testes mais avançado, chamado `RSpec`, para escrever um conjunto de testes. Precisamos ser capazes de escrever testes que sejam rápidos e que nos dê feedback intantâneo sobre os problemas com o nosso código.

Usaremos o `Guard` e o `RSpec` para monitorar alguns de nossos arquivos e executar testes sobre eles assim que eles forem modificados, para termos certeza de que as últimas mudanças não estão quebrando a aplicação.

Se algum erro for encontrado, então iremos nos aprofundar nele para entender a causa e consertá-lo, usando o `Pry`.

Finalmente, dado que estamos assumindo que estamos desenvolvendo em colaboração com outros por meio do GitHub, também faremos com que cada contribuição não entre em conflito quando integrada com as demais. Por esse motivo, também realizaremos commits, push e testes de integração com frequência, em um processo chamado "Integração Contínua". Usaremos a `Travis-CI` para nos apoiar.

## Teste contínuo com `Guard`

Em seu `Gemfile`, adicione

{% highlight ruby %}
group :test do
  gem 'rspec'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
end
{% endhighlight %}

e execute

{% highlight sh %}
bundle install
{% endhighlight %}

para instalar as gems.

Então, crie um arquivo chamado `Rakefile` em seu diretório principal do projeto e adicione

{% highlight ruby %}
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ['--color', '--format', 'doc']
end
{% endhighlight %}

Quando você instala o `RSpec`, ele dá acesso a uma tarefa construída em `Rake` e é isso que estamos usando aqui. Nós criamos uma nova instância de `RakeTask` que, por padrão, cria uma tarefa chamada `spec` que procurará uma pasta chamada `spec` e executará todos os arquivos de teste dentro dessa pasta, usando as opções de configuração que definimos (aqui cor e formato da saída de teste na linha de comando)

*Nota:* para executar os testes, basta digitar `rake spec` na sua linha de comando. Você receberá zero falhas porque ainda não escrevemos qualquer teste ou qualquer código.

Agora, adicione o seguinte a um novo arquivo (no diretório principal do projeto) chamado `Guardfile`:

{% highlight ruby %}
guard 'rspec' do
  # observe os arquivos da pasta /app/views
  watch(%r{^app/views/(.+).html.rb$}) do |m|
    "spec/features/#{m[1]}_spec.rb"
  end

  # observe os arquivos da oasta /spec/features
  watch(%r{^spec/features/(.+).rb$}) do |m|
    "spec/features/#{m[1]}.rb"
  end
end
{% endhighlight %}

O conteúdo deste arquivo diz ao `Guard` o que fazer quando executamos o comando `guard`.

Se executássemos `guard rspec`, o `Guard` observaria os arquivos especificados e executaria os comandos definidos assim que alguma alteração desses arquivos tivesse ocorrido. *Nota:* como nós só temos uma tarefa `guard`, o `rspec`, isso é executado por padrão se executarmos o comando `guard`.

Neste caso, estamos dizendo ao `Guard` que observe todos os arquivos dentro de nossas pastas `app/views` e `spec/features` e, se ocorrer alguma alteração em qualquer desses arquivos, então execute os arquivos de teste dentro da nossa pasta `spec/features` para garantir que as mudanças que fizemos não quebraram nossos testes (e, consequentemente, não quebraram nosso código).

Agora, como é apropriado no Desenvolvimento Guiado por Teste (TDD), vamos criar um teste para a nossa página estática "Home", antes mesmo de criá-la.

Nós vamos criar um arquivo intitulado `home_spec.rb` e colocá-lo na pasta `spec/feature` (a qual o `Guard` está observando). O objetivo deste arquivo é tornar-se nosso arquivo de especificação (em outras palavras, este será o nosso código de teste e representará a funcionalidade esperada).

*Nota:* em Ruby, as palavras "teste" e "especificação" são muitas vezes consideradas intercambiáveis.

### TDD: Escrevendo Código de Teste antes do Código da Aplicação

Normalmente, se você escreve o código da aplicação primeiro (então você não está fazendo o TDD), então você se encontrará escrevendo um código que, em algum momento do futuro, será desnecessariamente complicado e potencialmente obsoleto. Por meio do processo de refatoração ou alteração de requisitos, você poderá descobrir que algumas funções nunca serão chamadas.

É por isso que o TDD é considerado a melhor prática e o método de desenvolvimento favorito, porque cada linha de código que você produzirá foi produzida por um motivo: corrigir especificações (os requisitos do seu negócio) que estão falhando.

Vamos escrever o teste `home.html.erb_spec.rb` como:

{% highlight ruby %}
require 'spec_helper'

describe "teste para a página estática Home" do
  it "exibe o atributo de texto da mensagem" do
    render
    rendered.should contain("Olá mundo!")
  end
end
{% endhighlight %}


Para nos ajudar a reduzir o código clichê, o colocamos dentro de um arquivo especial auxiliar que vamos carregar nos nossos arquivos de especificação. Este arquivo será intitulado `spec_helper.rb`.

Este arquivo irá fazer o seguinte:

*    dizer ao Ruby onde o nosso código da aplicação principal está localizado
*    carregar o código do nosso aplicativo (para que os testes sejam executados)
*    carregar a gem `pry` (nos ajuda a depurar nosso código, se precisarmos).

Aqui está o código:

{% highlight ruby %}
$LOAD_PATH << File.join(File.dirname(FILE), '..', 'app/views')

require 'pry'
require 'home'
{% endhighlight %}


Vamos abrir uma nova linha de comando, insira `guard` e deixe-o em execução: ele irá monitorar nossas páginas em `app/views` e executar testes da `spec/features` para elas. Se agora criarmos um arquivo vazio, o `app/views/home.html.erb` o `Guard` irá executar o teste e, sem supresa, o teste falhará.

O ponto de TDD é ter um loop de feedback estreito, também conhecido como 'red, green, refactor' (vermelho, verde, refatorar). Na prática, isso significa:

* escrever um teste que falha
* escrever o código mais simples possível para que ele passe
* refatorar o código



Então vamos criar nossa página estática "Home". Criamos um `PagesController` cujo objetivo é lidar com páginas estáticas (por exemplo, Home, About, Help). Cada página é representada por uma ação no controlador `pages_controller.rb`.

{% highlight ruby %}
class PagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end
end
{% endhighlight %}

Agora temos que dizer ao servidor que combine as requisições do navegador para cada página diferente de nossas ações:

{% highlight sh %}
match '/home' => 'pages#home'
match '/about' => 'pages#about'
match '/help' => 'pages#help'
{% endhighlight %}

Em seguida, criamos as páginas `home.html.erb`, `about.html.erb` e `help.html.erb` em `app/views/pages`. Esses arquivos contêm qualquer conteúdo que você deseja em suas páginas estáticas. Eles usarão, por padrão, o layout `application.html.erb` do seu aplicativo.

Por enquanto, vamos deixá-los vazios e apenas adicionar o seguinte a `home.html.erb`, para satisfazer nosso teste

{% highlight erb %}
Olá mundo!
{% endhighlight %}

Agora, se verificarmos a janela de linha de comando onde o `guard` estava em execução, veremos que ele executou automaticamente nosso teste assim que salvamos as alterações em nosso arquivo `home.html.erb` e que o teste agora está sendo bem-sucedido.

*Nota:* se quisermos executar manualmente os testes em vez de usar o `Guard`, teríamos que executar `rspec spec/features/home.html.erb_spec.rb`.


## Depuração com `Pry`

Com o intuito de demonstrar o Pry, vamos adicionar mais código ao nosso controlador (este código extra não afeta nosso teste).

{% highlight ruby %}
class PagesController < ApplicationController
attr_accessor :test

  @@class_property = "Sou uma propriedade de classe"

  def home
    binding.pry
    @instance_property = "Sou uma propriedade de instância"
    pubs
    privs
    "Olá RSpec!"
  end

  def about
    test_var = "Sou uma variável de teste"
    test_var
  end

  def help
  end

  private

  def privs
    puts "Sou privado"
  end
end
{% endhighlight %}

Um "break-point" é um lugar dentro do seu código onde a execução irá parar.
Você pode ter vários "break-points" definidos no seu código e você os cria usando `binding.pry` (observe que foi incluído acima).

Quando você executar o seu código, você notará que o terminal irá parar e colocá-lo dentro do código do seu aplicativo no local exato em que o `binding.pry` foi colocado.

A partir deste ponto, o `Pry` tem acesso ao escopo local. Você pode digitar `exit` para sair do `Pry` e para o seu código continuar executando.

**Nota:** Você pode tentar encontrar onde você está, digitando: `whereami`; Rastrear a pilha de execução: `wtf`; Inspecionar os métodos e propriedades disponíveis: `ls`; Mudar o Escopo: `cd`.

## Integração Contínua (CI) com Travis-CI

O princípio da IC é realizar "commit/push" o quanto antes e muitas vezes para evitar conflitos entre seu código e a "branch" principal. Quando você faz isso (neste caso, estamos realizando commits para o GitHub), é iniciada uma "build" no seu servidor CI, que executa os testes relevantes para garantir que tudo esteja funcionando como deve ser.

O Travis CI é um serviço de integração contínua hospedado para a comunidade de código aberto. Oferece serviços de CI gratuitos para projetos de código aberto e também tem um modelo pago para empresas. Usaremos o modelo de código aberto gratuito em nosso repositório GitHub.

O processo é o seguinte:

*    Inscreva-se no Travis-CI usando sua conta GitHub
*    Vá para a página "Accounts"
*    Habilite o CI em todos os repositórios que deseja executá-lo
*    Crie um arquivo `.travis.yml` dentro do diretório raiz do seu projeto e realize commit dele ao seu depósito GitHub

O arquivo `.travis.yml` determina as configurações do Travis-CI para que ele saiba como gerenciar a execução dos testes em seu projeto. Vamos criá-lo da seguinte maneira:

{% highlight sh %}
language: ruby
cache: bundler

rvm:
  - 1.25.26

script: 'bundle exec rake spec'

bundler_args: --without development

branches:
  only:
    - master

notifications:
  email:
    - you@example.com
{% endhighlight %}

Precisamos adicionar `gem 'rake'` ao nosso `Gemfile` dentro do grupo `:test`, pois este é um requisito da Travis-CI.

O Travis-CI usa o RVM (Ruby Version Manager) para instalar versões do Ruby em seus servidores. Portanto, precisamos especificar as versões do Ruby para as quais queremos executar nossos testes.

Além disso, vamos adicionar a `spec/spec_helper.rb` o seguinte:
{% highlight sh %}
 require 'pry' if ENV['APP_ENV'] == 'debug'"
{% endhighlight %}

e deixar claro no nosso `Gemfile` quais gems são necessárias para teste e para o desenvolvimento:

{% highlight sh %}
group :test do
  gem 'rake'
  gem 'rspec'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'

  # Adiciona passos de depuração ao Pry
  # continue, step, next
  gem 'pry-remote'
  gem 'pry-nav'
end
{% endhighlight %}

**Nota:** se você tiver algum problema relacionado ao Travis-CI, pode participar do canal "#travis" no IRC freenode para obter ajuda para responder qualquer dúvida que você possa ter.