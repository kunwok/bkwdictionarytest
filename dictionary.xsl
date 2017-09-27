<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>Kunwok Dictionary</h2>
    <xsl:for-each select="toolbox_data/record">
      <xsl:value-of select="lx"/> [<xsl:value-of select="ps"/>]
    </xsl:for-each>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
