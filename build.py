from xml.etree.ElementTree import ElementTree

from nltk.toolbox import ToolboxData
from nltk.util import elementtree_indent

grammar = r"""
      sense:    {<sn><ps|ge|re|de>*<examples>?}
      senses:   {<sense>+}
      example:  {<xv><xe>}
      examples: {<example>+}
      record:   {<lx><pr>?<sense>+<dt>}
    """

lexicon = ToolboxData('bkwdictionarytest.txt').parse(grammar)
elementtree_indent(lexicon)
tree = ElementTree(lexicon)

decl = """<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="dictionary.xsl"?>
"""

f = open('dictionary.xml', 'w')
f.write(decl)
tree.write(f, encoding='unicode')
f.close()

