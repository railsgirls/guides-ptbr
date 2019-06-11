# PARTE 0

# Como forkar o projeto

No projeto Guides-ptbr clique no botão fork para fazer uma cópia do projeto para sua conta do github.

![GitHub Fork](/images/fork1.jpg)

Logo depois de forkar você deve clicar no botão Clone or download e escolha se deseja clonar por SSH ou HTTPS.

![Clone Project](/images/cloneordownload.png)

e no terminal digite `git clone` e cole a url do seu repositório fork.

```bash
$ git clone git@github.com:YOUR-USERNAME/guides-ptbr.git
```

## Como rodar o projeto

Dentro do diretório `guides-ptbr` execute o camando abaixo para instalar todas as gems que o projeto precisa.

```bash
$ bundle install
```

Depois de terminado de instalar todas as dependências basta executar

```bash
$ bundle exec jekyll serve --watch
```

para iniciar o servidor e abrir no navegador com o endereço [http://localhost:4000](http://localhost:4000)

## Como abrir um Pull Request

Primeiro você deve está na branch `master`, execute o comando abaixo e verifique se está na `master`

```bash
$ git branch
```

Conferido, agora crie uma nova branch para começar a fazer sua contribuição

```bash
$ git checkout -b nome_da_sua_branch
```

Depois de terminar a sua contribuição crei o seu commit `git commit ...` e depois envie para o seu repositório `git push origin nome_da_sua_branch`

Agora entre na github, vá até o seu repositório forkado e acesse a aba Pull Requests

Na página de Pull Requests clique no botão Novo Pull Request, na página que vai aparecer você deve escolher qual a sua branch vai ser mergeada com a branch do projeto original.

![Criando Pull Request](/images/pull_request.png)

O lado esquerdo é o nome do projeto e branch e o lado direito é o seu projeto e branch, basta escolher a branch você criou, colocar um título e descrição e seu Pull Request vai ser enviado.

## Algumas regras para seguir quando for efetuar as traduções

- Tudo o que não for palavra reservada (e.g. variáveis, nomes de classes), traduzir para o português;
- As referências a `COACH` serão traduzidos como `INSTRUTOR(A)`;
- Se existir algum problema de clareza e compreensão a cerca do que está na versão original, corrigir no momento da tradução (é legal abrir um PR no guia em EN pra corrigir lá também);

Para entender melhor acesse essa [issue](https://github.com/railsgirls/guides-ptbr/issues/24).

# PARTE 1

# Instruções para tradução da documentação do Rails Girls

## Como fazer para colaborar?

Primeiramente, você deve dar um [fork](http://help.github.com/fork-a-repo/) no projeto para a sua conta. Com isso, você estará livre para fazer as traduções para o português.

Quando finalizar algo, você deve dar um [pull request](http://help.github.com/pull-requests/) neste repositório para o seu conteúdo ser revisado e aprovado. Com isso, a sua tradução estará no repositório principal e com os seus devidos créditos.

No final do projeto, será lançado oficialmente o site Rails Girls Brasil e divulgado. Todos os colaboradores serão citados e terão seus créditos mantidos.


## Como posso me candidatar a realizar uma tradução?

Basta conferir a aba de `Issues` de repositório, se encontrar alguma tradução que interesse, adicione um comentário que começou a trabalhar nessa tradução. Será feito o máximo possível para manter a aba atualizada :)

**Contamos com a colaboração de todos pois o sucesso deste projeto depende de todos nós que gostamos de compartilhar conhecimentos**

## Como atualizar meu fork com as novas atualizações deste repositório?

    git remote add upstream https://github.com/railsgirls/guides-ptbr.git (url origem do fork)
    git pull upstream gh-pages (nome do branch)
    git push

---

# PARTE 2

# Rails Girls Tutoriais

Nosso objetivo é fornecer ferramentas para que mulheres estudem e entendam a tecnologia Rails. Os eventos Rails Girls foram criados com a finalidade de proporcionar uma primeira experiência com as técnicas Rails de criação para a Internet.

Rails Girls foi criado na cidade de Helsinki no final do ano 2010. A intenção inicial foi a de criar um único evento local e nós jamais imaginamos que a ideia atingisse a proporção atual com a proliferação de vários eventos pelo mundo inteiro. Estes tutoriais foram criados para ajudá-lo a iniciar seus estudos de Rails.

Você pode usar nosso material para criar seu próprio workshop na sua cidade, no seu ambiente de trabalho ou mesmo na sua cozinha! Saiba mais sobre Rails Girls em http://railsgirls.com

## Mãos à obra

Leia os tutoriais em http://guides.railsgirls.com/guides-ptbr/ ou clone este repositório, instale e rode [jekyll](https://github.com/mojombo/jekyll)

### Instalando jekyll

```
$ cd guides-ptbr
```

```
$ bundle install
```

### Pygments e Code Highlighting

Os tutoriais foram criados com uso da biblioteca [pygments](http://pygments.org/) para destacar a sintaxe dos códigos. Se você não instalar a biblioteca não será possível visualizar o destaque nos blocos de código inseridos nos tutoriais, tais como o mostrado a seguir:

```
{% highlight %}
{% endhighlight %}
```

Se você não pretende editar blocos de código, pode ignorar a biblioteca, mas se pretende instalá-la consulte as [instruções de instalação](http://jekyllrb.com/docs/installation/) na seção "Pygments"

### Rodando jekyll

```
$ bundle exec jekyll server --watch
```

### Estilizando

Atalhos de teclado devem ser marcados com o elemento HTML [kbd](https://www.w3.org/wiki/HTML/Elements/kbd) .

Por questões de consistência de estilização use `Ctrl+C` e não `CTRL-c`/`ctrl+c`

```
Para  parar o servidor pressione as teclas <kbd>Ctrl</kbd>+<kbd>C</kbd>
```

### Encontrou um problema?

Caso jekyll não esteja funcionando como esperado consulte [Issue 503](https://github.com/mojombo/jekyll/issues/503)

## Contribuindo com um tutorial

Para contribuir com um tutorial consulte as instruções em http://guides.railsgirls.com/contributing

## Twitter

Para acompanhar atualizações e informações em geral siga [@railsgirls](https://twitter.com/railsgirls)

## Website e Blog

O website e o blog de Rails Girls encontra-se hospedado em http://railsgirls.com

## Lista de e-mail

A lista de e-mails de caráter global para os eventos de Rails Girls encontra-se em http://groups.google.com/group/rails-girls-team

## Créditos

- Karri Saarinen / [@karrisaarinen](https://twitter.com/karrisaarinen) / [github](http://github.com/ksaa)
- Linda Liukas / [@lindaliukas](https://twitter.com/lindaliukas) / [github](http://github.com/lindaliukas)
- Vesa Vänskä / [@vesan](https://twitter.com/vesan) / [github](http://github.com/vesan)
- Terence Lee / [@hone02](https://twitter.com/hone02) / [github](http://github.com/hone)

..e todos os instrutores(as) e pessoas envolvidas com o maravilhoso universo de Rails Girls. Seja mais um de nós!
