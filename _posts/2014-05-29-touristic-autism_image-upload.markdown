---
layout: default
title: App para turismo de autismo amigável 
permalink: touristic-autism_image-upload
---

# Envio de imagem e thumbnails

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)*
*para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*
Os tutoriais básicos que tem sido mesclados e adaptados são o [Tutorial Ruby on Rails](http://www.railstutorial.org/book), o [App RailsGirls](http://guides.railsgirls.com/app/) e os tutoriais para [criação de thumbnails](http://guides.railsgirls.com/thumbnails), [autenticação de usuários](http://guides.railsgirls.com/devise/), [adição de design](http://guides.railsgirls.com/design), [implementando com o OpenShift](http://guides.railsgirls.com/openshift/) and [adicionando comentários](http://guides.railsgirls.com/commenting).


Nós precisamos instalar um pouco de software para podermos enviar arquivos ao Rails.

Abra o `Gemfile` no diretório do projeto usando seu editor de texto e adicione

{% highlight ruby %}
gem 'carrierwave'
{% endhighlight %}


No terminal execute:

{% highlight sh %}
bundle
{% endhighlight %}

Agora nós podemos gerar o código para o gerenciamento dos uploads. No terminal execute: 

{% highlight sh %}
rails generate uploader Picture
{% endhighlight %}

Neste momento você precisa **reiniciar o processo do servidor Rails** no terminal.

Pressione <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal para sair do servidor. Uma vez que ele foi parado, você pode pressionar a seta para cima para obter o último comando inserido, em seguida pressione enter para iniciar o servidor novamente.

Isso é necessario para que o app carregue aa biblioteca adicionada.

Abra `app/models/place.rb` e adicione

{% highlight ruby %}
mount_uploader :picture, PictureUploader
{% endhighlight %}

Abra `app/views/places/_form.html.erb` e modifique

{% highlight erb %}
<%= f.text_field :picture %>
{% endhighlight %}

por

{% highlight erb %}
<%= f.file_field :picture %>
{% endhighlight %}

Às vezes, você pode receber o seguinte *TypeError: can't cast ActionDispatch::Http::UploadedFile to string*.

Se isto acontecer, no arquivo `app/views/places/_form.html.erb` modifique a linha

{% highlight erb %}
<%= form_for(@place) do |f| %>
{% endhighlight %}

por

{% highlight erb %}
<%= form_for @place, :html => {:multipart => true} do |f| %>
{% endhighlight %}

Agora se você executar seu servidor, e tentar adicionar um novo lugar com uma imagem, você notará que a imagem não parece bonita porque apenas mostra um caminho para o arquivo. Vamos corrigir isto.

Abra `app/views/places/show.html.erb` e modifique

{% highlight erb %}
<%= @place.picture %>
{% endhighlight %}

para

{% highlight erb %}
<%= image_tag(@place.picture_url, :width => 600) if @place.picture.present? %>
{% endhighlight %}

Agora atualize seu navegador para ver o que mudou.

**Coach:** Converse um pouco sobre HTML.

__Coach__: Explique o que a largura da imagem especifica no HTML no final da etapa 4 e como se difere do redimensionamento de imagens no servidor.

## Instalando ImageMagick

* OS X: execute `brew install imagemagick`. se você não tiver o comando brew, você pode [instalar o Homebrew aqui][in-homebrew].
* Windows: Baixe e execute o [ImageMagick installer][im-win] (use o primeiro link
  de *download*). Reabra seu Shell Command do Rails depois.
* Linux: Para Ubuntu e Debian, execute `sudo apt-get install imagemagick`. Use o gerenciador
  de pacote apropriado ao invés do `apt-get` para outras distribuições.

  [im-win]: http://www.imagemagick.org/script/binary-releases.php?ImageMagick=vkv0r0at8sjl5qo91788rtuvs3#windows
  [in-homebrew]: http://mxcl.github.io/homebrew/

__Coach__: O que é ImageMagick e como é diferente das libraries/gems que
usamos anteriormente?

Abra `Gemfile` no projeto e adicione

{% highlight ruby %}
gem 'mini_magick', '3.5.0'
{% endhighlight %}

No terminal execute:

{% highlight sh %}
bundle
{% endhighlight %}

## Informando ao nosso app para criar thumbnails quando uma imagem é carregada

Abra `app/uploaders/picture_uploader.rb` e procure a linha que se parece com esta:

{% highlight ruby %}
  `# include CarrierWave::MiniMagick`
{% endhighlight %}

Remova a `#`.

__Coach__: Explique o conceitto de commentários no código.

Abaixo da linha que você modificou, adicione:

{% highlight ruby %}
version :thumb do
  process :resize_to_fill => [50, 50]
end
{% endhighlight %}

As imagens carregadas a partir de agora devem ser redimensionadas, mas as que já fazemos
não foram afetados. Então edite um dos lugares existentes e volte a adicionar uma imagem.

## Exibindo as thumbnails

Para ver se a imagem carregada foi redimensionada abra
`app/views/places/index.html.erb`. Modifique a linha

{% highlight erb %}
<td><%= place.picture %></td>
{% endhighlight %}

para

{% highlight erb %}
<td><%= image_tag place.picture_url(:thumb) if place.picture? %></td>
{% endhighlight %}

Dê uma olhada na lista de ideias no navegador para ver se a miniatura está lá.

