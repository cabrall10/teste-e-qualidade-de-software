require 'minitest/autorun'
require_relative 'moeda'

class MoedaTest < Minitest::Test
  include Moeda

  def test_formatacao_de_inteiro
    assert_equal numero_para_moeda(1001), 'R$1.001,00'
  end

  def test_formatacao_de_float
    assert_equal numero_para_moeda(100.23), 'R$100,23'
  end

  def test_formatacao_de_string
    assert_equal numero_para_moeda("1001"), 'R$1.001,00'
  end

  def test_uso_de_delimitadores_para_numeros_grandes
    assert_equal numero_para_moeda(1001000232), 'R$1.001.000.232,00'
  end

  def test_ausencia_de_delimitadores_em_numeros_pequenos
    assert_equal numero_para_moeda(10), 'R$10,00'
  end

  def test_mudanca_da_unidade
    assert_equal numero_para_moeda(1001, :unidade=>'$'), '$1.001,00'
  end

  def test_mudanca_da_precisao
    assert_equal numero_para_moeda(1001, :precisao=>3), 'R$1.001,000'
  end

  def test_ausencia_de_separador_quando_precisao_for_0
    assert_equal numero_para_moeda(1001, :separador=>''), 'R$1.00100'
  end

  def test_mudanca_do_delimitador
    assert_equal numero_para_moeda(1001, :delimitador=>'*'), 'R$1*001,00'
  end

  def test_mudanca_do_separador
    assert_equal numero_para_moeda(1001, :separador=>'/'), 'R$1.001/00'
  end

  def test_multiplas_opcoes_de_formatacao_simultaneamente
    assert_equal numero_para_moeda(1001, :separador=>'/', :delimitador=>'*', :precisao=>3, :unidade=>'$' ), '$1*001/000'
  end
end
