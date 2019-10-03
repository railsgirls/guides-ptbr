---
layout: default
título: App para turismo de autismo amigável
permalink: touristic-autism_continuous-deployment
---

# Deploy Contínuo

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*.
Os guias básicos que foram unidos e adaptados são o [Tutorial de Ruby on Rails](http://www.railstutorial.org/book), o [RailsGirls app básico](http://guides.railsgirls.com/app/) e os tutorias para [criar thumbnails](http://guides.railsgirls.com/thumbnails), [autenticar usuários](http://guides.railsgirls.com/devise/), [adicionar design](http://guides.railsgirls.com/design), [deploy ao OpenShift](http://guides.railsgirls.com/openshift/) e [adicionar comentários](http://guides.railsgirls.com/commenting).
Traduzido por Renan Muliterno, [rmuliterno](https://github.com/rmuliterno)



Nós iremos realizar o deploy da nossa(ainda vazia) aplicação Rails, para produção. Realizar o deploy cedo e com frequência nos permite captar problemas de deploy no começo do nosso ciclo de desenvolvimento, caso contrário podemos ter problemas durante a fase de integração.
Vários hosts compartilhados, servidores virtuais privados, empresas de deploy de serviços inteiros e serviços de deploy em nuvem, todos fornecem ferramentas que facilitam o deploy de aplicações Rails.

OpenShift é um dos serviços de deploy em nuvem que oferecem tais ferramentas. É uma plataforma de computação em nuvem como um serviço (Paas) que facilita o deploy de aplicativos online. É de código aberto e escrito em Ruby.



[Criar uma conta no OpenShift](https://openshift.redhat.com/app/account/new?web_user[promo_code]=railsgirls), nos permite colocar 3 aplicações online de graça. Após entrar com sua conta, instale o OpenShift RHC Client Tools (Ferramentas do Cliente RHC OpenShift) adicionando a gema rhc no ambiente de produção. Adicione o seguinte código para o arquivo Gemfiile (que é escrito em Ruby ndr):

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
      group :production do
        gem 'rhc'
      end
    {% endhighlight %}
  </div>
  

Se você não está usando o RVM ou o RailsInstaller então siga [esse guia](https://www.openshift.com/developers/rhc-client-tools-install)
(você talvez precise executar o comando "sudo gem install rhc").
</div>

Então rode no terminal:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
  bundle install --without production
  rhc setup
{% endhighlight %}
  </div>
A opção --without production previne a instalação local de alguma gema de produção.

Se o Bundler mostrar algum erro na leitura, tente adicionar gem `rb-readline` para o seu Gemfile.

Como as únicas gemas que nós adicionamos estão restritas à um ambiente de produção, no momento esse comando não instala nenhuma gema local adicional, mas esse comando é necessário para atualizar o arquivo `Gemfile.lock`. Agora, vamos realizar o commit dessas alterações ao GitHub!
</div>

**Instrutor(a):** Explique os benefícios do deploy em um PaaS, como o OpenShift, ao invés de servidores tradicionais. O que "produção" quer dizer. Falar sobre SSH e por quê temos que subir uma chave pública para realizar comunicações com segurança.
[Slides por Gerry Kavanagh @gerryk]()

Navegue para a pasta `projects`. Rode no prompt:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
rhc app create openshiftapp ruby-1.9 postgresql-9.2 --from-code=https://github.com/openshift/rails-example.git
{% endhighlight %}
  </div>
</div>

Precisamos do diretório `.openshift` e do arquivo `config/database.yml` da aplicação de exemplo para o nosso app em Rails rodar no OpenShift.
Copie isso do diretório `openshiftapp` para o diretório `railsgirls`.

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
cd railsgirls-galway-2014 
cp -r ../openshiftapp/.openshift .
cp ../openshiftapp/config/database.yml config
{% endhighlight %}
  </div>
Agora adicione e realize o commit dessas mudanças no Git!
</div>

OpenShift usa o banco de dados PostgresSQL, o que significa que devemos adicionar a gema `pg` no ambiente de produção para permitir que o Rails se comunique com o Postgres. Note, também, a adição da gema `rails_12factor`, que é usada para servir recursos estáticos como imagens e folhas de estilo.
Substitua `gem sqlite` no Gemfile com o seguinte código:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:production]
gem 'rails_12factor', :group => [:production]
{% endhighlight %}
  </div>
Agora faça um bundle excluíndo as gemas em produção.

Em algumas plataformas, isso pode gerar versões de plataformas específicas das suas Gems o que pode causar problemas quando você colocar seu app na nuvem. Para prevenir isso, abra o seu arquivo Gemfile.lock e cheque as versões das Gems `sqlite3` e `pg`. Se elas possuem um sufixo específico de plataforma como -x86mingw32, remova-os (por exemplo troque pg (0.16.0-x86-mingw32) para pg (0.16.0) e sqlite3 (1.3.8-x86-mingw32) para sqlite3 (1.3.8)).
Salve e feche o arquivo, então rode o comando de bundle novamente antes de prosseguir.

Adicione e realize o commit dessas mudanças no Git!
</div>

**Instrutor(a):** Fala sobre banco de dados relacionais e as diferenças entre o SQLite e o PostgreSQL


Agora estamos prontos para fazer o deploy do app Rails Girls para o OpenShift. Nós precisamos especificar para o nosso repositório Git aonde enviar o código. Para pegar a localização do seu repositório OpenShift, rode o seguinte comando e copie a URL do Git da resposta.

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
       rhc app show openshiftapp
{% endhighlight %}
  </div>
</div>

Agora rode os seguintes comandos, trocando a string SSH com o seu URL do Git. Estamos usando `-f` para forçar porque é bom limpar o histórico do atual repositório OpenShift, que contém o app Rails de exemplo. Ao enviar mudanças futuras, poderá apenas usar um `git push`.

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
git remote add openshift ssh://5387bff65973cadf3c000323@openshiftapp-railsgirlsgalway.rhcloud.com/~/git/openshiftapp.git/
git push -f --set-upstream openshift master
{% endhighlight %}
  </div>

Reinicie o app no seu navegador para ver o resultado.
Se o app falhar (500 Internal Server Error) ou, geralmente (error from the rhc tail openshiftapp : "Missing `secret_key_base` for 'production' environment, set this value in `config/secrets.yml`").

O seguinte vai resolver:
Pegue um segredo com o `rake secret` e o designe para a variável de ambiente `SECRET_KEY_BASE` e exporte a variável para `~/.bash_profile`.
O OpenShift (o Heroku também) precisa servir recursos estáticos como imagens e CSS:
</div>
<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
$ rake assets:precompile
$ git add .
$ git commit -am "Add precompiled assets for OpenShift"
git push -f --set-upstream openshift master
{% endhighlight %}
  </div>

Somente para ser usado se o OpenShift falhar. Iremos falar sobre `rake` e `assets` mais pra frente.
</div>
Quando enviamos uma nova versão da aplicação, qualquer coisa armazenada na cópia do repositório OpenShift será limpada para liberar espaço para os novos arquivos. Isso inclui alguns arquivos de registros e imagens subidas por usuários. Para consertar isso, podemos armazenar esses arquivos em diretórios persistentes no OpenShift; o caminho das localizações que precisamos estão armazenadas em variáveis de ambiente.

Para trocar a localização do registro de produção, abra `config/environments/production.rb`. Logo abaixo da linha de comentário:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
{% endhighlight %}
  </div>
</div>

Adicione a linha:

<div class="os-specific">
  <div class="nix">
    {% highlight sh %}
config.logger = ActiveSupport::Logger.new(File.join(ENV['OPENSHIFT_RUBY_LOG_DIR'], "production.log"))
{% endhighlight %}
  </div>
Rails 3 users: Change ‘ActiveSupport::Logger’ to ‘ActiveSupport::BufferedLogger’.
</div>

Você pode monitorar os registros de sua aplicação com o comando `rhc tail openshiftapp` (o retorno da mudança que você acabou de fazer não será exibido até que o novo arquivo seja commitado e enviado para o OpenShift).

**Instrutor(a):** Discutir a importância de registros da aplicação.
