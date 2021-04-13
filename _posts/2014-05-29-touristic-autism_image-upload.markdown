---
layout: default
title: Touristic Autism-friendly Spots App 
permalink: touristic-autism_image-upload
---

# Upload de imagens e miniaturas

*Criado por Myriam Leggieri, [@iammyr](https://twitter.com/iammyr)* *para [Rails Girls Galway](https://github.com/RailsGirlsGalway)*

*Traduzido por Rafael Vianna, [@RFerreiraVianna](https://twitter.com/rferreiravianna)

Os guias básicos que foram mesclados e adaptados são os  [Ruby on Rails Tutorial](http://www.railstutorial.org/book), o [basic RailsGirls app](http://guides.railsgirls.com/app/) e os tutoriais são: [creating thumbnails](http://guides.railsgirls.com/thumbnails), [authenticating users](http://guides.railsgirls.com/devise/), [adding design](http://guides.railsgirls.com/design), [deploying to OpenShift](http://guides.railsgirls.com/openshift/) e [adding comments](http://guides.railsgirls.com/commenting).

Nós precisamos instalar uma nova Gem que nos permita fazer upload de arquivos no Rails.

Abra `Gemfile` na sua pasta do projeto usando seu editor de texto e adicione:

{% highlight ruby %}
gem 'carrierwave'
{% endhighlight %}

No terminal execute:

{% highlight sh %}
bundle
{% endhighlight %}

Agora podemos gerar o código para a execução do upload. No terminal, execute:

{% highlight sh %}
rails generate uploader Picture
{% endhighlight %}

Nesse momento você irá **precisar reiniciar o servidor do Rails** no terminal.

Precione <kbd>Ctrl</kbd>+<kbd>C</kbd> no terminal para parar o servidor. Uma vez parado, você pode apertar a seta pra cima no seu teclado para encontrar o último comando executado, então pressione o enter para iniciar o servidor novamente.

Isso é necessário para que o app carregue a biblioteca adicionada.

Abra `app/models/place.rb` e adicione:

{% highlight erb %}
mount_uploader :picture, PictureUploader
{% endhighlight %}

Abra `app/views/places/_form.html.erb` e mude:

{% highlight erb %}
<%= f.text_field :picture %>
{% endhighlight %}

para:

{% highlight erb %}
<%= f.file_field :picture %>
{% endhighlight %}


Algumas vezes você pode obter um *TypeError: can't cast ActionDispatch::Http::UploadedFile to string*.

Se isso acontecer, no arquivo `app/views/places/_form.html.erb` mude a linha:

{% highlight erb %}
<%= form_for(@place) do |f| %>
{% endhighlight %}

para:

{% highlight erb %}
<%= form_for @place, :html => {:multipart => true} do |f| %>
{% endhighlight %}

Agora, se você executar o seu servidor e tentar adicionar um novo local com uma imagem, você notará que a imagem não parece bonita porque mostra apenas um caminho para o arquivo. Vamos consertar isso.

Abra `app/views/places/show.html.erb` e mude:

{% highlight erb %}
<%= @place.picture %>
{% endhighlight %}

para:

{% highlight erb %}
<%= image_tag(@place.picture_url, :width => 600) if @place.picture.present? %>
{% endhighlight %}

Agora recarregue seu navegador para ver a mudança.

**Instrutor(a):** Fale um pouco sobre HTML.

__Instrutor(a)__: Explique o que especifica a largura da imagem em HTML no final da etapa
4 e como ele difere do redimensionamento de imagens no servidor.

## Instalando ImageMagick

* macOS: Execute `brew install imagemagick`. Se você não tiver o comando brew, você pode [instalar aqui][in-homebrew].
* Windows: Baixe e execute [ImageMagick installer][im-win] (use o primeiro
  *download* link de download). Depois reabra o Shell de comando do Rails.
* Linux: No Ubuntu e Debian, execute `sudo apt-get install imagemagick`. Use o gerenciador de pacote apropriado ao invés de usar `apt-get` para outras distribuições.

  [im-win]: http://www.imagemagick.org/script/binary-releases.php?ImageMagick=vkv0r0at8sjl5qo91788rtuvs3#windows
  [in-homebrew]: http://mxcl.github.io/homebrew/

__Instrutor(a)__: O que é ImageMagick e o que difere das bibliotecas usadas anteriormente?

Abra `Gemfile` no projeto e adicione:

{% highlight ruby %}
gem 'mini_magick', '3.5.0'
{% endhighlight %}

No terminal execute:

{% highlight sh %}
bundle
{% endhighlight %}

## Fazendo nosso app criar miniaturas quando uma imagem é adicionada

Abra `app/uploaders/picture_uploader.rb` e ache a seguinte linha:

{% highlight ruby %}
# include CarrierWave::MiniMagick
{% endhighlight %}

Remova o `#`.

__Instrutor(a)__: Explique o conceito de comentários no código..

Abaixo da linha que você acabou de alterar, adicione:

{% highlight ruby %}
version :thumb do
  process :resize_to_fill => [50, 50]
end
{% endhighlight %}

As imagens carregadas a partir de agora serão redimencionadas, mas as imagens que já foram feitas não serão afetadas.
Então, edite um dos lugares existentes e volte a adicionar uma imagem.

## Mostrando as thumbnails

Para ver se a imagem carregada foi redimencionada abra,
`app/views/places/index.html.erb`. Mude a linha:

{% highlight erb %}
<td><%= place.picture %></td>
{% endhighlight %}

para:

{% highlight erb %}
<td><%= image_tag place.picture_url(:thumb) if place.picture? %></td>
{% endhighlight %}

Dê uma olhada no seu navegador para ver se a miniatura está lá.

{% include other-guides.md page="touristic-autism_image-upload" %}
