---
layout: default
title: Rails com Docker no Windows
permalink: rails-docker-windows
---

# Tutorial de instalação do Rails com Docker no Windows

Para desenvolver com Ruby on Rails é necessário configurar o ambiente de desenvolvimento em nosso computador. Se você usa Windows este processo pode se tornar complexo e desanimador.
Este tutorial tem como objetivo tornar o processo de configuração mais rápido e fácil com a utilização de Docker.  
Já ouviu falar em Docker? Docker é tipo uma máquina virtual dentro da sua máquina real. Dessa forma você pode ter qualquer ambiente de desenvolvimento na sua máquina sem conflitos e dor de cabeça.  
E como faço essa mágica acontecer? Primeiramente você precisará instalar o software do Docker na sua máquina. Existem duas versões, uma para Windows 10 (Pro ou Enterprise) e outra para Windows 10 Basic e Windows 8.  
Utilize os links abaixo para efetuar o download de acordo com o seu sistema operacional:

[Docker CE para Windows 10 (Pro ou Enterprise)](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

[Docker Toolbox para Windows 10 (Basic) e 8](https://docs.docker.com/toolbox/overview/)

## Instruções Docker CE

Abra o prompt de comando do seu sistema operacional e execute este comando para verificar se o Docker foi instalado corretamente:

<pre>docker --version</pre>

Caso não mostre a versão do Docker como esperado, refaça o processo de instalação.

Estando tudo certo vamos prosseguir com a configuração. O próximo passo é fazer o download da “máquina virtual”.

<pre>docker pull jacksonpires/ubuntu-rails-ssh</pre>

O comando acima fará o download da imagem <i>jacksonpires/ubuntu-rails-ssh</i>, que é uma máquina virtual criada pelo professor Jackson Pires. Na sequência rode o comando:

<pre>docker run -d -P -v $(pwd):/projects --name railscontainer jacksonpires/ubuntu-rails-ssh</pre>

Esse comando inicializará uma “máquina virtual” baseada na imagem que baixamos e também mapeará a pasta na qual você estiver para dentro do container.  

Não é preciso alterar nada no comando, sendo o primeiro caminho o da pasta na sua máquina real e o segundo o caminho na “máquina virtual”.  

Para que possamos acessar esta “máquina virtual” por SSH (porta 22) é necessário verificar qual a porta correspondente na sua máquina. Para isso execute o seguinte comando:

<pre>docker port railscontainer</pre>

O retorno será algo como este do exemplo, com exceção do número das portas em negrito que poderá sofrer alteração:

<pre>
22/tcp -> 0.0.0.0:<b>32785</b>
3000/tcp -> 0.0.0.0:<b>32784</b>
</pre>

Para acessar a máquina virtual, que é Ubuntu, você deverá sair do prompt de comando e abrir o Git Bash para executar o seguinte comando:

<pre>ssh app@localhost -p <b>32785</b></pre>

Perceba que o número da porta (em negrito) é o mesmo do equivalente a porta 22 na sua máquina (do comando anterior). Após a execução deste comando será solicitada uma senha e você deverá digitar “app” que é a senha padrão para esta máquina virtual.

Para este último comando, caso não tenha Git Bash instalado, poderá utilizar o [Putty](https://www.putty.org/) para fazer a conexão.  

## Instruções Docker Toolbox

Abra o Docker Quickstart Terminal e execute o seguinte comando para verificar se o Docker foi instalado corretamente:

<pre>docker --version</pre>

Caso não mostre a versão do Docker como esperado, refaça o processo de instalação.

Estando tudo certo vamos prosseguir com a configuração. O próximo passo é fazer o download da “máquina virtual”.  

<pre>docker pull jacksonpires/ubuntu-rails-ssh</pre>

O comando acima fará o download da imagem <i>jacksonpires/ubuntu-rails-ssh</i>, que é uma máquina virtual criada pelo professor Jackson Pires.  

Acesse pelo terminal a pasta em que deseja salvar seus projetos e execute o seguinte comando:

<pre>docker run -d -P -v $(pwd):/projects --name railscontainer jacksonpires/ubuntu-rails-ssh</pre>

Esse comando inicializará uma “máquina virtual” baseada na imagem que baixamos e também mapeará a pasta na qual você estiver para dentro do container.  

Não é preciso alterar nada no comando, sendo o primeiro caminho o da pasta na sua máquina real e o segundo o caminho na “máquina virtual”.   

Para que possamos acessar esta “máquina virtual” por SSH (porta 22) é necessário verificar qual a porta correspondente na máquina real. Para isso execute o seguinte comando:

<pre>docker port railscontainer</pre>

O retorno será algo como este do exemplo, com exceção do número das portas em negrito que poderá sofrer alteração:

<pre>
22/tcp -> 0.0.0.0:<b>32785</b>
3000/tcp -> 0.0.0.0:<b>32784</b>
</pre>

Para acessar a máquina virtual, que é Ubuntu, você executará o seguinte comando, alterando o número em negrito de acordo com os dados acima:

<pre>ssh app@192.168.99.100 -p <b>32785</b></pre>

Após a execução deste último comando será solicitada uma senha e você deverá digitar “app” que é a senha padrão para esta máquina virtual.

## Dentro da máquina virtual

Ao entrar no container você poderá verificar as versões do Ruby e do Rails, rodando…

<pre>ruby -v</pre>

e 

<pre>rails -v</pre>

Acesse a pasta “/projects” usando o seguinte comando:

<pre>cd /projects/</pre>

Prontinho. Nesse momento você poderá criar uma aplicação Rails para fazer um teste. Execute:

<pre>rails new railsgirls</pre>

Após a aplicação ser criada, entre na pasta e inicie o servidor Rails.
<pre>cd railsgirls</pre>
<pre>rails s -b 0.0.0.0</pre>

Agora é só acessar o navegador no endereço localhost indicando a porta para qual foi mapeada a porta 3000. Podendo ser http://localhost:32784 (Docker CE) ou http://192.168.99.100:32784 (Docker Toolbox).

## Alguns erros que podem acontecer:

1. Ao acessar o localhost poderá aparecer uma mensagem de erro relacionado com a gem do sqlite3. Para resolver, acesse seu projeto na sua máquina real com o comando: <pre>C:\projects\railsgirls\Gemfile</pre> Altere onde estiver escrito <i>'sqlite3'</i> para <i>'sqlite3', '~> 1.3.6'</i>.
Na sua máquina virtual execute os seguintes comandos: <pre>bundle install</pre> <pre>rails s -b 0.0.0.0</pre> Acesse novamente no seu navegador http://localhost:32784 ou http://192.168.99.100:32784.

2. Ao acessar por ssh a máquina, caso receba a mensagem de <i>“connection refused”</i>, execute o comando <pre>docker-machine ip</pre> para descobrir o IP da máquina virtual. Troque o localhost pelo IP correspondente.

3. Ao executar o comando <pre>rails new railsgirls</pre> caso mostre a mensagem <i>“permission denied”</i> acesse a pasta <i>projects</i> e execute o seguinte <pre>sudo mkdir railsgirls</pre> posteriormente <pre>sudo chmod 777 railsgirls</pre> Execute novamente o comando <pre>rails new railsgirls</pre> sem problemas, pois o diretório já foi criado com a permissão certa de escrita.

## Comandos Docker úteis:

A seguir alguns comandos que serão úteis na utilização do docker e sua máquina virtual. Lembrando que todos deverão ser executado no terminal da sua máquina real.

#Listar todos os containers em funcionamento
<pre>docker container ls</pre>

#Parar um container
<pre>docker container stop railscontainer</pre>

#Listar todos os containers (mesmo os parados)
<pre>docker container ls -a</pre>

#Iniciar um container
<pre>docker container start railscontainer</pre>

#Listar as portas do container
<pre>docker port railscontainer</pre>

#Descobrir o IP da máquina
<pre>docker-machine ip</pre>

Um agradecimento especial ao professor Jackson Pires por disponibilizar o [artigo](https://medium.com/@jacksonpires/usando-docker-para-desenvolver-com-ruby-on-rails-3eff32d05006) que serviu de inspiração para este tutorial.

