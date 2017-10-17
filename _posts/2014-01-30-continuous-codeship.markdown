---
layout: default
title: Deploy contínuo - muito menos complicado
permalink: continuous
---

# Deploy contínuo com <em lang="en">Codeship</em>

*Created by Floor Drees, [@floordrees](https://twitter.com/floordrees)*
*Traduzido por Bárbara Barbosa [@bahbbc](https://twitter.com/bahbbc)*

### O que é esse tal de deploy contínuo?

Deploy contínuo é parte de um 'movimento' de entrega contínua. A ideia por trás da entrega contínua é a automação do máximo possível do processo de entrega de software.

Com um ambiente de deploy contínuo funcionando é possível implantar Deploys via Git (Deverá ser realizado o <em lang="en">commit</em> de tudo antes de testar e tudo deve ser testado antes do deploy), tornando a colaboração mais fácil e o deploy mais rápido. Então você pode focar em fazer o seu aplicativo ainda mais legal!

Existem algumas empresas muito legais velejando a onda do deploy contínuo, nesse guia nos iremos configurar um ambiente de deploy contínuo para um aplicativo Ruby on Rails do Github para o Heroku, usando o [<em lang="en">Codeship</em>](http://www.<em lang="en">codeship</em>.io).

__INSTRUTOR(A)__: Falar sobre os beneficios do deploy contínuo.

### Conta no <em lang="en">Codeship</em>

Primeiramente, você vai precisar de [uma conta no <em lang="en">Codeship</em>](https://www.<em lang="en">codeship</em>.io/). Inscreva-se no <em lang="en">Codeship</em> com o Github. O <em lang="en">Codeship</em> precisa de acesso aos seus repositórios do Github para aprontá-los, então tenha certeza de garantir o acesso.

Voltando no <em lang="en">Codeship</em>, vamos criar o nosso primeiro projeto. O primeiro passo para isso é selecionar o Github como o seu providor de repositório. Na lista dos seus repositórios do Github, busque o respósitorio que você quer configurar e selecione-o. No nosso caso, é o que está escrito algo tipo "railsgirls".

Agora o seu repositório está conectado e você pode configurar os seus comandos de teste. Nós criamos uma aplicação Ruby on Rails. Então selecione "Ruby on Rails" como o framework que usaremos. Isso configura os comandos de inicialização e os comandos de testes para você. Deletando a cerquilha (`#`) você pode descomentar os comandos de teste que você quiser usar para a sua aplicação. Por enquanto você não deve ter tester para configurar ainda, então você pode pular esse passo e voltar a ver isso depois.

Agora vamos finalizar a configuração e ir para o painel de controle. Você pode ativar o chamado 'novo <em lang="en">build</em>' (new <em lang="en">build</em>) para a sua aplicação mudando alguma coisa e dando <em lang="en">push</em> no seu repositório:

{% highlight sh %}
git add .
git commit -m "teste integracao Codeship"
git push origin master
{% endhighlight %}

Você pode acessar os detalhes da construção do app (<em lang="en">build</em>) clicando na seta da direita. Aqui você pode acompanhar o <em lang="en">build</em> enquanto ele ainda está rodando. Melhor que Big Brother - eu prometo.

... e alguns segundos depois o seu <em lang="en">build</em> está completo! Você pode ver todos os comandos que rodaram. Depois de alguns comandos iniciais de preparação o <em lang="en">Codeship</em> roda os comandos os comandos que você especificou há alguns momentos atrás. Você pode ver a saída de um único comando clicando nele.

Você já mandou um <em lang="en">push</em> no seu repositório, viu o log do seu <em lang="en">build</em> e recebeu um <em lang="en">build</em> verde. Então você pode finalizar o assistente no começo clicando no botão "Clique para finalizar" ("click to finish").

### Configurando o deploy contínuo

Agora vamos fazer o deploy da nossa aplicação no Heroku. Vá para a configuração do seu projeto no ícone de configuração no menu do <em lang="en">Codeship</em>. Então navegue até a seção "Deployment". Como você quer fazer deploy no Heroku, clique no botão "Heroku".

Você precisará colocar o nome da sua aplicação no Heroku e a sua chave da API. Espero que você a tenha escrito em algum lugar! Coloque o nome da sua aplicação e a sua chave da API (para recuperar a sua chave da API, vá para a sua conta no Heroku e clique <em lang="en">"Show API key"</em>) e save a sua configuração de deploy.

De agora em diante o <em lang="en">Codeship</em> irá fazer deploy automática do seu aplicativo no Heroku, toda vez que você fizer um <em lang="en">push</em> no seu repositório do Github. Da hora!

### Faça um teste
Agora vamos fazer um <em lang="en">push</em> com uma mudança e ver o que foi para deploy. Mude alguma coisa na sua aplicação primeiro, e depois faça um <em lang="en">commit</em> e um <em lang="en">push</em> com a mudança.

{% highlight sh %}
git add .
git commit -m "isso muda tudo"
git push
{% endhighlight %}

E imediatamente outro <em lang="en">build</em> começará a rodar no <em lang="en">Codeship</em>. Volte ao seu projeto e você verá os comandos que nós já conhecemos do seu primeiro <em lang="en">build</em>. Bônus: A sua aplicação vai subir no Heroku e deve estar online depois de um minuto ou dois.
