#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require 'pry'

require_relative "../../lib/concept/table"

class TableTest < Minitest::Test
  def setup
    string_datas = get_xml_data
    @tables=[]
    root_xml_data=REXML::Document.new(string_datas)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="table" then
        @tables << Table.new(nil, xml_data)
      end
    end
  end

  def test_table_0
    name = "$attribute$value"

    assert_equal name,  @tables[0].name
    assert_equal nil,   @tables[0].title
    assert_equal false, @tables[0].sequence?
    assert_equal 0,     @tables[0].sequence.size
    assert_equal [],    @tables[0].sequence
    assert_equal 2,     @tables[0].fields.size
    assert_equal ["attribute","value"], @tables[0].fields
  end

  def test_table_0_rows
    lRows=[ [ 'race', 'human' ],
             [ 'laser sabel color', 'green'],
             [ 'hair color', 'red' ]
            ]
    assert_equal lRows.size, @tables[0].rows.size
    for i in 0..2
      assert_equal lRows[i], @tables[0].rows[i]
    end
  end

  def get_xml_data
    string_datas=%q{
      <concept>
        <table fields='attribute, value'>
          <row>
            <col>race</col>
            <col>human</col>
          </row>
          <row>
            <col>laser sabel color</col>
            <col>green</col>
          </row>
          <row>
            <col>hair color</col>
            <col>red</col>
          </row>
        </table>

        <table fields='film name' sequence='Films ordered by episode number'>
          <row>The Phantom Menace</row>
          <row>Attack of the Clones</row>
          <row>Revenge of the Sith</row>
          <row>A New Hope</row>
          <row>The Empire Strikes Back</row>
          <row>Return of the Jedi</row>
          <row>The Force Awakens</row>
        </table>
      </concept>
    }

    return string_datas
  end
end