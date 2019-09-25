---
layout: default
title: Continuous Deployment - cuz less hassle
permalink: continuous-snap-ci
---

# Deploy Contínuo com Snap CI

*Criado por Akshay Karle, [@akshay_karle](https://twitter.com/akshay_karle)*

### O que é essa coisa de Deploy Contínuo?

O deploy contínuo, ou melhor, implantação contínua é parte do "movimento" de
entrega contínua. A ideia por trás da entrega contínua é a de automatizar o
processo de entrega o máximo possível.

Quando você trabalha com uma cadeia de implantação contínua, você força a
implantação via Git (tudo precisa estar commitado para ser testado e tudo
precisa ser testado para ser de fato implantado), fazendo com que a colaboração
seja mais simples e a implantação seja mais rápida. Dessa forma, você pode focar
em fazer a sua aplicação ainda melhor!

Existem várias empresas navegando na onda da entrega contínua, mas nesse guia
vamos usar a implantação contínua da nossa aplicação Ruby on Rails do GitHub
para o Heroku usando o [Snap CI](https://snap-ci.com).

__INSTRUTOR(A)__: Fale sobre os benefícios da implantação contínua.

### Se inscrevendo no Snap CI

Primeiro, você vai precisar de [uma conta do Snap CI](https://snap-ci.com/).
Se inscreva no Snap CI com sua conta do GitHub. O Snap CI precisa ter acesso aos seus
repositórios para conseguir arrumar os ambientes, então certifique-se de que
você está permitindo isso.

De volta ao Snap CI, vamos criar nosso primeiro pipeline. O primeiro passo é
selecionar o GitHub como seu provedor de repositórios. Após isso, na lista dos seus
repositórios do GitHub, procure pelo repositório que deseja fazer o processo
de implantação e o selecione.
No nosso caso, é o repositório que tem um nome como "railsgirls".

Uma vez que você selecionou o repositório que deseja fazer o <em lang="en">build</em>, o Snap
CI vai tentar montar automaticamente o melhor setup para seu
[pipeline de implantação](http://martinfowler.com/bliki/DeploymentPipeline.html),
o que permitirá a você rodar seus testar e implantação.

Depois de alguns segundos, Snap CI vai automaticamente começar o <em lang="en">build</em> do
seu repositório. Nesse ponto, você pode clicar entre os estágios de setup do
Snap CI pra ver que tipo de comandos ele roda.

Existe, contudo, a possiblidade de o Snap CI não conseguir detectar os comandos
certos pra fazer o <em lang="en">build</em> e testar o seu repositório. Nesses casos, você pode editar
as configurações do seu pipeline visitando a página de Configurations
(Configurações) na página de Builds do seu recém-criado pipeline, por fim
acessando a opção "Edit" (Editar). Nessa opção, você pode adicionar ou editar
um estágio existente que vai fazer o <em lang="en">build</em> rodar todos os testes da sua
aplicação.

Se você não tem certeza dos estágios que deve adicionar, você pode dar uma
olhada nas diferentes receitas de Build que ficam na sub-categoria Ruby quando
você vai adicionar um estágio. Essas receitas podem te ajudar a entender que
tipo de comando devem ser rodados para fazer o <em lang="en">build</em> e testar sua aplicação
corretamente. Você também pode checar o
[getting started guide](https://docs.snap-ci.com/getting-started/) (guia para
começar) na documentação do Snap CI.

Uma vez que você terminou de editar a sua configuração de pipeline, clique em
"Save". Isso vai salvar suas configurações e automaticamente iniciar um novo
<em lang="en">build</em>. Se todos os seus testes passaram corretamente, você agora deve ter um
<em lang="en">build</em> verde.

No caso de algum teste ter falhado, você pode fazer as correções e subir para
o seu repositório no GitHub:

{% highlight sh %}
git add .
git commit -m "ajustando testes"
git push origin master
{% endhighlight %}

O Snap CI vai automaticamente detectar as mudanças do GitHub e rodar uma nova
instância do pipeline. Neste ponto, você já está testando o seu código.

### Fazendo o Setup da Implantação Contínua

O próximo passo é implantar a nossa aplicação. Existem várias plataformas para
realizar essa tarefa, mas, por agora, vamos focar em como implantar no
[Heroku](https://www.heroku.com/), já que é o mais simples.

Vá até a página de edição de configuração do seu pipeline e adicione um novo
estágio (Stage). Dessa vez, selecione a categoria "Deploy" disponível nas
receitas à esquerda. Depois, selecione a receite "Basic" na sub-categoria
"Heroku".

Escolha e digite um nome de estágio de sua escolha (ex: deploy, implantacao,
producao, etc), mantenha o trigger automático, clique no dropdown "Run as" para
entrar no Heroku. Entre no Heroku e autorize o Snap CI. Você deve ser
automaticamente redirecionado de volta para a página do Snap CI após a
autorização. Agora você pode selecionar a aplicação do Heroku que você deseja
fazer a implantação ou criar uma nova aplicação diretamente do Snap CI.
Selecione a opção "Perform DB migrate" (Fazer a migração de banco de dados) e
salve sua configuração.

Isso deve ativar um novo <em lang="en">build</em> no Snap CI, mas dessa vez ele roda o estágio que
você acabou de criar, que é responsável por fazer a implantação no Heroku. Uma
vez que o pipeline fica verde, você pode visitar a página da aplicação no
Heroku onde você implantou direto do Snap CI e sua aplicação rails deve estar
online em alguns minutos.

A partir daqui, quaisquer mudanças que você fizer e subir para o seu GitHub vão
ser testadas e implantadas automaticamente pelo Snap CI.

