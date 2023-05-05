---
layout: default
title: Rails Girls no OpenShift
permalink: openshift
---

# Colocar Seu App Online com OpenShift

*Criado por Katie Miller, [@codemiller](https://twitter.com/codemiller)*

*Traduzido por Marcela Oliveira, [@magaeu](https://twitter.com/magaeu)*

### Utilizando o OpenShift

OpenShift é uma Plataforma como Serviço (PaaS) em computação em nuvem que facilita a implantação de aplicações online. Ele é uma plataforma de código aberto e escrito em Ruby.

Para começar [crie uma conta Online no OpenShift](https://www.openshift.com/app/account/new), que permite que você adicione três aplicações online de graça. Uma vez cadastrado, instale o RHC Client Tools do OpenShift para executar os comandos abaixo no terminal:

{% highlight sh %}
gem install rhc
rhc setup
{% endhighlight %}

As instruções acima presumem que você já tenha instalado o Ruby utilizando RVM ou RailsInstaller. Se você utilizou outra abordagem, há mais informações sobre como instalar o RHC em outras configurações [nesse guia](https://www.openshift.com/developers/rhc-client-tools-install) (talvez seja necessário executar `sudo gem install rhc`).

__INSTRUTOR(A)__: Fale sobre os benefícios de utilizar um PaaS como o OpenShift quando comparado aos servidores tradicionais. Fale sobre SSH e o porquê é necessário fazer o upload da chave pública para que ocorra uma comunicação segura.

### Preparando sua aplicação

#### Criar uma aplicação OpenShift

Nós vamos criar uma aplicação Ruby OpenShift com banco de dados PostgreSQL utilizando um modelo de uma aplicação Rails OpenShift como ponto de partida. Antes de iniciarmos, através do terminal, mude para o diretório onde se encontra o código da sua aplicação `railsgirls`, provavelmente chamado de `projects`. Caso você esteja no diretório `railsgirls`, o comando `cd` abaixo irá mudar o diretório; caso não, substitua por outro comando `cd`.

{% highlight sh %}
cd ..
pwd
{% endhighlight %}

A saída para o comando `pwd` ou `present working directory` deve mostrar que você está no diretório `projects` (ou qualquer outro nome que você tenha dado ao seu diretório principal). Para criar uma aplicação OpenShift em nuvem e fazer uma cópia local dos arquivos que serão criados, execute o seguinte comando em seu terminal.

_NB: Esse comando é para aqueles que utilizam Ruby 2.x e Rails 4. Se você instalou o Ruby 1.9.x, substitua `ruby-2.0` no comando por `ruby-1.9`. Para o Rails 3, substitua o `--from-code` pela URL `https://github.com/openshift/rails-example.git`._

{% highlight sh %}
rhc app create openshiftapp ruby-2.0 postgresql-9.2 --from-code=https://github.com/openshift/rails4-example.git
{% endhighlight %}

Se aparecer uma mensagem como `Tem certeza que quer continuar a conexão (sim/não)?` (Em inglês: `Are you sure you want to continue connecting (yes/no)?`), digite `sim (yes)` e aperte enter.

A saída do terminal deve conter a URL; abra a janela do navegador e digite a URL da aplicação para visualizar o modelo da aplicação Rails (a URL terá o seguinte formato http://openshiftapp-*yourdomain*.rhcloud.com).

__INSTRUTOR(A)__: Explique o que é o Git e o porquê nós usamos sistemas de controle de versão.

#### Adicionar controle de versão

Nós temos agora um modelo de aplicação rodando em nuvem, mas só precisamos de pequenos pedaços desse código base. Antes de copiarmos os bits que precisamos, devemos colocar nossa aplicação Rails Girls sob controle de versão com o Git.

Retorne ao diretório da aplicação `railsgirls` e inicialize o diretório como um repositório do Git com o seguinte comando:

{% highlight sh %}
cd railsgirls
git init
{% endhighlight %}

Nós não queremos que as imagens que foram carregadas durante o desenvolvimento da aplicação sejam parte do nosso repositório, então execute o seguinte comando para que o Git ignore esses arquivos:

{% highlight sh %}
echo "public/uploads" >> .gitignore
{% endhighlight %}

Adicione e comite todos os arquivos da sua aplicação no repositório do Git com o seguinte comando:

{% highlight sh %}
git add --all
git commit -m "First commit of Ideas app"
{% endhighlight %}

__INSTRUTOR(A)__: Explique os comandos do Git utilizados e o .gitignore.

#### Copiar código da aplicação modelo

Nós precisamos do diretório `.openshift` e arquivo `config/database.yml` da aplicação modelo para que sua aplicação Rails possa rodar no OpenShift. Copie esses arquivos do diretório `openshiftapp` contido no diretório `railsgirls`. Você pode utilizar o Windows Explorer ou outra ferramenta gráfica de gerenciamento de arquivos para realizar essa etapa, ou pode executar os seguintes comandos no diretório `railsgirls` a partir do seu terminal:

<div class="os-specific">
   <div class="nix">
{% highlight sh %}
cp -r ../openshiftapp/.openshift .
cp ../openshiftapp/config/database.yml config
{% endhighlight %}
  </div>

  <div class="win">
{% highlight sh %}
xcopy /e /i ..\openshiftapp\.openshift .openshift
xcopy /y ..\openshiftapp\config\database.yml config
{% endhighlight %}
  </div>
</div>

Verifique se a etapa de cópia dos arquivos funcionou olhando o diretório da aplicação `railsgirls`. Agora deve haver um subdiretório chamado `.openshift`. Abra o arquivo `config/database.yml`; ele agora deve agora conter as variáveis de ambiente do OpenShift como `OPENSHIFT_APP_NAME`. Se seu arquivo `database.yml` não tiver variáveis assim, tente abrir `.openshift/config/database.yml` ou `openshiftapp/config/database.yml` em seu editor de texto e copie o conteúdo do arquivo.

Adicione e comite suas novas mudanças no Git com os comandos abaixo.

{% highlight sh %}
git add --all
git commit -m "Added OpenShift config"
{% endhighlight %}

#### Mudar o banco de dados

A próxima etapa é mudar nosso banco de dados do Rails Girls do SQLite para PostgreSQL. Abra o arquivo `Gemfile` da sua aplicação e substitua:

{% highlight ruby %}
gem 'sqlite3'
{% endhighlight %}

por

{% highlight ruby %}
gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:production]
{% endhighlight %}

Execute um bundle para configurar as dependências da sua aplicação:

{% highlight sh %}
bundle install --without production
{% endhighlight %}

Em algumas plataformas, esse comando pode gerar versões específicas da plataforma que podem gerar problemas para sua aplicação quando for tentar enviá-la (push) para o ambiente em nuvem. Para prevenir esse problema, abra seu arquivo `Gemfile.lock` e verifique as versões das Gems 'sqlite3' e 'pg'. Se elas possuírem um sufixo específico da plataforma, como `-x86-mingw32`, remova o sufixo (ex. mude `pg (0.16.0-x86-mingw32)` para `pg (0.16.0)` e `sqlite3 (1.3.8-x86-mingw32)` para `sqlite3 (1.3.8)`). Salve e feche o arquivo, e execute o comando de bundle novamente antes de continuar.

Adicione e comite suas mudanças no Git:

{% highlight sh %}
git add --all
git commit -m "Changed production database to PostgreSQL"
{% endhighlight %}

__INSTRUTOR(A)__: Fale sobre banco de dados relacionais e as diferenças entre SQLite e PostgreSQL.

### Implantar a aplicação no OpenShift

Agora estamos prontos para implantar a aplicação Rails Girls no OpenShift. Nós precisamos informar ao repositório do Git para enviar (push) o código. Para obter a localização do seu repositório no OpenShift execute o seguinte comando e copie a URL que será exibida como saída.

{% highlight sh %}
rhc app show openshiftapp
{% endhighlight %}

Agora execute os seguintes comandos, substituindo o texto SSH com a sua URL do Git. Nós estamos utilizando '-f' aqui para forçar que o Git apague todo o histórico da aplicação atual no repositório do OpenShift, o qual contém o modelo da aplicação Rails. Quando você estiver enviando futuras mudanças, você só precisa utilizar 'git push'.

{% highlight sh %}
git remote add openshift ssh://0123456789abcdef01234567@openshiftapp-yourdomain.rhcloud.com/~/git/openshiftapp.git/
git push -f --set-upstream openshift master
{% endhighlight %}

Atualize a aplicação no seu navegador para ver o resultado.

__INSTRUTOR(A)__: Fale sobre o Git remoto.

### Crédito extra

Parabéns! Sua aplicação Rails está online para todo o mundo admirar. As seguintes seções servirão para explicar passos opcionais para você melhorar e compartilhar sua aplicação.

#### Armazenar imagens adicionadas

A aplicação deve estar muito boa agora, mas existe um pequeno problema ocasionado pela natureza temporária do ambiente de implantação. Quando nós enviamos uma nova versão da aplicação, tudo o que está armazenado na cópia do repositório do OpenShift é removido para dar espaço para novos arquivos. Isso inclui as imagens carregadas pelos usuários. Para resolver esse problema, nós podemos armazenar os arquivos num diretório do OpenShift. O caminho para esse armazenamento pode ser salvo em uma variável de ambiente.

__INSTRUTOR(A)__: Explique a motivação para utilizar variáveis de ambiente.

O diretório onde as imagens são atualmente armazenadas é o diretório da aplicação, que será apagado quando refizermos a aplicação. Para mudar o diretório de armazenamento, abra `app/uploaders/picture_uploader.rb` e substitua

{% highlight ruby %}
def store_dir
  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
end
{% endhighlight %}

por

{% highlight ruby %}
def store_dir
  prefix = ENV['OPENSHIFT_DATA_DIR'] ? "#{ENV['OPENSHIFT_DATA_DIR']}/" : ""
  "#{prefix}uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
end

def url
  return "/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{File.basename(file.path)}" if ENV['OPENSHIFT_DATA_DIR'] && file
  super
end
{% endhighlight %}

Agora as imagens carregadas serão armazenadas no diretório, porém elas ainda estarão disponíveis na mesma URL que estávamos utilizando anteriormente. Para fazer isso funcionar, nós também precisaremos adicionar um link simbólico no sistema de arquivo da localização do repositório para a localização real de armazenamento. Para realizar essa etapa, abra `.openshift/action_hooks/build` e adicione o seguinte código:

{% highlight sh %}
mkdir -p $OPENSHIFT_DATA_DIR/uploads
ln -sf $OPENSHIFT_DATA_DIR/uploads $OPENSHIFT_REPO_DIR/public/uploads

{% endhighlight %}

Essa ação de linkar o código será executada toda vez que a aplicação do OpenShift for construída, então o link entre os diretórios sempre estará disponível quando necessário.

Comite suas mudanças e as envie para o repositório em nuvem:

{% highlight sh %}
git add --all
git commit -m "Added OpenShift environment variables"
git push
{% endhighlight %}

As imagens carregadas antes dessa mudança ser realizada não serão visualizadas, mas tudo que for carregado a partir de agora será armazenado entre as reconstruções da aplicação.

__INSTRUTOR(A)__: Explique links simbólicos.

#### Enviar o código para o GitHub

Agora que sua aplicação está sobre controle de versão com o Git, você pode querer compartilhar uma cópia dela em um website que utilize Git como o GitHub. Para enviar seu código para o repositório do GitHub, [crie um repositório](https://github.com/new) no GitHub e copie o link HTTPS (algo como *https://github.com/username/reponame.git*).

Explore o repositório da sua aplicação OpenShift no terminal e execute os seguintes comandos, substituindo o texto HTTPS com a URL copiada anteriormente:

{% highlight sh %}
git remote add github https://github.com/username/reponame.git
git push github master
{% endhighlight %}

A branch 'master' local do seu repositório será enviada para o GitHub. Acesse o website do GitHub e verifique se está tudo certo.

__INSTRUTOR(A)__: Fale sobre as branches do Git e os benefícios do código aberto.

### Conclusão

Sua aplicação Rails agora está rodando em nuvem no [OpenShift](https://www.openshift.com/developers). Você pode enviar quaisquer outras mudanças que você queira e compartilhar a URL e mostrar sua aplicação para seus amigos.

{% include other-guides.md page="openshift" %}
