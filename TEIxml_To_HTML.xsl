<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>
    <!--RP:2017-11-21: Note: Because this is just an example for the purposes of this proposal not every aspect of the output HTML reading view is currently being pulled from the input XML; therefore, running this stylesheet will only produce the transcription panel of the HTML Reading View. I suspect there will need to be a pipeline of XSLT transformations run that first pull all of the XML files into a single file and then pull the map note/geo coordinates into a separate KML file. Then this transformation stylesheet will need adjusted to combine the KML file and the single XML file (containing all of the indiv. XML files). This file will also need template matches to create the map, commentary, and manuscript panels with identifiers that link each panel to the others for each manuscript page. The sample HTML file's structure will be of great use when needing to make the edits to this stylesheet to account for all of the currently missing template matches.Since this transformation is only taking into account one page the structure of the transformation will need changed to incorporate a loop that runs through each of the pages coming in from the XML. I suggest for-each or for-each-group for this. The encoder will need to adjust the upconversion regular expressions to better nest the transcription in order to get the label/date and the rest of the diary entry text into two distinct columns when transferred to HTML.-->
    <xsl:template match="/">
        <div>
        <h1 class="display-6 padding"><xsl:apply-templates select="descendant::head[@type='main']"/></h1>
        <xsl:comment><xsl:apply-templates select="descendant::head[@type='main']"/> was transcribed by <xsl:apply-templates select="descendant::note[@type='transcriber']"/> (referenced in comments as <xsl:apply-templates select="descendant::note[@type='transcriber']/@resp"/></xsl:comment>
        <div class="col">
            <h2><xsl:apply-templates select="descendant::p[@rend='topMargin']/normalize-space()"/></h2>
            <div class="entries">
                <xsl:apply-templates select="descendant::p[@rend='entry']"/>
            </div>
        </div></div>
    </xsl:template>
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    <xsl:template match="del[@rend='overstrike']">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="hi[@rend='centered']">
        <span class="text-center"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="hi[@rend='underline']">
        <u><xsl:apply-templates/></u>
    </xsl:template>
    <xsl:template match="hi[@rend='indent']">
        <span class="indent"><pre><xsl:text>&#9;</xsl:text></pre></span>
    </xsl:template>
    <xsl:template match="p[@rend='entry']">
        <p class="entry"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="label">
        <span class="entryLabel"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="date">
        <span class="date" title="{@when}"><xsl:text>*</xsl:text></span>
    </xsl:template>
    <xsl:template match="unclear">
        <xsl:choose>
            <xsl:when test="child::supplied">
                <span class="suggest"
                    title="The text provided here was interpreted by a project transcriber.">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unclear"
                    title="The text is unclear and could not be transcribed.">
                    <xsl:text> [MISSING TEXT] </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>