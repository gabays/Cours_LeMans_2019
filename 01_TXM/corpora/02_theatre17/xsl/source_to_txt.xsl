<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns=""
    xpath-default-namespace=""
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" indent="no"/>
    
    <xsl:param name="sourceFolder">
        <xsl:value-of select="tokenize(base-uri(), '/')[position() &lt; last()]" separator="/"/>
    </xsl:param>
    
    <xsl:variable name="myCollection" select="collection($sourceFolder)"/>
    
    <xsl:template match="/">
        
        <!-- Sorties txt -->
        <xsl:for-each select="$myCollection/*">
            <xsl:variable name="nomfichier" select="concat(substring-before(tokenize(document-uri(/), '/')[last()], '.xml'), '_', /TEI/text[1]/descendant::docDate[1]/@value)"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:result-document href="../txt/{$nomfichier}.txt">
                <xsl:apply-templates select="/TEI/text"/>
            </xsl:result-document>
        </xsl:for-each>
        
        <!-- Métadonnées -->
        <xsl:result-document href="../metadata.csv">
            <xsl:text>id,auteur,titre,date,genre,inspiration,structure,type,periode,taille,permalien</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:for-each select="$myCollection">
                <xsl:text></xsl:text>
                <xsl:value-of select="concat(substring-before(tokenize(document-uri(/), '/')[last()], '.xml'), '_', /TEI/text[1]/descendant::docDate[1]/@value)"/>
                <xsl:text>,"</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
                <xsl:text>",</xsl:text>
                <xsl:value-of select="/TEI/text[1]/descendant::docDate[1]/@value"/>
                <xsl:text>,"</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/genre"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/inspiration"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/structure"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/type"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/periode"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/taille"/>
                <xsl:text>","</xsl:text>
                <xsl:value-of select="/TEI/teiHeader/fileDesc/SourceDesc/permalien"/>
                <xsl:text>"&#xA;</xsl:text>
            </xsl:for-each>
            
        </xsl:result-document>
        
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
