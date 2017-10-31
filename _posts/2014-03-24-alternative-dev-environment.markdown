---
layout: default
title: Ambiente de desenvolvimento alternativo usando VirtualBox
permalink: virtual-machine
---

# Introdução

Um ambiente de desenvolvimento é a soma de todas as aplicações e ferramentas, com as quais uma desenvolvedora pode trabalhar diariamente. Além de um navegador e de um editor de código, todos os programas necessários para rodar e servir nossa aplicação estão incluídos no ambiente. Para desenvolvimento em Ruby on Rails, certamente precisaremos de Ruby e do framework Rails, além de um banco de dados, um servidor para aplicações web, etc.
Uma desenvolvedora experiente, por padrão, instalaria todas essas ferramentas em seu ambiente, mas isso é uma tarefa avançada. Além disso, se vocês estão trabalhando em sistemas operacionais diferentes, a maioria de vocês está trabalhando no Windows, onde instalar um ambiente adequado de desenvolvimento com Ruby é um problema enorme.

Considerando tudo o que falamos acima, criamos um ambiente de desenvolvimento virtual para o primeiro evento Rails Girls - Budapeste, com a esperança de que poderíamos facilitar a experiência de cada participante.

<!-- more -->

## Máquina Virtual

Uma [máquina virtual (VM)](http://en.wikipedia.org/wiki/Virtual_machine) é uma emulação de um computador, baseada em software.

### Limitações

Para virtualizar um sistema operacional diferente, seu computador precisará usar uma certa quantidade de capacidade de energia e memória. Não recomendamos a virtualização se o seu computador não tem mais do que um núcleo de CPU, e pelo menos 2GB de memória RAM.

# Instalando o ambiente de desenvolvimento

## Ambiente virtual

Criamos uma máquina virtual para você, com todos os programas e ferramentos necessários pré-instalados. Para aquelas que estiverem interessadas nos parâmetros: trata-se de uma máquina 32 bits rodando Ubuntu 12.04, sem nenhum gerenciador de janelas (você não precisa disso agora). Com essa solução, todas serão capazes de escrever o código necessário em seu ambiente normal, é possível usar seu navegador favorito, e a máquina virtual só será necessária quando você quiser rodar comandos Rails no terminal. Você poderá fazer isso no navegador também, como você verá mais adiante.

### VirtualBox

VirtualBox é a plataforma de virtualização da Oracle, que pode ser baixada em todos os sistemas operacionais suportados (Windows, OS X, Linux). Vamos baixar o instalador a partir do endereço [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads), e vamos instalá-lo em seguida.

### Máquina virtual das Rails Girls

Por favor baixe a máquina virtual criada para esse evento [aqui](http://www.digitalnatives.hu/demos/railsgirls/railsgirls_virtualbox_vm.zip). Após o download, por favor descompacte o arquivo, e coloque os conteúdos desse arquivo em uma pasta.
Vamos abrir a VirtualBox que já foi instalada. Por favor encontre o comando Machine/Add (Máquina/Adicionar) no menu.
Procure a pasta criada anteriormente, que contém nossa VM, e selecione o arquivo que tem a extensão *vbox*.
Se você configurou tudo certinho, uma nova VM apareceu na barra à esquerda, com o nome *RailsGirls*.
Podemos, então, iniciá-la pela primeira vez!

![VirtualBox / Iniciando a VM](/images/virtualbox.png)

#### Iniciando

Selecione a máquina virtual desejada e pressione o botão *start* (iniciar)! Se tudo estiver certo, uma janela preta deve aparecer, na qual, após 10-60 segundos, o rótulo `precise32 login:` aparecerá. Isso significa que a nossa VM está ligada e rodando! Não vamos precisar dessa janela depois, mas não feche-a, porque ela deve continuar sendo executada enquanto estivermos codando.

#### Desligando

Quando você não precisa mais de uma VM, você pode desligá-la. Para isso, feche a janela descrita acima, e selecione *Shut down* (desligar) das opções disponíveis. Depois que ela desligar, a VM não usará mais nenhum recurso do seu computador além de algum espaço no disco.

#### O mouse invisível

Ao clicarmos nessa janela da VirtualBox, ela pega nosso ponteiro do mouse, e ele desaparece sem deixar vestígios. Você pode recuperar seu ponteiro: no canto inferior direito da janela você consegue ver a combinação de teclas que você tem que pressionar (no OS X é esquerda-cmd, e em outras plataformas é direita-ctrl).

### Uso

Agora que nossa VM está ligada e rodando, vamos fazer login nela. Podemos logar a partir da janela de VirtualBox descrita acima, mas isso não é muito confortável de fazer (já que essa janela não está reconhecendo nosso layout de teclado e nenhum atalho como copiar-colar vai funcionar, etc.). Também poderíamos logar remotamente (com uma conexão SSH), mas o Windows não tem um cliente de SSH pré-instalado, e instalar um seria muito trabalhoso.
Por causa disso, você pode logar na sua VM usando um navegador. Abra seu navegador favorito (Chrome :) ), e digite o endereço [http://localhost:57575](http://localhost:57575).
Se tudo estiver certo, devemos ver uma borboleta:

![Borboleta / Terminal no seu navegador](/images/butterfly_login.png)

Nós vamos nos referir a essa aba do seu navegador como um terminal, e você deverá digitar todos os comandos destinados ao Rail aqui.

#### Colando texto

No Linux e no Windows, você não conseguirá colar qualquer código copiado com a combinação normal de <kbd>Ctrl</kbd>+<kbd>V</kbd>. Em vez disso, por favor use shift-inserir, porque deve funcionar.

### Login

Vamos logar na nossa VM com as seguintes credenciais (por favor ESTEJA CIENTE de que você não verá nada mudar enquanto estiver digitando a senha, e que isso é totalmente normal):

{% highlight sh %}
login: vagrant
password: vagrant
{% endhighlight %}

Após ter feito login com sucesso, você deve ver o seguinte rótulo:

{% highlight sh %}
vagrant@precise32:~$
{% endhighlight %}

IMPORTANTE: sempre que estivermos logadas na VM, não se esqueça de digitar a seguinte linha em seguida: `/bin/bash --login`!!!

### Diretório compartilhado

A parte mais difícil já acabou, e nosso ambiente de desenvolvimento está quase pronto. Só falta uma coisa: temos que compartilhar uma pasta, que deve ser lida pelo nosso sistema operacional normal e pela nossa VM, já que vamos escrever código na primeira, mas vamos ler o código na última.

Vamos criar uma nova pasta chamada *railsgirls* na nossa máquina virtual (na nossa pasta inicial de usuário).
Vamos desligar nossa VM, como descrito acima. Após o desligamento da máquina, selecione a VM no VirtualBox, e pressione *Settings*. Clique na aba Arquivos Compartilhados (Shared Folders), e clique no ícone de + pequeno, à direita. 
Na janelinha que aparecerá, procure pela pasta *railsgirls* como um caminho de pasta (Folder Path). Dê à pasta o nome (foldername) de *railsgirls*, e também selecione a opção *Auto Mount* (todas as outras opções devem estar não-selecionadas).
Inicie a VM novamente, e faça login nela com o processo já conhecido:

* abra [http://localhost:57575](http://localhost:57575)
* faça log in com vagrant / vagrant
* não se esqueça de executar `/bin/bash --login`

#### Checagem de sistema

A pasta compartilhada pode ser encontrada no caminho */media/sf_railsgirls*. Vamos verificar se tudo está funcionando conforme esperdo. Por favor entre no diretório:

{% highlight sh %}
$ cd /media/sf_railsgirls
{% endhighlight %}

Vamos criar um arquivo vazio:

{% highlight sh %}
$ touch teste.txt
{% endhighlight %}

Agora vamos checar, no nosso sistema operacional normal, se a pasta compartilhada contém um arquivo chamado *teste.txt*. Se o arquivo existir, isso significa que nosso ambiente de desenvolvimento virtual está pronto.

## Editor

O editor de código é, na verdade, um editor de texto muito esperto, no qual vamos escrever todo o código da nossa aplicação. Nós gostamos muito do Sublime Text, que você pode baixar de [http://www.sublimetext.com/3](http://www.sublimetext.com/3).
