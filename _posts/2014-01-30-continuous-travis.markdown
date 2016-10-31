---
layout: default
title: Continuous Deployment - cuz less hassle
permalink: continuous-travis
---

# Entrega Contínua com Travis

*Criado por Floor Drees, [@floordrees](https://twitter.com/floordrees)* 

*Traduzido por Joana Souza, [@sspjoana](https://twitter.com/sspjoana)*

### O que é Entrega Contínua ?

Implantação contínua é parte do movimento de entrega contínua. A ideia por detrás da entrega contínua é automatizar o processo de entrega de software o mais rápido possível.

Trabalhando em um lugar com uma cadeia de implantação contínua, você irá fortificar o processo de deploys no Git (tudo deve ser comitado para ser testado e tudo deve ser testado para ser implantado), tornando a colaboração mais fácil e o desenvolvimento mais rápido. Assim, você poderá focar em fazer um app mais incrível!

Há algumas grandes empresas que navegam na onda contínua, neste guia vamos configurar a implantação contínua para o nosso aplicativo Ruby on Rails do GitHub para o anynines, usando Travis-ci.

__COACH__: Fale sobre os benefícios da implantação contínua.

###Github, Travis CI e anynines

A primeira coisa que precisamos é um app com um repositório no Github. E nós temos isso! Após isso você precisará ter certeza que seguiu o tutorial de como fazer deploy para o seu app via anynines até o último passo.

Então, nós criaremos um arquivo chamado `manifest.yml` no diretório principal do seu teu app, lá podemos salvar informação sobre o deployment. No seu terminal execute:

{% highlight sh %}
cf push
{% endhighlight %}

Isso irá disparar o  primeiro deploy para o anynimes. A gem cf irá notar que não existe `manifest.yml`e irá pedir-lhe um conjunto  padrão de perguntas de configuração, tais como o número e tamanho da memória desejado de suas instâncias de aplicativos, se e quais serviços para se ligarem à eles e mais importante, se você deseja armazenar essas informações.

Por favor, responda a esta pergunta com um "hell yes" uma vez que o desejado arquivo `manifest.yml` será criado!

Uma vez que o seu push foi com sucesso, você deve ser capaz de acessar a sua aplicação utilizando um browser de sua escolha, o que significa que você está pronta para configurar o Travis!

Por agora, nós não temos 'testes reais', então iremos adiante e criaremos um arquivo de configuração do Travis que irá falsificar um conjunto de testes de sucesso. Por favor, vá para o diretório local do seu app e crie um arquivo ``.travis.yml``. No momento, cole o seguinte conteúdo. Vamos adicionar mais algumas informações mais tarde

{% highlight sh %}
language: ruby
script: 'true'
{% endhighlight %}

Seu aplicativo agora contém a configuração do Travis, mas como o Travis deve saber como puxar o seu código do Github e disparar a execução do teste? É aí que o Github hooks entra em cena!

#### Travis CI Github hook activation

Comite e envie as mudanças do seu código para o seu repositório e cheque o check travis-ci.org para ver se o seu conjunto de testes está sendo executado. Você deve também receber um email de que a sua build foi bem sucedida.

{% highlight sh %}
git add .  
git commit -m "test Travis integration"  
git push origin master
{% endhighlight %}

Agora podemos configurar a implantação real.
Vamos usar a gem do travis:
{% highlight sh %}
gem install travis
{% endhighlight %}

Agora use o comando `travis` para configurar as anynies de implantação.
{% highlight sh %}
travis setup cloudfoundry
{% endhighlight %}

No caso de você não saber a URL do anynies, use
{% highlight sh %}
cf target
{% endhighlight %}

para reunir todas as informações necessárias para a configuração do Travis. Isso inclui URL de destino, nome de usuário, a organização e espaço que você está usando atualmente. Você pode também dar uma olhada no email de boas vindas que você deve ter recebido após se inscrever no anynines.com.

Após o comando `travis` ter finalizado, seu ``.travis.yml``deve parecer algo como isso:
{% highlight sh %}
language: ruby
script: 'true'
deploy:
  provider: cloudfoundry
  target: https://api.de.a9s.eu
  username: jane.doe@example.com
  password:
    secure: your encryped password determined by the travis gem=
  organization: railsgirls
  space: heaven
  on:
    repo: jane/railsgirls
{% endhighlight %}

Não esqueça de comitar e enviar suas mudanças para ``.travis.yml`` uma vez que será necessário em seu repositório Github para fazer efeito.

De agora em diante, sempre que você cometer alterações ao seu repositório GitHub, os testes serão executados e sua aplicação será implantada. O Travis irá então mostrar uma saída de log semelhante a esta:

{% highlight sh %}
Installing deploy dependencies
Fetching: addressable-2.3.5.gem (100%)
Successfully installed addressable-2.3.5
Fetching: multi_json-1.7.9.gem (100%)
Successfully installed multi_json-1.7.9
Fetching: caldecott-client-0.0.2.gem (100%)
Successfully installed caldecott-client-0.0.2
Fetching: i18n-0.6.5.gem (100%)
Successfully installed i18n-0.6.5
Fetching: tzinfo-0.3.37.gem (100%)
Successfully installed tzinfo-0.3.37
Fetching: minitest-4.7.5.gem (100%)
Successfully installed minitest-4.7.5
Fetching: atomic-1.1.13.gem (100%)
Building native extensions.  This could take a while...
Successfully installed atomic-1.1.13
Fetching: thread_safe-0.1.2.gem (100%)
Successfully installed thread_safe-0.1.2
Fetching: activesupport-4.0.0.gem (100%)
Successfully installed activesupport-4.0.0
Fetching: builder-3.1.4.gem (100%)
Successfully installed builder-3.1.4
Fetching: activemodel-4.0.0.gem (100%)
Successfully installed activemodel-4.0.0
Fetching: cf-uaa-lib-2.0.0.gem (100%)
Successfully installed cf-uaa-lib-2.0.0
Fetching: multipart-post-1.2.0.gem (100%)
Successfully installed multipart-post-1.2.0
Fetching: rubyzip-0.9.9.gem (100%)
Successfully installed rubyzip-0.9.9
Fetching: cfoundry-4.3.6.gem (100%)
Successfully installed cfoundry-4.3.6
Fetching: interact-0.5.2.gem (100%)
Successfully installed interact-0.5.2
Fetching: json_pure-1.8.0.gem (100%)
Successfully installed json_pure-1.8.0
Fetching: mothership-0.5.1.gem (100%)
Successfully installed mothership-0.5.1
Fetching: mime-types-1.25.gem (100%)
Successfully installed mime-types-1.25
Fetching: rest-client-1.6.7.gem (100%)
Successfully installed rest-client-1.6.7
Fetching: uuidtools-2.1.4.gem (100%)
Successfully installed uuidtools-2.1.4
Fetching: cf-5.2.2.gem (100%)
Successfully installed cf-5.2.2
22 gems installed
dpl.2
Preparing deploy
Setting target to https://api.de.a9s.eu...... OK
target: https://api.de.a9s.eu
Authenticating.. .  ... OK
Switching to organization railsgirls... OK
Switching to space heaven... OK
dpl.3
Deploying application
Using manifest file manifest.yml
Uploading railsgirls... OK
Stopping railsgirls... OK
Preparing to start railsgirls... OK
Checking status of app 'railsgirls'...
  0 of 1 instances running (1 starting)
  0 of 1 instances running (1 starting)
  1 of 1 instances running (1 running)
Push successful! App 'railsgirls' available at http://railsgirls.de.a9sapp.eu
Logging out... OK
{% endhighlight %}

Isso quer dizer que você já terminou e está pronta para a próxima! 