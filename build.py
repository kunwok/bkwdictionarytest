from xml.etree.ElementTree import ElementTree

from nltk.toolbox import ToolboxData
from nltk.util import elementtree_indent

lexicon = ToolboxData('bkwdictionarytest.txt').parse()
elementtree_indent(lexicon)
tree = ElementTree(lexicon)

decl = """
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="dictionary.xsl"?>
"""

f = open('dictionary.xml', 'w')
f.write(decl)
tree.write(f, encoding='unicode')
f.close()

