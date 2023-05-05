---
layout: default
title: Deploy contínuo - muito menos complicado
permalink: continuous
---

# Deploy contínuo com _Codeship_

*Created by Floor Drees, [@floordrees](https://twitter.com/floordrees)*
*Traduzido por Bárbara Barbosa [@bahbbc](https://twitter.com/bahbbc)*

### O que é esse tal de deploy contínuo?

Deploy contínuo é parte de um 'movimento' de entrega contínua. A ideia por trás da entrega contínua é a automação do máximo possível do processo de entrega de software.

Com um ambiente de deploy contínuo funcionando é possível implantar Deploys via Git (Deverá ser realizado o _commit_ de tudo antes de testar e tudo deve ser testado antes do deploy), tornando a colaboração mais fácil e o deploy mais rápido. Então você pode focar em fazer o seu aplicativo ainda mais legal!

Existem algumas empresas muito legais velejando a onda do deploy contínuo, nesse guia nos iremos configurar um ambiente de deploy contínuo para um aplicativo Ruby on Rails do Github para o Heroku, usando o [_Codeship_](http://www.codeship.io).

__INSTRUTOR(A)__: Falar sobre os benefícios do deploy contínuo.

### Conta no _Codeship_

Primeiramente, você vai precisar de [uma conta no _Codeship_](https://www._codeship_.io/). Inscreva-se no _Codeship_ com o Github. O _Codeship_ precisa de acesso aos seus repositórios do Github para aprontá-los, então tenha certeza de garantir o acesso.

Voltando no _Codeship_, vamos criar o nosso primeiro projeto. O primeiro passo para isso é selecionar o Github como o seu providor de repositório. Na lista dos seus repositórios do Github, busque o repositório que você quer configurar e selecione-o. No nosso caso, é o que está escrito algo tipo "railsgirls".

Agora o seu repositório está conectado e você pode configurar os seus comandos de teste. Nós criamos uma aplicação Ruby on Rails. Então selecione "Ruby on Rails" como o framework que usaremos. Isso configura os comandos de inicialização e os comandos de testes para você. Deletando a cerquilha (`#`) você pode descomentar os comandos de teste que você quiser usar para a sua aplicação. Por enquanto você não deve ter testes para configurar ainda, então você pode pular esse passo e voltar a ver isso depois.

Agora vamos finalizar a configuração e ir para o painel de controle. Você pode ativar o chamado 'novo _build_' (new _build_) para a sua aplicação mudando alguma coisa e dando _push_ no seu repositório:

{% highlight sh %}
git add .
git commit -m "teste integracao Codeship"
git push origin master
{% endhighlight %}

Você pode acessar os detalhes da construção do app (_build_) clicando na seta da direita. Aqui você pode acompanhar o _build_ enquanto ele ainda está rodando. Melhor que Big Brother - eu prometo.

... e alguns segundos depois o seu _build_ está completo! Você pode ver todos os comandos que rodaram. Depois de alguns comandos iniciais de preparação o _Codeship_ roda os comandos os comandos que você especificou há alguns momentos atrás. Você pode ver a saída de um único comando clicando nele.

Você já mandou um _push_ no seu repositório, viu o log do seu _build_ e recebeu um _build_ verde. Então você pode finalizar o assistente no começo clicando no botão "Clique para finalizar" ("click to finish").

### Configurando o deploy contínuo

Agora vamos fazer o deploy da nossa aplicação no Heroku. Vá para a configuração do seu projeto no ícone de configuração no menu do _Codeship_. Então navegue até a seção "Deployment". Como você quer fazer deploy no Heroku, clique no botão "Heroku".

Você precisará colocar o nome da sua aplicação no Heroku e a sua chave da API. Espero que você a tenha escrito em algum lugar! Coloque o nome da sua aplicação e a sua chave da API (para recuperar a sua chave da API, vá para a sua conta no Heroku e clique _"Show API key"_) e save a sua configuração de deploy.

De agora em diante o _Codeship_ irá fazer deploy automática do seu aplicativo no Heroku, toda vez que você fizer um _push_ no seu repositório do Github. Da hora!

### Faça um teste
Agora vamos fazer um _push_ com uma mudança e ver o que foi para deploy. Mude alguma coisa na sua aplicação primeiro, e depois faça um _commit_ e um _push_ com a mudança.

{% highlight sh %}
git add .
git commit -m "isso muda tudo"
git push
{% endhighlight %}

E imediatamente outro _build_ começará a rodar no _Codeship_. Volte ao seu projeto e você verá os comandos que nós já conhecemos do seu primeiro _build_. Bônus: A sua aplicação vai subir no Heroku e deve estar online depois de um minuto ou dois.

{% include other-guides.md page="continuous" %}
