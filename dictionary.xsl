<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <title>Kunwok Dictionary</title>
      <link rel="stylesheet" href="./dictionary.css"  type="text/css"/>
    </head>
  <body>
    <h2>Kunwok Dictionary</h2>
    <dl>
      <xsl:for-each select="toolbox_data/record">
        <p>
          <dt><b><xsl:value-of select="lx"/></b></dt>
          <dd>
            <xsl:apply-templates select="*[not(self::lx)]"/>
          </dd>
        </p>
      </xsl:for-each>
    </dl>
    </body>
  </html>
</xsl:template>

<xsl:template match="senses">
  <p class="senses"><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="sense">
  <br/>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="examples">
  <table border="1">
    <xsl:apply-templates/>
  </table>
</xsl:template>

<xsl:template match="example">
  <tr><td border="0">
    <xsl:apply-templates/>
  </td></tr>
</xsl:template>

<xsl:template match="lx">
  <dt><xsl:value-of select="text()"/></dt>
</xsl:template>

<xsl:template match="xv">
  <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="xe">
  (<xsl:value-of select="text()"/>)
</xsl:template>

<xsl:template match="sn">
  <b><xsl:value-of select="text()"/></b>
</xsl:template>

<xsl:template match="ps">
  <div class="ps"><xsl:value-of select="text()"/></div>
</xsl:template>

<xsl:template match="ge">
  <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="re">
  <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="de">
  <br/>
  <i><xsl:value-of select="text()"/></i>
</xsl:template>

<xsl:template match="dt">
  <div class="dt"><xsl:value-of select="text()"/></div>
</xsl:template>

</xsl:stylesheet>
