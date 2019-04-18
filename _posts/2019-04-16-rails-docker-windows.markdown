---
layout: default
title: Rails com Docker no Windows
permalink: rails-docker-windows
---

# Rails com Docker no Windows

_Criado por Jéssica Zanelato, [@jessizanelato](https://twitter.com/jessizanelato)_

<p>Para desenvolver com Ruby on Rails é necessário configurar o ambiente de desenvolvimento em nosso computador. Se você usa Windows este processo pode se tornar complexo e desanimador.
Este tutorial tem como objetivo tornar o processo de configuração mais rápido e fácil com a utilização de Docker.</p>

<p>Já ouviu falar em Docker? Docker é tipo uma máquina virtual dentro da sua máquina real. Dessa forma você pode ter qualquer ambiente de desenvolvimento na sua máquina sem conflitos e dor de cabeça.  
Por exemplo se tivermos um projeto que roda a versão 2.0 de ruby (ou rails) e outro projeto que roda a versão atual (x.x.x), podemos configurar essa máquina virtual para rodar de acordo com a especifidade do projeto.</p>

<p>E como faço essa mágica acontecer? Primeiramente você precisará instalar o software do Docker na sua máquina. Existem duas versões, uma para Windows 10 (Pro ou Enterprise) e outra para Windows 10 Basic e Windows 8.  
Utilize os links abaixo para efetuar o download de acordo com o seu sistema operacional:</p>

[Docker CE para Windows 10 (Pro ou Enterprise)](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

[Docker Toolbox para Windows 10 (Basic) e 8](https://docs.docker.com/toolbox/overview/)

## Instruções Docker CE

Abra o prompt de comando do seu sistema operacional e execute este comando para verificar se o Docker foi instalado corretamente:

{% highlight sh %}
docker --version
{% endhighlight %}

Caso não mostre a versão do Docker como esperado, refaça o processo de instalação.

Estando tudo certo vamos prosseguir com a configuração. O próximo passo é fazer o download da “máquina virtual”.

{% highlight sh %}
docker pull jacksonpires/ubuntu-rails-ssh
{% endhighlight %}

O comando acima fará o download da imagem `jacksonpires/ubuntu-rails-ssh`, que é uma máquina virtual criada pelo professor Jackson Pires. Na sequência rode o comando:

{% highlight sh %}
docker run -d -p 30030:3000 -p 20022:22 -v $(pwd):/projects --name railscontainer jacksonpires/ubuntu-rails-ssh
{% endhighlight %}

Esse comando inicializará uma “máquina virtual” baseada na imagem que baixamos e também mapeará a pasta na qual você estiver para dentro do container.  

Caso o comando acima não seja executado com sucesso, tente trocar `$(pwd)` pelo caminho absoluto da sua pasta.
Exemplo:

{% highlight sh %}
docker run -d -p 30030:3000 -p 20022:22 -v C:\projects:/projects --name railscontainer jacksonpires/ubuntu-rails-ssh
{% endhighlight %}

Sendo o primeiro caminho o da pasta na sua máquina real e o segundo o caminho na “máquina virtual”.  

Para acessar a máquina virtual, que é Ubuntu, você deverá sair do prompt de comando e abrir o Git Bash para executar o seguinte comando:

{% highlight sh %}
ssh app@localhost -p 20022
{% endhighlight %}

Após a execução deste comando será solicitada uma senha e você deverá digitar `app` que é a senha padrão para esta máquina virtual.

Para este último comando, caso não tenha Git Bash instalado, poderá utilizar o [Putty](https://www.putty.org/) para fazer a conexão.  

## Instruções Docker Toolbox

Abra o Docker Quickstart Terminal e execute o seguinte comando para verificar se o Docker foi instalado corretamente:

{% highlight sh %}
docker --version
{% endhighlight %}

Caso não mostre a versão do Docker como esperado, refaça o processo de instalação.

Estando tudo certo vamos prosseguir com a configuração. O próximo passo é fazer o download da “máquina virtual”.  

{% highlight sh %}
docker pull jacksonpires/ubuntu-rails-ssh
{% endhighlight %}

O comando acima fará o download da imagem `jacksonpires/ubuntu-rails-ssh`, que é uma máquina virtual criada pelo professor Jackson Pires.  

Acesse pelo terminal a pasta em que deseja salvar seus projetos e execute o seguinte comando:

{% highlight sh %}
docker run -d -p 30030:3000 -p 20022:22 -v $(pwd):/projects --name railscontainer jacksonpires/ubuntu-rails-ssh
{% endhighlight %}

Esse comando inicializará uma “máquina virtual” baseada na imagem que baixamos e também mapeará a pasta na qual você estiver para dentro do container.  

Não é preciso alterar nada no comando, sendo o primeiro caminho o da pasta na sua máquina real e o segundo o caminho na “máquina virtual”.  

Para acessar a máquina virtual, que é Ubuntu, você executará o seguinte comando:

{% highlight sh %}
ssh app@192.168.99.100 -p 20022
{% endhighlight %}

Após a execução deste último comando será solicitada uma senha e você deverá digitar `app` que é a senha padrão para esta máquina virtual.

## Dentro da máquina virtual

Ao entrar no container você poderá verificar as versões do Ruby e do Rails, executando:

{% highlight sh %}
ruby -v
{% endhighlight %}

e 

{% highlight sh %}
rails -v
{% endhighlight %}

Acesse a pasta `/projects` usando o seguinte comando:

{% highlight sh %}
cd /projects/
{% endhighlight %}

Prontinho. Nesse momento você poderá criar uma aplicação Rails para fazer um teste. Execute:

{% highlight sh %}
rails new railsgirls
{% endhighlight %}

Após a aplicação ser criada, entre na pasta e inicie o servidor Rails.
{% highlight sh %}
cd railsgirls
{% endhighlight %}

{% highlight sh %}
rails s -b 0.0.0.0
{% endhighlight %}

Agora é só acessar o navegador indicando a porta para qual foi mapeada a porta 3000. Podendo ser http://localhost:30030 (Docker CE) ou http://192.168.99.100:30030 (Docker Toolbox).


**Parabéns, você chegou até aqui! Que tal agora criar sua primeira aplicação?  As instruções podem ser encontrada em: [guides.railsgirls.com/guides-ptbr/app](http://guides.railsgirls.com/guides-ptbr/app).**

## Alguns erros que podem acontecer:

1. Ao acessar o localhost poderá aparecer uma mensagem de erro relacionado com a gem do sqlite3. Para resolver, abra o arquivo `Gemfile` que estará no endereço `C:\projects\railsgirls\Gemfile`. Altere onde estiver escrito `'sqlite3'` para `'sqlite3', '~> 1.3.6'`.
Após editar e salvar acesse a máquina virtual e execute os seguintes comandos: `bundle install` e `rails s -b 0.0.0.0`. Acesse novamente no seu navegador http://localhost:30030 ou http://192.168.99.100:30030.

1. Ao acessar por ssh a máquina, caso receba a mensagem de `connection refused`, execute o comando `docker-machine ip` para descobrir o IP da máquina virtual. Troque o localhost pelo IP correspondente.

2. Ao executar o comando `rails new railsgirls` caso mostre a mensagem `permission denied` acesse a pasta `projects` e execute os comandos `sudo mkdir railsgirls` e `sudo chmod 777 railsgirls`. Os comandos anteriores servem para criar e dar permissão de escrita para uma pasta. Agora execute novamente o comando `rails new railsgirls`.

## Comandos Docker úteis:

A seguir alguns comandos que serão úteis na utilização do docker e sua máquina virtual. Lembrando que todos deverão ser executado no terminal da sua máquina real.

Listar todos os containers em funcionamento
{% highlight sh %}docker container ls{% endhighlight %}

Parar um container
{% highlight sh %}docker container stop railscontainer{% endhighlight %}

Listar todos os containers (mesmo os parados)
{% highlight sh %}docker container ls -a{% endhighlight %}

Iniciar um container
{% highlight sh %}docker container start railscontainer{% endhighlight %}

Listar as portas do container
{% highlight sh %}docker port railscontainer{% endhighlight %}

Descobrir o IP da máquina
{% highlight sh %}docker-machine ip{% endhighlight %}
 

<hr/>

Um agradecimento especial ao professor Jackson Pires por disponibilizar o [artigo](https://medium.com/@jacksonpires/usando-docker-para-desenvolver-com-ruby-on-rails-3eff32d05006) que serviu de inspiração para este tutorial. Caso tenha algum problema com a imagem, favor abrir uma issue em: [github.com/jacksonpires/docker-rails](https://github.com/jacksonpires/docker-rails).  

