from xml.etree.ElementTree import ElementTree

from nltk.toolbox import ToolboxData
from nltk.util import elementtree_indent

lexicon = ToolboxData('bkwdictionarytest.txt').parse()
elementtree_indent(lexicon)
tree = ElementTree(lexicon)

f = open('dictionary.xml', 'w')
tree.write(f, encoding='unicode')
f.close()

