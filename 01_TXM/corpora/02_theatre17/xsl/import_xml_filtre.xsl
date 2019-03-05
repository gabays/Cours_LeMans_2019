<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns=""
    xpath-default-namespace=""
    exclude-result-prefixes="xs"
    version="2.0">
   
    <!-- Sortie xml -->
    <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
    
    <!-- Copie à l'identique par défaut -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <!-- Je supprime les informations suivantes -->
    <xsl:template match="teiHeader"/>
    <xsl:template match="castList"/>
    <xsl:template match="speaker"/>
    <!-- On retire toutes les mentions liminaires -->
    <xsl:template match="front"/>
    <!-- Et, au cas où -->
    <xsl:template match="docTitle|docDate|docAuthor|docImprint|printer|performance|div[@type='dedicace']"/>
    <xsl:template match="head"/>
    <xsl:template match="note"/>
    
    <!-- Passage en bas de casse -->
    <xsl:template match="text()">
        <xsl:value-of select="lower-case(.)"/>
    </xsl:template>
    
</xsl:stylesheet>
