---
layout: default
title: Rails Girls on Passenger
permalink: passenger
---

# Facilite o desenvolvimento com o Phusion Passenger

_Criado por Floor Drees, [@floordrees](https://twitter.com/floordrees)_

_Traduzido por Frankyston Lins, [@frankyston](https://twitter.com/frankyston)_

### Há um servidor de aplicativos para isso

Certifique-se de seguir o [Coloque seu App no GitHub][github-guide] antes de continuar.

Este guia é para facilitar o desenvolvimento de seu aplicativo (você sabe, a funcionalidade de adição e, em seguida vamos verificar se ele realmente funciona), com o Passenger. O framework Ruby on Rails fornece uma ferramenta de servidor embutida, que você pode acessar com o comando `rails server`. O "servidor rails" não é um servidor de aplicativos sozinho, mas apenas um pequeno wrapper que inicia seu aplicativo em um servidor de aplicativos. As pessoas não usam o "servidor rails" em produção (onde outras pessoas podem acessar e usar seu aplicativo) e sim um servidor de aplicativos, como o Passenger.

**INSTRUTOR(A)**: O Passenger é um servidor de aplicativos da Web de código aberto. Ele lida com solicitações HTTP, gerencia processos e recursos e permite administração, monitoramento e diagnóstico de problemas. Para os grandes desenvolvedores, também há uma edição empresarial.

[github-guide]: http://guides.railsgirls.com/github

### Preparando seu app

#### Instalando a gem Passenger

Abra o `Gemfile` do seu app e adicione o "passenger":

{% highlight ruby %}
gem "passenger"
{% endhighlight %}

Adicionando o Passenger no Gemfile, o comando `rails server` iniciará o Passenger no lugar do Puma.

Você recebe pontos de bônus virtuais da equipe do Phusion Passenger por excluir as seguintes linhas (caso estejam presentes no seu Gemfile):

{% highlight ruby %}
gem "unicorn"
gem "thin"
gem "puma"
{% endhighlight %}

Execute `bundle install` para atualizar seus pacotes.

O texto no seu terminal deve dizer algo como isto:

{% highlight sh %}
bundle install
...
Installing passenger x.x.x
...
Your bundle is complete!
{% endhighlight %}

O Nginx e o Apache são servidores da web. Eles fornecem manipulação de transações HTTP e servem arquivos estáticos. Os servidores de aplicativos possibilitam que aplicativos Ruby falem HTTP. Aplicativos Ruby (e frameworks como o Rails) não podem fazer isso sozinhos. Em uma pilha de produção típica, seria usado o Nginx ou o Apache como o servidor da Web, o Passenger como servidor de aplicativos, e o Capistrano como ferramenta de automação de lançamento. O Passenger integra-se ao Nginx ou ao Apache e gerencia o aplicativo e seus recursos.

**INSTRUTOR(A)**: Às vezes você precisará especificar a versão da gem: `gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"`

#### Vamos checar se isso funcionou

Execute o servidor Passenger com o seguinte comando:

{% highlight sh %}
bundle exec passenger start
{% endhighlight %}

O passageiro está veiculando seu aplicativo em http://0.0.0.0:3000/.
Experimente e use um pouco seu aplicativo e execute "bundle exec passage-status" para verificar sua atividade.

Existem duas maneiras de parar o servidor. O primeiro é pressionando Ctrl-C no terminal. A segunda maneira é executar `passenger stop` em uma nova janela de terminal:

{% highlight sh %}
cd /path-to-your-app
bundle exec passenger stop
{% endhighlight %}

Quando você voltar para o primeiro terminal, você verá que o passageiro realmente parou.

O passageiro reinicia processos que causam falhas, carregam o tráfego de balanceamento entre processos e dimensiona os processos para cima e para baixo, a fim de lidar com mais tráfego ou conservar recursos. Tudo isso é tratado automaticamente, sem que você precise especificar nada no seu código! Pode não fazer muito sentido agora, mas seu futuro desenvolvedor nos agradecerá.

Para referência futura, você pode usar o comando `passenger-config restart-app` para reiniciar seu aplicativo. Isso é mais conveniente do que parar e iniciar o Passenger, que requer dois comandos.

#### tmp/always_restart.txt

O Passenger também suporta o arquivo mágico `tmp/always_restart.txt`. Com este arquivo, o Passenger irá reiniciar seu aplicativo após cada solicitação. Dessa forma, você não precisa invocar o comando de reinicialização com freqüência.

Ative este mecanismo criado o arquivo:

{% highlight sh %}
mkdir -p tmp
touch tmp/always_restart.txt
{% endhighlight %}

Desative o mecanismo removendo o arquivo:

{% highlight sh %}
rm tmp/always_restart.txt
{% endhighlight %}

**INSTRUTOR(A)**: Ás vezes a gem carrierwave gem causa problemas. Adicionando `require 'carrierwave/orm/activerecord'` ao arquivo `environment.rb` muitas vezes será suficiente.

### Implantando seu app

#### Hospedando seu app

Antes de selecionar seu host (infraestrutura) e [seguir o guia para colocar seu aplicativo on-line][passenger-guide], vamos confirmar as alterações que fizemos:

{% highlight sh %}
git add .
git commit -m "add passenger"
git push
{% endhighlight %}

Você também pode optar por seguir o [Heroku][heroku-guide] a parti daqui

[passenger-guide]: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/
[heroku-guide]: http://guides.railsgirls.com/heroku

#### Solução de problemas

Use o comando `passenger --help` em seu terminal para procurar todos os comandos disponíveis e sua funcionalidade.A maioria dos comandos (como `passenger start`) tem muitos 'sub-comandos'. Por exemple: execute `passenger start --help` para ver todos os complementos para o comando 'start'.

Perdido? Phusion Passenger possui extensa documentação, incluindo guias para iniciantes: [Guia Passenger][passenger-documentation]

No joelho? Rastejar através [Guia de solução de problemas do Passenger][troubleshooting-guide] com seu treinador.

[passenger-documentation]: https://www.phusionpassenger.com/library/
[troubleshooting-guide]: https://www.phusionpassenger.com/library/admin/nginx/troubleshooting/ruby/
