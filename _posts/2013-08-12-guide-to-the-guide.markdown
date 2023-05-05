---
layout: default
title: O tutorial para o tutorial
permalink: guide-to-the-guide
---

# Seu tutorial para o Rails Girls tutorial!

*Criado por H Salmon para acompanhar o [tutorial de criação da app](/app).*

*Traduzido por Willany Silva, @willanySilva (https://twitter.com/willanySilva).*

Este tutorial é um acompanhamento para o [RailsGirls Tutorial](/app) que será utilizado para construir sua primeira aplicação
em Rails. O propósito desse tutorial é fornecer informações básicas sobre a estrutura de uma aplicação Rails, terminologia Rails e comandos, para que você possa entender o que está acontecendo quando estiver implementando o código no tutorial do Rails Girls. Esperamos que este tutorial lhe forneça uma forma de reter o que aprendeu ao longo deste workshop, e para manter o seu interesse no
desenvolvimento Rails. Bem vinda!

### [**1.** Criando a aplicação](#1_criando_a_aplicacao)
Comandos que você precisa saber

### [**2.** Criando Idea scaffold](#2_criando_idea_scaffold)
Scaffolding, modelos, migrações

### [**3.** Design](#3_design)
As camadas de design (HTML, CSS, ERB)
Arquitetura MVC

### [**4.** Adicionando upload de imagens](#4_add_upload_imagens)
Bibliotecas, gems e código-aberto

### [**5.** Regularização de rotas](#5_regularizacao_de_rotas)
Rotas, métodos HTTP: GET, POST, PUT e DELETE


## <a id="1_criando_a_aplicacao">*1.* Criando a aplicação</a>

`mkdir projetos` - cria um *diretório* (pasta) chamado de “projetos” na pasta em que você está, muito provavelmente sua pasta pessoal.
`mkdir` = **m**a**k**e **dir**ectory (crie o diretório).

`cd projetos` - navega para a pasta “projetos” que você acabou de criar. `cd` = **c**hange **d**irectory (mude o diretório).

`rails new railsgirls` - cria um novo aplicativo Ruby on Rails chamado **railsgirls** contendo várias pastas geradas automaticamente, no seu *diretório de trabalho* (a pasta que está trabalhando no momento).

`cd railsgirls` - navega para a pasta “railsgirls”.

`ruby script\rails server` - inicia um servidor web local em seu computador. Este servidor web é acessado através do endereço web [http://localhost:3000](http://localhost:3000).

“Localhost” refere-se especificamente ao seu computador (considerado o “host local”), a partir do qual o servidor está rodando. Localhost fornece uma maneira para os desenvolvedores para verem a sua aplicação em um navegador e testar a funcionalidade enquanto ele ainda está em desenvolvimento.


## <a id="2_criando_idea_scaffold">*2.* Criando Idea scaffold</a>

### O que é Rails scaffolding?

Cada aplicação web é composta de muitos conceitos ou recursos diferentes (como “usuários”, “ideias”, “posts”, “comentários”, etc.).
Rails scaffolding é um comando (`rails generate scaffold`) para a introdução de um novo recurso em seu aplicativo. Ele gera todos os arquivos de código necessários para representar e interagir com este recurso.


### O que é um model (modelo)?

No Rails, um model representa uma definição de um recurso em sua aplicação, e como ele deve interagir com outras partes da aplicação. Dependendo da natureza do site, estes recursos poderiam ser usuários, mensagens, grupos etc. Quando um model é gerado, uma *tabela de banco de dados* correspondente é criada. Esta tabela de banco de dados contém informações que representam atributos específicos do model, por exemplo, para um modelo de usuário, pode haver uma coluna ‘nome’ e uma coluna de ‘e-mail’, e haverá linhas para cada usuário subsequente criado. Na aplicação que você está criando, esses recursos são ideias e o model é ‘Ideia’.

{% highlight sh %}
rails generate scaffold ideia nome:string descricao:text imagem:string
{% endhighlight %}

A fim de criar o nosso modelo de Ideia, usamos o comando `scaffold` que inclui uma discussão com a versão singular do nome do modelo  (`ideia`), e uma discussão com parâmetros (especificações) para os atributos do modelo. Isso significa que o modelo `ideia` corresponde a uma tabela no banco de dados com colunas para os atributos especificados no comando: `nome`, `descricao` and `imagem`. O comando  `scaffold` também gera automaticamente um atributo `id` referido como a `primary key` (chave primária),  que é usado para estabelecer relações entre as tabelas de banco de dados.


`rails generate scaffold` - isto chama o comando scaffold.

`ideia` - diz ao comando scaffold o que queremos chamar nosso modelo.

`nome:string descricao:text imagem:string` - fornece uma lista de atributos que queremos que o model (e a tabela de banco de dados que vai com ele) terá. As partes `string` e `text` do argumento determinam a natureza de cada atributo, ou seja, cada descrição precisa ser ‘text’, e não, por exemplo, um ‘integer’ (ou qualquer outro tipo de informação).

### A tabela ideias

<table class="table table-hover table-bordered">
	<thead>
		<tr>
			<th>id</th>
			<th>nome</th>
			<th>descrição</th>
			<th>imagem</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>“Mina de ouro”</td>
			<td>“Abrir uma loja de móveis!”</td>
			<td>“GreatIdea.jpg”</td>
		</tr>
		<tr>
			<td>2</td>
			<td>“Champagne para o café da manhã!”</td>
			<td>“Nós devemos fazer isso toda sexta-feira!”</td>
			<td>“Champagne.jpg”</td>
		</tr>
		<tr>
			<td>3</td>
			<td>...</td>
			<td>...</td>
			<td>...</td>
		</tr>
	</tbody>
</table>

### Convenções de nomenclatura

#### Active Record
No Rails, o sistema padrão para a comunicação com banco de dados de um aplicativo é chamado *Active Record*, que fornece vários métodos para criar, salvar e encontrar dados. Para recuperar as informações do banco de dados, *Active Record* estabelece relações entre diferentes partes da aplicação usando as convenções de nomenclatura:

- Os nomes de tabela tem todas as letras minúsculas e sublinhados entre as palavras, por exemplo, “ideas”, “fatura\_itens”
- O model é chamado usando a convenção de MixedCase ininterrupta e é sempre o singular do nome da tabela, por exemplo, se o nome da tabela é “fatura\_itens”, o nome do model seria “FaturaItem”. Assim, neste caso, o nosso nome da tabela é "ideas" e nosso model é "Idea".

#### Atributos e tipos no Modelo

Como já discutido, um model pode ter atributos (propriedades) representados por colunas na tabela de banco de dados correspondente. Para ser compatível com o sistema Active Record, esses atributos devem estar de acordo com uma lista de tipos apropriados:

- `:binary` (binário) - armazena dados como imagens, arquivos de áudio ou filmes

- `:boolean` (booleano) - armazena valores verdadeiros ou falsos (por exemplo, se um determinado usuário é um administrador de uma aplicação ou não)

- `:date` (data) - armazena apenas uma data (ano, mês, dia)

- `:datetime` (data e hora) - armazena uma data  e uma hora

- `:decimal` - armazena números decimais com precisão que varia de acordo com suas especificações

- `:float` - armazena pontos decimais com precisão fixa ou seja, você não pode especificar a precisão (`:decimal` é melhor para operações matemáticas em que é necessária precisão, mas `:float` é processado mais rápido e é melhor em situações onde é necessária velocidade e precisão está em segundo plano)

- `:integer` (inteiro) - armazena números inteiros

- `:primary_key` (chave primária) - a chave primária de uma tabela é assumido como sendo o id

- `:string` - armazena 255 caracteres das informações de texto, ou seja, é usado para campos de texto curtos (nomes, e-mails etc)

- `:text` (texto) - armazena informações de texto sem limite de caracteres (usado para comentários, posts de blogs, etc)

- `:time` (tempo) - armazena apenas tempo

- `:timestamp` - armazena, tanto a hora e a data. `:timestamp` é diferente de `:datetime` e tem uma finalidade diferente, mas não há necessidade de entrar em detalhes aqui

### O que são as migrations (migrações) e por que você precisa delas?

As migrations alteraram o estado da base de dados. Quando você executa o comando scaffold, um arquivo de migrações que contém instruções para a tabela de banco de dados relevantes para o seu comando é adicionado à pasta `db/migrate` da sua aplicação. Por exemplo, quando você executou o comando `rails generate scaffold`, uma migração contendo instruções para a nossa tabela ideias foi criada. Há outros comandos que criam as migrações, como o comando `rails generate model` e o comando `rails generate migration`.

O comando `rake db:migrate` atualiza o banco de dados de acordo com as especificações que constam na migração. Este comando, conhecido como “migrating up”, garante que o seu model ideia é adicionado ao banco de dados. Migrações também podem ser desfeitas (“migrating down”) usando o comando `rake db:rollback`.

## <a id="3_design">*3.* Design</a>
Em um aplicativo Ruby on Rails, a interface do usuário (o que alguém visitando o site vai ver), é muitas vezes escrito em HTML com código incorporado Ruby (ERB). Este código está contido em um diretório específico chamado de ‘views’, localizado na pasta `app` do seu diretório do aplicativo Rails.

### HTML
HTML, que significa HyperText Markup Language, é o idioma principal para a criação de páginas web e outras informações que podem ser exibidas em um navegador da web. HTML é escrito usando tags, menor que e maior que (< >) que tendem a vir em pares (uma “tag de início” e uma “tag fim”), abrangendo conteúdo baseado em texto. Nos pares de tags, a tag fim também tem uma barra depois da abertura da tag menor que, para distingui-lo a partir da tag de início. Um parágrafo (representado em HTML pela letra ‘p’) usaria uma tag de início como esta: `<p>` e uma tag final como esta: `</p>`, para colocar o texto pretendido para a exposição. Tags que não possuem pares e que são abertas, mas não precisam de tags de fechamento (por exemplo `<br>`,  que define uma única quebra de linha) são conhecidas como “elementos vazios”. O navegador usa tags HTML para interpretar como o conteúdo será exibido.

### ERB: Ruby incorporado
ERB é um sistema fornecido por Ruby que permite inserir código Ruby puro em arquivos escritos em outras linguagens, como Javascript ou HTML. O código Ruby está contido dentro de tags específicas (`<%` e `%>`) que instruem o sistema para executar o conteúdo. Se um sinal `=` acompanha as tags, (`<%=` e `%>`) em seguida, os conteúdos são executados e renderizados na página.

Por exemplo, se você tivesse 25 ideias ativas em seu aplicativo, o código:
`Atualmente há <%= Idea.count %> ideias ativas`
Renderizaria:
> Atualmente há 25 ideias ativas

### Arquitetura MVC
Em uma aplicação Rails padrão (como a que você tem gerado), a pasta `app/` da sua aplicação começa com três pastas (ou diretórios): ‘models’ (que nós já discutimos), ‘controllers’ (controladores) and ‘views’ (visões). A relação entre esses diretórios é a base (conhecido como MVC Architecture) da aplicação e do desenvolvimento Rails.

Quando você executou o comando `rails generate scaffold`, além de criar o modelo de ideia, você também criou um controlador que acompanha ideias (`ideas_controller.rb`), localizado na pasta controladores, e uma pasta view de ideas que contém vários arquivos que você irá usar para criar uma aplicação dinâmica.

Ao tentar exibir um site Rails, um navegador da Web envia uma solicitação através do servidor que eventualmente atinge o *controller* (controlador) do Rails. *Controllers* trabalham como mediadores entre as *views* e os *models*. Quando o *controller* recebe a informação, ele se comunica com o *model* representando um recurso da aplicação (no nosso caso, uma “idea”) que por sua vez comunica com a base de dados. Após recuperar as informações necessárias a partir do *model*, o *controller* renderiza a *view* que retorna a página web completa para o navegador como HTML.

### CSS e layouts
CSS (Cascading Style Sheets) é uma linguagem usada para descrever a formatação de páginas escritas em uma ‘linguagem de marcação’, ou seja, uma linguagem para processamento, definindo e apresentando texto com um código de formatação prescrita por exemplo tags, que o distinguem de texto simples. A aplicação mais comum de CSS é em conjunto com HTML.
{% highlight css %}
body { padding-top: 100px; }
footer { margin-top: 100px; }
table, td, th { vertical-align: middle; border: none; }
th { border-bottom: 1px solid #DDD; }
{% endhighlight %}

Dentro do CSS você deve ter aplicado:

`body` (corpo) - esta parte é conhecido como o selector e refere-se ao elemento HTML que você deseja aplicar o estilo.
`{ padding-top: 100px; }` - Esta parte é conhecida como a declaração; cada declaração tem uma propriedade que é o estilo de atributo que deseja alterar (`padding-top`), Declarações sempre terminam com um ponto e vírgula e declaração de grupos são sempre cercada por chaves.

Para cada aplicação Rails há um arquivo de layout padrão chamado `application.html.erb`, localizado na pasta layouts do seu diretório views. Com este arquivo você pode criar um formato padrão para todas as páginas em seu aplicativo.

{% highlight html %}
<link rel="stylesheet" href="http://railsgirls.com/assets/bootstrap.css">
{% endhighlight %}

No código acima, o `link rel` (link relação)  está definindo a natureza da URL que o atributo `href` (referência de hipertexto) está solicitando conteúdo. Este argumento indica que a fonte externa é solicitada uma folha de estilo e o navegador web vai precisar obter esse arquivo para processar a página corretamente.

{% highlight erb %}
<%= stylesheet_link_tag "application" %>
{% endhighlight %}

Este código retorna uma tag link folha de estilo para a fonte, neste caso “application”, ou seja, `application.css`. Isto significa que o estilo que você implementou em application.css será aplicado às várias páginas do seu aplicativo.


{% highlight erb %}
<div class="container">
  <%= yield %>
</div>
{% endhighlight %}

Neste código:

- A tag HTML `div` divide o código em partes.
- A *class container* adiciona estilo adicional para tudo dentro das tags div
- O `<%= yield %>` argumento é responsável por inserir o conteúdo original de cada página dentro da `div` container. Isto significa que na sua aplicação o layout geral pode ser consistente mesmo que o conteúdo seja diferente de uma página para outra.

## <a id="4_add_upload_imagens">*4.* Adicionando upload de imagens</a>

### Bibliotecas
Muitas linguagens de programação, incluindo Ruby, utilizam uma ampla gama de bibliotecas. No caso de Ruby, a maioria destas bibliotecas são liberadas na forma de pacotes independentes chamados *gems*, que contêm todas as informações necessárias para instalar e implementá-las. Essas gems estão contidas no arquivo `Gemfile` da sua aplicação e se você olhar neste arquivo você vai notar que quando você criou sua primeira aplicação Rails ele veio com várias gems que garantem as funções da aplicação corretamente.

Gems ajudam a simplificar e evitar a repetição no código de um desenvolvedor, de acordo com o DRY (Don’t Repeat Yourself) princípio do desenvolvimento de software. Gems podem resolver problemas específicos, adicionar funcionalidade específica, ou atender aos requisitos específicos, significando que deveria outro desenvolvedor encontrar um cenário semelhante, em vez de escrever novo código, eles podem instalar uma gem contendo o código pré-escrito. Por exemplo, “CarrierWave”, a gem que você está adicionando ao seu Gemfile é projetada para tornar mais fácil o upload de arquivos para a sua aplicação.

“Bundler” é o software Ruby usado para controlar e gerenciar gems. O comando `bundle` roda o Bundler e instala as gems especificadas em seu Gemfile. Você notará o código `source 'https://rubygems.org'` no topo do seu Gemfile. Sempre que você adicionar uma gem para o seu Gemfile e executar o comando `bundle`, este código informa o aplicativo para buscar a gem de [https://rubygems.org](https://rubygems.org). “RubyGems” é um sistema de pacotes específico para o Ruby, cujo objectivo é simplificar a criação, compartilhamento e instalação de gems.


### Software livre

Tanto o framework Rails e a linguagem Ruby são exemplos de software de código aberto. Software de código aberto é distribuído sob uma licença que garante o acesso universal; qualquer um tem o direito de mudar, estudar e distribuir o software. Fazendo o código fonte acessível permite o estabelecimento de uma comunidade diversificada, reflexiva, colaborativa e, consequentemente, cheia de programadores em constante evolução que beneficiam uns aos outros.


### Mais HTML

O arquivo `app/views/ideas/_form.html.erb` contém código HTML que determina a aparência do formulário utilizado para edição e criação de ideas (o `edit.html.erb` e `new.html.erb` views). A parcial é um fragmento de código HTML e Ruby que pode ser reutilizado em vários locais. O formulário para edição de ideas existentes e a forma para a criação de novas ideas vão olhar praticamente o mesmo, por isso faz sentido ter um formulário para ambos os arquivos para usar. Se você olhar nestes arquivos que você vai notar que eles têm um cabeçalho personalizado (por exemplo, `<h1>Editando ideia</h1>`) e, em seguida, eles simplesmente dizem `<%= render 'form' %>` que diz ao Rails para processar o partial `_form.html.erb`.

Se você der uma olhada no arquivo `_form.html.erb`, você vai ver o código `form_for` na primeira linha de código. Este é um bloco usado para criar um formulário HTML. Usando este bloco, podemos acessar métodos para colocar diferentes campos de entrada no formulário.

O código que estamos implementando, `<%= f.file_field :picture %>`, diz ao Rails para criar um arquivo de entrada no formulário e mapear as informações apresentadas ao atributo ‘imagem’ de uma ‘ideia’ em nossa tabela ideias no banco. Mudamos o código `<%= f.text_field :imagem %>` para `<%= f.file_field :imagem %>` porque `file_field` torna mais fácil para que o usuário selecione a imagem que deseja enviar.

No código `<%= @idea.imagem %>`, `@idea` é conhecido como uma *variável de instância*. Variáveis de instância são prefixados com um símbolo @ e são definidos na ação do controlador que corresponde à view em que são referenciadas. Para efeitos do código que estamos implementando, `@idea` é definido na ação ‘show’ do controlador de `Ideias`, com o código `@ideia = Ideia.find(params[:id])`. Isso torna disponível para utilizarmos na view `show.html.erb`. Pode ser definido de forma diferente em ações de controlador diferentes (por exemplo, índice ou novos). O código `@idea = Idea.find(params[:id])` Usa o método Rails `find`  para recuperar ideias específicas do banco de dados.

O código que segue a variável `@idea` (`.imagem`) diz ao Rails para acessar o atributo de ‘imagem’ de nosso recurso (idea). Ao substituir o código  `<%= @idea.imagem %>` com `<%= image_tag(@ideia.imagem_url...)` estamos usando o Ruby `image_tag` *helper (auxiliar)* que converte para um HTML `<img>` tag (usado para definir as imagens em HTML) mas, por padrão, recupera imagens da pasta public/images, que é onde nossas imagens enviadas são armazenadas. O helper `image_tag` também nos permite inserir um bloco de código que cria um caminho para uma imagem associada a uma idea (`@idea.imagem_url`).

Você vai notar que dentro deste bloco de código que você está implementando também somos capazes de definir uma largura padrão para cada imagem (`:width => 600`).A linha final do código, `if @ideia.imagem.present?` diz ao Rails para verificar a tabela de banco de dados correspondente para ver se existe uma imagem antes de renderizar o código por abaixo.

## <a id="5_regularizacao_de_rotas">*5.* Regularização de rotas</a>

Em uma aplicação Rails funcional, existe um sistema embutido no lugar para traduzir solicitações de entrada a partir do browser, a fim de retornar a resposta pretendida. Este sistema é chamado *routing (roteamento)*. Solicitações do navegador são interpretadas como métodos HTTP específicos. HTTP (Hypertext Transfer Protocol) é o protocolo que define como a informação (geralmente páginas ou componentes de páginas web compostas de texto com hyperlinks - ‘hipertexto’), é formatada e transmitida através da internet. Existem quatro métodos HTTP primários, cada um dos quais é um pedido para executar uma operação em um recurso específico (por exemplo, usuários, posts); GET, POST, PUT e DELETE. O sistema de roteamento embutido Rails gera automaticamente rotas para cada recurso que mapeiam para acções específicas (index, show, new, edit, create, update, delete) definidos no controlador. Assim, para cada um dos nossos modelos, há sete ações conexas definidas no controlador associado, `ideas_controller.rb`. Essas ações especificar especificam a resposta apropriada (um ‘method (método)’) que é mais provável para tornar a vista correspondente, por exemplo, `ideas/index.html.erb`.

<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<td>HTTP Method</td>
			<td>Caminho</td>
			<td>Ação</td>
			<td>Usado para</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>GET</td>
			<td>/ideas</td>
			<td>index</td>
			<td>exibir uma lista de todas as ideias</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/ideas/new</td>
			<td>new</td>
			<td>devolver um formulário HTML para a criação de uma nova ideia</td>
		</tr>
		<tr>
			<td>POST</td>
			<td>/ideas</td>
			<td>create</td>
			<td>criar de uma nova ideia</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/photos/:id</td>
			<td>show</td>
			<td>Exibir uma foto especifica</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/photos/:id/edit</td>
			<td>edit</td>
			<td>devolver um formulário HTML para editar uma foto específica</td>
		</tr>
		<tr>
			<td>PUT</td>
			<td>/photos/:id</td>
			<td>update</td>
			<td>atualizar uma foto específica</td>
		</tr>
		<tr>
			<td>DELETE</td>
			<td>/photos/:id</td>
			<td>destroy</td>
			<td>Excluir uma foto específica</td>
		</tr>
	</tbody>
</table>


Se você olhar no arquivo `ideas_controller.rb` você pode ver essas ações e o comportamento associado, e o método HTTP que corresponde com cada ação:


{% highlight ruby %}
def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
{% endhighlight %}

`show` - a ação do controlador

{% highlight ruby %}
respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
{% endhighlight %}

(Este código é difícil de dissecar com muita clareza, nesta fase, mas se você persistir com Rails você vai obter uma melhor compreensão com o tempo.)

Na definição acima da ação show, Rails está usando um método helper `respond_to`, que diz para o Rails para executar o *block* subsequente de código (o código fechado por  `do...end` sintaxe). Este código contém duas opções de formatação diferentes dependendo da natureza do pedido. Se o navegador solicita HTML, em seguida, o código HTML contido na view que corresponde com esta ação do controlador (`show.html.erb`) é renderizado. Se o json é solicitado, em seguida, a view é ignorada e informação limitada é fornecida.

`GET` - isto é um comentário para deixar-nos saber qual o método HTTP está sendo executado.

Assim, as requisições da URL, traduzidas em métodos HTTP, são mapeadas em ações do controller que dizem para o Rails retornar uma view.


Quando inserimos o código `root :to => redirect('/ideas')` em nosso `config.rb`, ele diz ao Rails para fazer como a raiz padrão da nossa aplicação [http://localhost:3000/ideas](http://localhost:3000/ideas) (perceba que Localhost está sendo usado como o domínio porque a nossa aplicação ainda está em desenvolvimento, quando você iniciar a sua aplicação domínio será diferente). Esta URL contém o caminho (`/ideas`) que, por padrão, mapeia a URL para a ação ‘index’ do nosso controlador de ideas  e renderiza a view associada; `index.html.erb`. O código `rm public/index.html` remove (`rm`) o arquivo `public/index.html`, contendo o código de “Bem-vindo a bordo”, que era a raiz padrão anterior da nossa aplicação.

{% include other-guides.md page="guide-to-the-guide" %}
