---
layout: default
title: O tutorial para o tutorial
permalink: guide-to-the-guide
---

# Seu tutorial para o Rails Girls tutorial!

*Criado por H Salmon to accompany the [app guide](/app).*
*Traduzido por Willany Silva, @willanySilva (https://twitter.com/willanySilva).*


Este tutorial é um acompanhamento para o [RailsGirls Tutorial](/app) que será utilizado para construir sua primeira aplicação
em Rails. O propósito desse tutorial é fornecer informações básicas sobre a estrutura de uma aplicação Rails, terminologia Rails e comandos, para que você possa entender o que está acontecendo quando estiver implementando o código no tutorial do Rails Girls. Esperamos que este tutorial lhe forneça uma forma de reter o que aprendeu ao longo deste workshop, e para manter o seu interesse no
desenvolvimento Rails. Bem vinda!

### [**1.** Criando a aplicação](#1_criando_a_aplicacao)
Comandos que você precisa saber

### [**2.** Criando Idea scaffold](#2_criando_idea_scaffold)
Scaffolding, models, migrations

### [**3.** Design](#3_design)
As camadas de design (HTML, CSS, ERB) 
Arquiterura MVC

### [**4.** Adicionando upload de imagens](#4_add_upload_imagens)
Bibliotecas, gems e código-aberto

### [**5.** Regularização de rotas](#5_regularizacao_de_rotas)
rotas, métodos HTTP: GET, POST, PUT e DELETE


## <a id="1_criando_a_aplicacao">*1.* Criando a aplicação</a>

`mkdir projetos` - cria um *diretório* (pasta) chamado de “projetos” na pasta em que você está, muito provavelmente sua pasta pessoal.
`mkdir` = cria diretório.

`cd projetos` - navega para a pasta “projetos” que você acabou de criar. `cd` = muda o diretório.

`rails new railsgirls` - cria um novo aplicativo Ruby on Rails chamado **railsgirls** contendo várias pastas geradas automaticamente, no seu *diretório de trabalho* (a pasta que está trabalhando no momento).

`cd railsgirls` - navega para a pasta “railsgirls”.

`ruby script\rails server` - inicia um servidor web local em seu computador. Este servidor web é acessado através do endereço web [http://localhost:3000](http://localhost:3000).

“Localhost” refere-se especificamente ao seu computador (considerado o “host local”), a partir do qual o servidor está rodando. Localhost fornece uma maneira para os desenvolvedores para ver a sua aplicação em um navegador e testar a funcionalidade enquanto ele ainda está em desenvolvimento.


## <a id="2_criando_idea_scaffold">*2.* Criando Idea scaffold</a>

### O que é Rails scaffolding?

Cada aplicação web é composta de muitos conceitos ou recursos diferentes (como “usuários”, “ideas”, “posts”, “comentários”, etc.).
Rails scaffolding é um comando (`rails generate scaffold`) para a introdução de um novo recurso em seu aplicativo. Ele gera todos os arquivos de código necessários para representar e interagir com este recurso.


### O que é um model (modelo)?

No Rails, um model representa uma definição de um recurso em sua aplicação, e como ele deve interagir com outras partes da aplicação. Dependendo da natureza do site, estes recursos poderiam ser usuários, mensagens, grupos etc. Quando um model é gerado, uma *tabela de banco de dados* correspondente é criada. Esta tabela de banco de dados contém informações que representam atributos específicos do model, por exemplo, para um modelo de usuário, pode haver uma coluna ‘nome’ e uma coluna de ‘e-mail’, e haverá linhas para cada usuário subsequente criado. Na aplicação que você está criando, esses recursos são ideas e o model é ‘Ideia’.

{% highlight rb %}
rails generate scaffold idea nome:string descricao:text imagem:string
{% endhighlight %}

A fim de criar o nosso modelo de Idea, usamos o comando `scaffold` que inclui uma discussão com a versão singular do nome do modelo  (`idea`), e uma discussão com parâmetros (especificações) para os atributos do modelo. Isso significa que o modelo `idea`corresponde a uma tabela no banco de dados com colunas para os atributos especificados no comando: `nome`, `descricao` and `imagem`. O comando  `scaffold` também gera automaticamente um atributo `id` referido como a `primary key` (chave primária),  que é usado para estabelecer relações entre as tabelas de banco de dados.


`rails generate scaffold` - isto chama o comando scaffold.

`idea` - diz ao comando scaffold o que queremos chamar nosso modelo.

`nome:string descricao:text imagem:string` - fornece uma lista de atributos que queremos que o model (e a tabela de banco de dados que vai com ele) terá. A `string` e `text` partes do argumento determinam a natureza de cada atributo, ou seja, cada descrição precisa ser  ‘text’, e não, por exemplo, um ‘integer’ (ou qualquer outro tipo de informação).

### A tabela ideas

<table class="table table-hover table-bordered">
	<thead>
		<tr>
			<th>id</th>
			<th>nome</th>
			<th>descricao</th>
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

- Os nomes de tabela tem todas as letras minúsculas e sublinhados entre as palavras, por exemplo,  “ideas”, “fatura\_itens”
- O model é chamado usando a convenção de MixedCase ininterrupta e é sempre o singular do nome da tabela, por exemplo, se o nome da tabela é “fatura\_itens”, o nome do model seria “FaturaItem”. Assim, neste caso, o nosso nome da tabela é "ideas" e nosso model é "Idea".

#### Model atributos e tipos

Como já discutido, um model pode ter atributos (propriedades) representados por colunas na tabela de banco de dados correspondente. Para ser compatível com o sistema Active Record, esses atributos devem estar de acordo com uma lista de tipos apropriados:

- `:binary` (binário) - armazena dados como imagens, arquivos de áudio ou filmes

- `:boolean` (booleano) - armazena valores verdadeiros ou falsos (por exemplo, se um determinado usuário é um administrador de uma aplicação ou não)

- `:date` (data) - armazena apenas uma data (ano, mês, dia)

- `:datetime` (data e hora) - armazena uma data  e uma hora

- `:decimal` - armazena números decimais com precisão que varia de acordo com suas especificações

- `:float` - armazena pontos decimais com precisão fixa ou seja, você não pode especificar a precisão (: decimal é melhor para operações matemáticas em que é necessária precisão, mas: float é processado mais rápido e é melhor em situações onde é necessária velocidade e precisão é secundário )

- `:integer` (inteiro) - armazena números inteiros

- `:primary_key` (chave primária) - a chave primária de uma tabela é assumido como sendo o id

- `:string` - armazena 255 caracteres das informações de texto, ou seja, é usado para campos de texto curtos (nomes, e-mails etc)

- `:text` (texto) - armazena informações de texto sem limite de caracteres (usado para comentários, posts de blogs, etc)

- `:time` (tempo) - armazena apenas um tempo

- `:timestamp` - armazena, tanto a hora e a data. : Timestamp é diferente: data e hora e tem uma finalidade diferente, mas não há necessidade de entrar em detalhes aqui

### O que são as migrations (migrações) e por que você precisa delas?

As migrations alteraram o estado da base de dados. Quando você executa o comando scaffold, um arquivo de migration que contém instruções para a tabela de banco de dados relevantes para o seu comando é adicionado à pasta `db/migrate` da sua aplicação. Por exemplo, quando você executou o comando `rails generate scaffold`, uma migration contendo instruções para a nossa tabela ideas foi criada. Há outros comandos que criam as migrations, como o comando `rails generate model` e o comando `rails generate migration`.

O comando `rake db:migrate` atualiza o banco de dados de acordo com as especificações que constam na migration. Este comando, conhecido como “migrating up”, garante que o seu model idea é adicionado ao banco de dados. Migrations também podem ser desfeitas (“migrating down”)  usando o comando `rake db:rollback`.

## <a id="3_design">*3.* Design</a>
Em um aplicativo Ruby on Rails, a interface do usuário (o que alguém visitando o site vai ver), é muitas vezes escrito em HTML com código incorporado Ruby (ERB). Este código está contido em um diretório específico chamado de ‘views’, localizado na pasta `app` do seu diretório do aplicativo Rails.

### HTML
HTML, que significa HyperText Markup Language, é o idioma principal para a criação de páginas web e outras informações que podem ser exibidas em um navegador da web. HTML é escrito usando tags, menor que e maior que (< >) que tendem a vir em pares (uma “tag de início” e uma “tag fim”), abrangendo conteúdo baseado em texto. Em pares de tags, a tag fim também tem uma barra depois da abertura da tag menor que, para distingui-lo a partir da tag de início. Um parágrafo (representado em HTML pela letra ‘p’) usaria uma tag de início como esta: `<p>` e uma tag final como esta: `</p>`, para colocar o texto pretendido para a exposição. Tags que não possuem pares e que são abertas, mas não precisam de tags de fechamento (por exemplo `<br>`,  que define uma única quebra de linha) são conhecidas como “elementos vazios”. O navegador usa tags HTML para interpretar como o conteúdo será exibido.

### ERB: Ruby incorporado 
ERB é um sistema fornecido por Ruby que permite inserir código Ruby puro em arquivos escritos em outras linguagens, such as Javascript or HTML. como o Javascript ou HTML. O código Ruby está contido dentro de tags específicas (`<%` e `%>`) que instruem o sistema para executar o conteúdo. Se um sinal `=` acompanha as tags, (`<%=` e %`>`) em seguida, os conteúdos são executados e renderizados na página.

Por exemplo, se você tivesse 25 ideias ativas em seu aplicativo, o código:
`Atualmente há <%= Idea.count %> ideas ativas`
Renderizaria:
> Atualmente há 25 ideias ativas

### Arquitetura MVC 
Em uma aplicação Rails padrão (como a que você tem gerado), o `app/` pasta da sua aplicação começa com três pastas (ou diretórios): ‘models’ (que nós já discutimos), ‘controllers’ (controladores) and ‘views’ (visões). A relação entre esses diretórios é a base (conhecido como MVC Architecture) da aplicação e do desenvolvimento Rails.

Quando você executou o comando `rails generate scaffold` command, além de criar o model de idea, você também criou um controlador que acompanha ideias (`ideas_controller.rb`), localizado na pasta controladores, e uma pasta view ideas que contém vários arquivos que você irá usar para criar uma aplicação dinâmica.

Ao tentar exibir um site Rails, um navegador da Web envia uma solicitação através do servidor que eventualmente atinge o *controller* (controlador) do Rails. *Controllers* trabalham como mediadores entre as *views* e os *models*. Quando o *controller* recebe a informação, ele se comunica com o *model* representando um recurso da aplicação (no nosso caso, uma “idea”) que por sua vez comunica com a base de dados. Após recuperar as informações necessárias a partir do *model*, o *controller* renderiza a *view* que retorna a página web completa para o navegador como HTML.

### CSS and layouts
CSS (Cascading Style Sheets) é uma linguagem usada para descrever a formatação de páginas escritas em uma ‘linguagem de marcação’, ou seja, uma linguagem para processamento, definindo e apresentando texto com um código de formatação prescrita por exemplo tags,que o distinguem de texto simples. A aplicação mais comum de CSS é em conjunto com HTML.
{% highlight css %}
body { padding-top: 100px; }
footer { margin-top: 100px; }
table, td, th { vertical-align: middle; border: none; }
th { border-bottom: 1px solid #DDD; }
{% endhighlight %}

Dentro do CSS você deve ter aplicado:

`body` (corpo) - esta parte é conhecido como o selector e refere-se ao elemento HTML que você deseja estilo.
`{ padding-top: 100px; }` - Esta parte é conhecida como a declaração;  cada declaração tem uma propriedade que é o estilo de atributo que deseja alterar (`padding-top`), Declarações sempre terminam com um ponto e vírgula e declaração grupos são sempre cercada por chaves.

Para cada aplicação Rails há um arquivo de layout padrão chamado `application.html.erb`, localizado na pasta layouts do seu diretório views. Com este arquivo você pode criar um formato padrão para todas as páginas em seu aplicativo.

{% highlight html %}
<link rel="stylesheet" href="http://railsgirls.com/assets/bootstrap.css">
{% endhighlight %}

No código acima, o `link rel` (link relação)  está definindo a natureza da URL que o atributo `href` (referência de hipertexto) está solicitando conteúdo. Este argumento indica que a fonte externa é solicitada uma folha de estilo eo navegador web vai precisar obter esse arquivo para processar a página corretamente.

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

- A tag HTML `div`divide o código em partes.
- A *class container* adiciona estilo adicional para tudo dentro das tags div
- O `<%= yield %>` argumento é responsável por inserir o conteúdo original de cada página dentro da `div` container. Isto significa que na sua aplicação o layout geral pode ser consistente mesmo que o conteúdo seja diferente de uma página para outra.

## <a id="4_add_upload_imagens">*4.* Add picture uploads</a>

### Bibliotecas
Muitas linguagens de programação, incluindo Ruby, utilizam uma ampla gama de bibliotecas. No caso de Ruby, a maioria destas bibliotecas são liberadas na forma de pacotes independentes chamados *gems*,que contêm todas as informações necessárias para instalar e implementá-las. Essas gems estão contidas no arquivo `Gemfile` da sua aplicação e se você olhar neste arquivo você vai notar que quando você criou sua primeira aplicação Rails ele veio com várias gems que garantem as funções da aplicação corretamente.

Gems ajudam a simplificar e evitar a repetição no código de um desenvolvedor, de acordo com o DRY (Don’t Repeat Yourself) princípio do desenvolvimento de software. Gems podem resolver problemas específicos, adicionar funcionalidade específica, ou atender aos requisitos específicos, significando que deveria outro desenvolvedor encontrar um cenário semelhante, em vez de escrever novo código, eles podem instalar uma gem contendo o código pré-escrito. Por exemplo, “CarrierWave”, a gem que você está adicionando ao seu Gemfile é projetada para tornar mais fácil o upload de arquivos para a sua aplicação.

“Bundler” é o software Ruby usado para controlar e gerenciar gems. O comando `bundle` roda o Bundler e instala as gems especificadas em seu Gemfile. Você notará que o `código fonte 'https://rubygems.org'` no topo do seu Gemfile.Sempre que você adicionar uma gem para o seu Gemfile e execute o comando `bundle`, este código informa o aplicativo para buscar a gem de [https://rubygems.org](https://rubygems.org). “RubyGems” é um sistema de pacotes específico para o Ruby, cujo objectivo é simplificar a criação, compartilhamento e instalação de gems.

### Software livre

Tanto o framework Rails e a linguagem Ruby são exemplos de software de código aberto. Software de código aberto  é distribuído sob uma licença que garante o acesso universal; ninguém tem o direito de mudar, estudar e distribuir o software. Fazendo o código fonte acessível permitindo o estabelecimento de uma diversificada, reflexiva, colaborativa e, consequentemente, uam comunidade interativa de programadores em constante evolução que beneficiam uns aos outros programadores.


### Mais HTML

The file `app/views/ideas/_form.html.erb` contains HTML code that determines the look and feel of the form used for editing and creating ideas (the `edit.html.erb` and `new.html.erb` views). A partial is a snippet of HTML and Ruby code that can be reused in multiple locations. The form for editing existing ideas and the form for creating new ideas will look pretty much the same, so it makes sense to have one form for both files to use. If you look in these files you’ll notice that they have a customised heading (e.g. `<h1>Editing idea</h1>`) and then they simply say `<%= render 'form' %>` which tells Rails to render the partial `_form.html.erb`.

If you take a look in the `_form.html.erb` file, you will see the code `form_for` in the first line of code. This is a block used to create an HTML form. Using this block, we can access methods to put different input fields in the form.

The code we are implementing, `<%= f.file_field :picture %>`, tells Rails to create a file input on the form and map the submitted information to the ‘picture’ attribute of an ‘idea’ in our ideas database table. We changed the code from `<%= f.text_field :picture %>` to `<%= f.file_field :picture %>` because `file_field` makes it easier for the user to select the image they wish to upload.

In the code `<%= @idea.picture %>`, `@idea` is known as an *instance variable*. Instance variables are prefixed with an @ symbol and are defined in the controller action that corresponds with the view in which they are referenced. For the purposes of the code we are implementing, `@idea` is defined in the ‘show’ action of the `Ideas` controller, with the code `@idea = Idea.find(params[:id])`. This makes it available for us to use in the view `show.html.erb`. It could be defined differently in different controller actions (e.g. index or new). The code `@idea = Idea.find(params[:id])` uses the Rails `find` method to retrieve specific ideas from the database.

The code that follows the `@idea` variable (`.picture`) tells Rails to access the ‘picture’ attribute of our resource (idea). By replacing the code  `<%= @idea.picture %>` with `<%= image_tag(@idea.picture_url...)` we are using the Ruby `image_tag` *helper* which translates to an HTML `<img>` tag (used to define images in HTML) but by default retrieves images from the folder public/images, which is where our uploaded images are stored. The `image_tag` helper also allows us to insert a block of code which creates a path to an image associated with a particular idea (`@idea.picture_url`).

You will notice that within this block of code you are implementing we are also able to set a default width for each image (`:width => 600`). The final line of code `if @idea.picture.present?` tells Rails to check the corresponding database table to see whether a picture exists before rendering the code underneath.

## <a id="5_finetune_the_routes">*5.* Finetune the routes</a>

In a functional Rails application, there is an inbuilt system in place for translating incoming requests from the browser in order to return the intended response. This system is called *routing*. Requests from the browser are interpreted as specific HTTP methods. HTTP (Hypertext Transfer Protocol) is the protocol that defines how information (usually webpages or webpage components composed of text with hyperlinks - ‘hypertext’), is formatted and transmitted across the internet. There are four primary HTTP methods, each of which is a request to perform an operation on a specific resource (e.g. users, posts); GET, POST, PUT and DELETE. Rails’ inbuilt routing system automatically generates routes for each resource that map to specific actions (index, show, new, edit, create, update, delete) defined in the controller. So, for each of our models, there are seven related actions defined in the associated controller, `ideas_controller.rb`. These actions specify the appropriate response (a ‘method’) which is most likely to render the corresponding view, e.g. `ideas/index.html.erb`.


<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<td>HTTP Method</td>
			<td>Path</td>
			<td>Action</td>
			<td>used for</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>GET</td>
			<td>/ideas</td>
			<td>index</td>
			<td>displaying a list of all ideas</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/ideas/new</td>
			<td>new</td>
			<td>returning an HTML form for creating a new idea</td>
		</tr>
		<tr>
			<td>POST</td>
			<td>/ideas</td>
			<td>create</td>
			<td>creating a new idea</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/photos/:id</td>
			<td>show</td>
			<td>displaying a specific photo</td>
		</tr>
		<tr>
			<td>GET</td>
			<td>/photos/:id/edit</td>
			<td>edit</td>
			<td>returning an HTML form for editing a specific photo</td>
		</tr>
		<tr>
			<td>PUT</td>
			<td>/photos/:id</td>
			<td>update</td>
			<td>updating a specific photo</td>
		</tr>
		<tr>
			<td>DELETE</td>
			<td>/photos/:id</td>
			<td>destroy</td>
			<td>deleting a specific photo</td>
		</tr>
	</tbody>
</table>


If you look in your `ideas_controller.rb` you can see these actions and the associated behaviour, and the HTTP method that corresponds with each action:

{% highlight rb %}
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

`show` - the controller action

{% highlight rb %}
respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
{% endhighlight %}

(This code is difficult to dissect with much clarity at this stage but if you persist with Rails you will get a better understanding as time progresses.)

In the above definition of the show action, Rails is using a `respond_to` helper method, which tells Rails to execute the subsequent *block* of code (the code enclosed by the `do...end` syntax). This code contains two different formatting options depending on the nature of the request. If the browser requests HTML then the HTML code contained in the view that corresponds with this controller action (`show.html.erb`) is rendered. If json is requested then the view is bypassed and limited information is provided.

`GET` - this is a comment to let us know which HTTP method is being executed.

So, URL requests, translated into HTTP methods, are mapped to controller actions which tell Rails to return a view.

When we insert the code `root :to => redirect('/ideas')` into our `config.rb`, it tells Rails to make the default root of our application [http://localhost:3000/ideas](http://localhost:3000/ideas) (note Localhost is being used as the domain because our application is still in development, when you launch your application this domain will be different). This URL contains a path (`/ideas`) which, by default, maps the URL to the ‘index’ action of our ideas controller and renders the associated view; `index.html.erb`. The code `rm public/index.html` removes (`rm`) the `public/index.html` file, containing the “Welcome Aboard” code, which was the previous default root for our application.
