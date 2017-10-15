---
layout: default
title: Deploy contínuo - muito menos complicado
permalink: continuous
---

# Deploy contínuo com Codeship

*Created by Floor Drees, [@floordrees](https://twitter.com/floordrees)*
*Traduzido por Bárbara Barbosa [@bahbbc](https://twitter.com/bahbbc)*

### O que é esse tal de deploy contínuo?

Deploy contínuo é parte de um 'movimento' de entrega contínua. A ideia por trás da entrega contínua é a automação do máximo possível do processo de entrega de software.

Com um ambiente de deploy contínuo funcionando é possível implantar Deploys via Git (Deverá ser realizado o commit de tudo antes de testar e tudo deve ser testado antes do deploy), tornando a colaboração mais fácil e o deploy mais rápido. Então você pode focar em fazer o seu aplicativo ainda mais legal!

Existem algumas empresas muito legais velejando a onda do deploy contínuo, nesse guia nos iremos configurar um ambiente de deploy contínuo para um aplicativo Ruby on Rails do Github para o Heroku, usando o [Codeship](http://www.codeship.io).

__TREINADOR__: Falar sobre os beneficios do deploy contínuo.

### Conta no Codeship

Primeiramente, você vai precisar de [uma conta no Codeship](https://www.codeship.io/). Inscreva-se no Codeship com o Github. O Codeship precisa de acesso aos seus repositórios do Github para aprontá-los, então tenha certeza de garantir o acesso.

Voltando no Codeship, vamos criar o nosso primeiro projeto. O primeiro passo para isso é selecionar o Github como o seu providor de repositório. Na lista dos seus repositórios do Github, busque o respósitorio que você quer configurar e selecione-o. No nosso caso, é o que está escrito algo tipo "railsgirls".

Agora o seu repositório está conectado e você pode configurar os seus comandos de teste. Nós criamos uma aplicação Ruby on Rails. Então selecione "Ruby on Rails" como o framework que usaremos. Isso configura os comandos de inicialização e os comandos de testes para você. Deletando a cerquilha (`#`) você pode descomentar os comandos de teste que você quiser usar para a sua aplicação. Por enquanto você não deve ter tester para configurar ainda, então você pode pular esse passo e voltar a ver isso depois.

Agora vamos finalizar a configuração e ir para o painel de controle. Você pode ativar o chamado 'novo build' (new build) para a sua aplicação mudando alguma coisa e dando push no seu repositório:

{% highlight sh %}
git add .
git commit -m "teste integracao Codeship"
git push origin master
{% endhighlight %}

Você pode acessar os detalhes do build clicando na seta da direita. Aqui você pode acompanhar o build enquanto ele ainda está rodando. Melhor do Big Brother - eu prometo.

... e alguns segundos depois o seu build está completo! Você pode ver todos os comandos que rodaram. Depois de alguns comandos iniciais de preparação o Codeship roda os comandos os comandos que você especificou há alguns momentos atrás. Você pode ver a saída de um único comando clicando nele.

Você já mandou um push no seu repositório, viu o log do seu build e recebeu um build verde. Então você pode finizar o assistente no começo clicando no botão "Clique para finalizar" ("click to finish").

### Configurando o deploy contínuo

Agora vamos fazer o deploy da nossa aplicação no Heroku. Vá para a configuração do seu projeto no ícone de configuração no menu do Codeship. Então navegue até a seção "Deployment". Como você quer fazer deploy no Heroku, clique no botão "Heroku".

Você precisará colocar o nome da sua aplicação no Heroku e a sua chave da API. Espero que você a tenha escrito em algum lugar! Coloque o nome da sua aplicação e a sua chave da API (para recuperar a sua chave da API, vá para a sua conta no Heroku e clique "Show API key") e save a sua configuração de deploy.

De agora em diante o Codeship irá fazer deploy automática do seu aplicativo no Heroku, toda vez que você fizer um push no seu repositório do Github. Da hora!

### Faça um teste
Agora vamos fazer um push com uma mudança e ver o que foi para deploy. Mude alguma coisa na sua aplicação primeiro, e depois faça um commit e um push com a mudança.

{% highlight sh %}
git add .
git commit -m "isso muda tudo"
git push
{% endhighlight %}

E imediatamente outro build começará a rodar no Codeship. Volte ao seu projeto e você verá os comandos que nós já conhecemos do seu primeiro build. Bônus: A sua aplicação vai subir no Heroku e deve estar online depois de um minuto ou dois.
