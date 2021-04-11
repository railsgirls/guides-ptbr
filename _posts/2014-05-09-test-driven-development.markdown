---
layout: default
title: Test Driven Development
permalink: test-driven-development
---

# Test Driven Development

*Criado por Gregory McIntyre, [@gregmcintyre](https://twitter.com/gregmcintyre)*.
*Traduzido por Marina Limeira, [@marinalimeira_](https://twitter.com/marinalimeira_)*.

Este exercício objetiva em te ensinar sobre o que nós estamos falando quando dizemos
*Test Driven Development* (TDD).

## Background information

**Numerais Romanos**

Se você não está familiar com números Romanos, por favor leia
[como números romanos funcionam][Roman numerals] antes de continuar.

Em resumo, aqui estão alguns exemplos de como romanos escrevem números:

<style>
.roman-table th,
.roman-table td { padding: 0 1rem; }
.roman-table thead tr { border-bottom: 1px solid black; }
.roman-table tr:nth-child(even) td { background-color: #eee; }
</style>

<table class="roman-table">
  <thead>
    <tr>
      <th>Hindu-Arábico</th>
      <th>Romano</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td><tt>I</tt></td>
    </tr>
    <tr>
      <td>4</td>
      <td><tt>IIII</tt> (or <tt>IV</tt>)</td>
    </tr>
    <tr>
      <td>5</td>
      <td><tt>V</tt></td>
    </tr>
    <tr>
      <td>6</td>
      <td><tt>VI</tt></td>
    </tr>
    <tr>
      <td>7</td>
      <td><tt>VII</tt></td>
    </tr>
    <tr>
      <td>9</td>
      <td><tt>VIIII</tt> (or <tt>IX</tt>)</td>
    </tr>
    <tr>
      <td>10</td>
      <td><tt>X</tt></td>
    </tr>
    <tr>
      <td>50</td>
      <td><tt>L</tt></td>
    </tr>
    <tr>
      <td>100</td>
      <td><tt>C</tt></td>
    </tr>
    <tr>
      <td>500</td>
      <td><tt>D</tt></td>
    </tr>
    <tr>
      <td>1000</td>
      <td><tt>M</tt></td>
    </tr>
  </tbody>
</table>

Nós iremos escrever um programa que recebe um valor inteiro na coluna esquerda
e calcula o valor na string equivalente na coluna direita. Se nós finalizarmos
isto, iremos então fazer a *subtração de dígitos* como em *IV*.

**Guia para trabalhar em grupo**

Nós encorajamos fazer este exercícios em um grupo de 2-4 pessoas. As regras que
governam como isto funcionam são muito similares a como programadores fazem *programação
em par* e este exercício tem a intenção de te dar alguma exposição a esta prática.

- Cada grupo possui uma **pessoa no comando** com laptop e *Sublime Text* prontos.
- Todos os outros devem **fechar seus laptops** e sentar ao redor de quem está no comando.
- Vocês todos irão regurlarmente levantar-se e **rodar as cadeiras** para que a próxima
pessoa esteja no comando. Os passos abaixo explicam quando fazer isso.
- Escolha alguém para começar no comando. Aquela pessoa deverá seguir todas os passos
até que a troca de assentos seja mencionada.

**Instrutor(a):** Explique como programação em par pode ser útil.

## *1.* Código inicial

Copie este código em um arquivo chamado `roman.rb`:

{% highlight ruby %}
def roman(n)
  return "?"
end

require "minitest/spec"
require "minitest/autorun"

describe "roman" do
  it "converte o número 1 na string I" do
    roman(1).must_equal "I"
  end
end
{% endhighlight %}

**Rode seus testes**

Se você utiliza *Sublime Text* no Linux, OSX Mavericks (ou superior) ou Windows, você
pode rodar os testes pressionando <kbd>Ctrl</kbd>+<kbd>B</kbd>. Caso contrário, você pode digitar
o seguinte no seu terminal:

{% highlight sh %}
ruby roman.rb
{% endhighlight %}

**Saída**

Você deverá ver a seguinte saída dos testes:

{% highlight sh %}
roman#test_0001_converte o número 1 na string I [tdd1.rb:11]:
Expected: "I"
  Actual: "?"

1 tests, 1 assertions, 1 failures, 0 errors, 0 skips
{% endhighlight %}

Reserve um momento para ler esta saída com cuidado. Há bastante informação.

Seus teste agora estão **vermelhos**, ou seja, um ou mais testes estão falhando. Você pode
perceber que você possui um teste falhando checando o resumo no final: `1 tests, 1
assertions, 1 failures, 0 errors, 0 skips`.

**Levante-se** e de o comando a próxima pessoa.

**Instrutor(a):** Explique como TDD pode ser útil

## *2.* Faça o teste passar

Agora é hora de fazer o teste passar. Faça como você achar melhor. Está bem se a
mudança é apenas uma condição extra `if` ou um caractere. De fato, isso é encorajado:
você geralmente não deveria escrever código desnecessário. Se você está preso,
você pode pedir a opinião de pessoas próximas.

Here is a way that you could make the first test pass, just to get you into the
swing of things:

{% highlight ruby %}
def roman(n)
  return "I"
end
{% endhighlight %}

If this seems facetious, you're right but it is a valid solution because it
makes all the tests pass. When your tests all pass, we call them **green**.

## *3.* Refatore seu código

Look over the code and decide if it's a good idea to **refactor** it (clean up
the code and make it easier to read). If you decide to not to refactor, skip
this step.

**Dica**: É uma boa hora para refatorar quando você notar *repetição*. Se você preferir,
pode também refatorar os testes.

Rode seus testes após refatorar. Se eles falharem, você acidentalmente quebrou alguma coisa.


**Instrutor(a):** Explique como focar em algo pequeno o suficiente para testar pode ser útil.

## *4.* Escreva um novo teste que falha

If you all agree that the code should work in general, and you can't think of
any more cases to test and everything passes, you can stop here. You win!

Otherwise, your last job in the hot seat is to write a new test. We currently have
a test that checks that the number one is turned into an `"I"`, but we need more tests
to verify that all other numbers convert as expected. When you add a new test for another
number, be sure to run the tests to find your test fail. If you're stuck, there are
somesuggestions at the bottom of this page.

Você pode copiar e colar o teste anterior e alterá-lo. Você pode altera-lo para
ser o que você quiser. Seus testes deverão p


You can copy and paste the previous test and alter it. You can change it to be
anything you like. Your tests should probably test the next trickiest
situation, but if you feel like going back and adding a simpler case, that's
fine too as long as it fails.

The other members of the group can chime in and ask questions or spot problems
for you.

Aqui está um exemplo de como expandir seus casos de teste:

{% highlight ruby %}
describe "roman" do
  it "converte o número 1 na string I" do
    roman(1).must_equal "I"
  end

  it "converte o número 2 na string II" do
    roman(2).must_equal "II"
  end
end
{% endhighlight %}

Seus testes agora estão **vermelhos** de novo; ao menos um está falhando.

**Stand up** and offer the hot seat to the next person in your group.

## Repita!

Keep repeating steps 2 through 4, making sure to continue switching at the end
of step 4. You are done when your team feels like they are done.

Don't worry about finishing all cases. The goal is to practice the steps and
learn to work together in this way. Get used to writing tests as well as
getting them to pass. Practice. Good luck!

## Dicas

Se você está sem ideias, aqui está uma lista de numerais romanos para escrever casos
de teste, nesta ordem. Note a maneira que a complexidade aumenta.

:--------- | :-----------
Entrada    | Saída
:--------- | :-----------
 `1`       | `"I"`
 `5`       | `"V"`
 `4`       | `"IIII"`
 `6`       | `"VI"`
 `7`       | `"VII"`
 `10`      | `"X"`

If you get this far, you earn partial credit. Romans used to use `IIII` for 4.
That's why 4 on an analog watch is written as `IIII`. Later on, they added
*subtractive* digits. These are harder to program. Once you feel confident that
your program works with all the numbers above, try dealing with subtractive
digits.

:--------- | :-----------
Entrada    | Saída
:--------- | :-----------
`4`        | `"IV"`
`14`       | `"XIV"`
`2896`     | `"MMDCCCXCVI"`

[Roman numerals]: http://www.onlineconversion.com/roman_numerals_advanced.htm

{% include other-guides.md page="test-driven-development" %}
