---
layout: default
title: Rails Girls no OpenShift
permalink: openshift
---

# Colocar Seu App Online com OpenShift

*Criado por Katie Miller, [@codemiller](https://twitter.com/codemiller)*
*Traduzido por Marcela Oliveira, [@magaeu](https://twitter.com/magaeu)*

### Adquira o OpenShift

OpenShift é uma Plataforma como Serviço (PaaS) em computação em nuvem que facilita a implantação de apps online. Ele é código aberto e escrito em Ruby.

Para começar [crie uma conta Online no OpenShift](https://www.openshift.com/app/account/new), que permite que você adicione três apps online de graça. Uma vez cadastrado, instale o RHC Client Tools do OpenShift para executar os comandos abaixo no terminal:

{% highlight sh %}
gem install rhc
rhc setup
{% endhighlight %}

As instruções acima presumem que você já tenha instalado o Ruby utilizando RVM ou RailsInstaller. Se você utilizou outra abordagem, há mais informações sobre como instalar o RHC em outras configurações [nesse guia](https://www.openshift.com/developers/rhc-client-tools-install) (talvez seja necessário executar `sudo gem install rhc`).

__COACH__: Fale sobre os benefícios de utilizar um PaaS como o OpenShift quando comparado aos servidores tradicionais. Fale sobre SSH e o porquê é necessário fazer o upload da chave pública para que ocorra uma comunicação segura.

### Preparando seu app

#### Criar uma aplicação OpenShift

Nós vamos criar uma aplicação Ruby OpenShift com o banco de dados PostgreSQL utilizando um modelo de uma aplicação Rails OpenShift como ponto inicial. Antes de iniciarmos, através do terminal, mude para o diretório onde se encontra o código da sua aplicação `railsgirls`, provavelmente chamado de `projects`. O comando `cd` abaixo irá mudar o diretório, caso você já esteja no `railsgirls`; caso não, substitua por outro `cd` comando.

{% highlight sh %}
cd ..
pwd
{% endhighlight %}

A saída para o comando `pwd` ou `present working directory` deve mostrar que você está no diretório `projects` (ou qualquer outro nome que você tenha dado ao seu diretório principal). Para criar um OpenShift app em nuvem e fazer uma cópia local dos arquivos que serão criados, execute o seguinte comando em seu terminal.

_NB: Esse comando é para aqueles que utilizam Ruby 2.x e Rails 4. Se você instalou o Ruby 1.9.x, substitua `ruby-2.0` no comando por `ruby-1.9`. Para o Rails 3, substitua o `--from-code` para a URL `https://github.com/openshift/rails-example.git`._

{% highlight sh %}
rhc app create openshiftapp ruby-2.0 postgresql-9.2 --from-code=https://github.com/openshift/rails4-example.git
{% endhighlight %}

Se aparecer uma mensagem como `Tem certeza que quer continuar a conexão (sim/não)? (Em inglês: `Are you sure you want to continue connecting (yes/no)?`), digite `sim (yes)` e aperte enter.

A saída do terminal deve conter a URL; abra a janela do navegador e digite a URL da aplicação para visualizar o modelo da aplicação Rails (a URL terá o seguinte formato http://openshiftapp-*yourdomain*.rhcloud.com).

__COACH__: Explique o que é o Git e o porquê nós usamos sistemas de controle de versão.

#### Adicionar controle de versão

Nós temos agora um modelo de aplicação rodando em nuvem, mas só precisamos de pequenos pedaços desse código base. Antes de copiarmos os bits que precisamos, devemos colocar nossa aplicação Rails Girls sob controle de versão com o Git.

Retorne ao diretório da aplicação `railsgirls` e inicialize o diretório como um repositório do Git com o seguinte comando:

{% highlight sh %}
cd railsgirls
git init
{% endhighlight %}

Nós não queremos as imagens que foram carregadas durante o desenvolvimento da aplicação sejam parte do nosso repositório, então execute o seguinte comando para que o Git ignore esses arquivos:

{% highlight sh %}
echo "public/uploads" >> .gitignore
{% endhighlight %}

Adicione e comite todos os arquivos da sua aplicação no repositório do Git com o seguinte comando:

{% highlight sh %}
git add --all
git commit -m "First commit of Ideas app"
{% endhighlight %}

__COACH__: Explique os comandos do Git utilizados e o .gitignore.

#### Copiar código da aplicação modelo

Nós precisamos do diretório `.openshift` e arquivo `config/database.yml` da aplicação modelo para sua aplicação Rails rodar no OpenShift. Copie esses arquivos do diretório `openshiftapp` contido no diretório `railsgirls`. Você pode utilizar o Windows Explorer ou outra ferramenta gráfica de gerenciamento de arquivos para realizar essa etapa, ou pode executar os seguintes comandos no diretório `railsgirls` a partir do seu terminal:

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

Check that the copying has worked by looking in the `railsgirls` app directory. There should now be a subdirectory called `.openshift`. Open the file `config/database.yml`; it should now contain OpenShift environment variables such as `OPENSHIFT_APP_NAME`. If your `database.yml` file does not contain variables like this, try opening `.openshift/config/database.yml` or `openshiftapp/config/database.yml` in your editor and copying across the contents of the file.

Add and commit the new and changed files in Git with the below commands.

{% highlight sh %}
git add --all
git commit -m "Added OpenShift config"
{% endhighlight %}

#### Mudar o banco de dados

A próxima etapa é mudar nosso banco de dados do Rails Girls do SQLite para PostgreSQL. Abra o arquivo `Gemfile` da sua aplicação e substitua:

{% highlight ruby %}
gem 'sqlite3'
{% endhighlight %}

com

{% highlight ruby %}
gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:production]
{% endhighlight %}

Execute um bundle para configuração as dependências da sua aplicação:

{% highlight sh %}
bundle install --without production
{% endhighlight %}

Em alguma plataformas, esse comando pode gerar versão específicas da plataforma que podem gerar problemas para sua aplicação quando for tentar enviá-la (push) para o ambiente em nuvem. Para prevenir esse problema, abra seu arquivo `Gemfile.lock` e verifique as versões das Gems 'sqlite3' e 'pg'. Se elas possuirem um sufixo específico da plataforma, como `-x86-mingw32`, remova o sufixo (ex. mude `pg (0.16.0-x86-mingw32)` para `pg (0.16.0)` e `sqlite3 (1.3.8-x86-mingw32)` para `sqlite3 (1.3.8)`). Salve e feche o arquivo, e execute o comando de bundle novamente antes de continuar.

Adicione e comite suas mudanças no Git:

{% highlight sh %}
git add --all
git commit -m "Changed production database to PostgreSQL"
{% endhighlight %}

__COACH__: Fale sobre banco de dados relacionais e as diferenças entre SQLite e PostgreSQL.

### Implantar a aplicação no OpenShift

We are now ready to deploy the Rails Girls app to OpenShift. We need to tell our Git repository where to push the code. To get the location of your OpenShift code repository, run the following command, and copy the Git URL from the output.

{% highlight sh %}
rhc app show openshiftapp
{% endhighlight %}

Now run the following commands, replacing the SSH string with your Git URL. We are using '-f' for force here because we are happy to wipe away the history of the current OpenShift repository, which contains the sample Rails app. When you are pushing future changes, you can just use 'git push'.

{% highlight sh %}
git remote add openshift ssh://0123456789abcdef01234567@openshiftapp-yourdomain.rhcloud.com/~/git/openshiftapp.git/
git push -f --set-upstream openshift master
{% endhighlight %}

Refresh the app in your browser to see the result.

__COACH__: Talk about Git remotes.

### Extra credit

Congratulations - your Rails application is now online for the whole world to admire. The following sections explain optional further steps you can take to improve and share your app.

#### Persist uploaded images

The app should be looking pretty good now, but there is an issue lurking because of the ephemeral nature of the deployment. When we push a new version of the application, anything stored within OpenShift's copy of the repo will be wiped to make way for the new files. This includes the images uploaded by users. To fix this, we can store these files in a persistent directory on OpenShift instead. The filepath of the location we need is stored in an environment variable.

__COACH__: Explain the motivation for using environment variables.

The directory where uploaded pictures are currently stored is within the app repository, so it will be deleted when we rebuild. To switch the uploads directory to one that will persist, open `app/uploaders/picture_uploader.rb` and replace

{% highlight ruby %}
def store_dir
  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
end
{% endhighlight %}

with

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

Now uploaded images will be stored in a persistent directory, but they will still be available through the same URL as what we were using previously. To make this work, we also need to add a symbolic link on the filesystem from the repository location to the real storage location. To do this, open `.openshift/action_hooks/build` and add the following code:

{% highlight sh %}
mkdir -p $OPENSHIFT_DATA_DIR/uploads
ln -sf $OPENSHIFT_DATA_DIR/uploads $OPENSHIFT_REPO_DIR/public/uploads

{% endhighlight %}

This action hook code will run every time the OpenShift app is built, so the link between the directories will always be there when it's needed.

Commit your changes and push them to the cloud:

{% highlight sh %}
git add --all
git commit -m "Added OpenShift environment variables"
git push
{% endhighlight %}

The images you uploaded before making this change will no longer display, but anything uploaded now will stick around between app rebuilds.

__COACH__: Explain symbolic links.

#### Push code to GitHub

Now that your application is under source control with Git, you may also wish to share a copy with others on a Git repository website such as GitHub. To push your code to a GitHub repository, [create a repository](https://github.com/new) on GitHub and copy the HTTPS string (something like *https://github.com/username/reponame.git*).

Navigate to your OpenShift app repository in the terminal and enter the following commands, replacing the HTTPS location with the string you copied:

{% highlight sh %}
git remote add github https://github.com/username/reponame.git
git push github master
{% endhighlight %}

The 'master' branch of the local copy of your repository will be pushed to GitHub. Go to the GitHub website to check it out.

__COACH__: Talk about Git branches and the benefits of open source code.

### Conclusion

Your Rails app is now running in the cloud on [OpenShift](https://www.openshift.com/developers). You can push whatever other changes you like and share the URL to show off your app to your friends.
