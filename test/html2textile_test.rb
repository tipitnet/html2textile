require 'test/unit'
require_relative '../lib/html2textile'

class HTMLToTextileParserTest < Test::Unit::TestCase
  
	def to_textile(html)
		@parser = HTMLToTextileParser.new
		@parser.feed(html)
		@parser.to_textile
	end

  def test_should_parse_bold
    assert_equal ' *bold* ', to_textile('<b>bold</b>')
  end

  def test_should_parse_italic
    assert_equal ' _italic_ ', to_textile('<i>italic</i>')
  end

  def test_bold_with_spaces
    assert_equal ' *b o l d* ', to_textile('<b>   b  o  l   d    </b>')
  end

  def test_should_parse_bold_with_new_lines_inside
    assert_equal ' *b o l d* ', to_textile("<b> b  o\nl d\n</b>")
  end

  def test_should_parse_italic_with_spaces
    assert_equal ' _i t a l i c_ ', to_textile('<i>  i  t  a  l i c</i>')
  end

  def test_should_parse_headings
    assert_equal("h1. Heading 1\n\n", to_textile('<h1>Heading 1</h1>'))
    assert_equal("h2. Heading 2\n\n", to_textile('<h2>Heading 2</h2>'))
    assert_equal("h3. Heading 3\n\n", to_textile('<h3>Heading 3</h3>'))
  end

  def test_should_parse_heading_with_color
    assert_equal "h1. Hello world \n\n",
    							to_textile('<h1>Hello <span style="color: red">world</span></h1>')
  end

  def test_should_parse_heading_with_spaces_and_new_lines
    assert_equal "h1. Th is is a headi ng\n\n",
                   to_textile('<h1>  Th
     is is a headi  ng           </h1>')
  end

end