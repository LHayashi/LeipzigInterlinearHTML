<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" version="4.0" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
	<xsl:template match="document">
		<!-- NOTE, this DOCTYPE causes issues for tests that use AssertThatXmlIn to catch an error and display the DOM -->
		<!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html[]&gt;</xsl:text> -->

		<html>
			<head>
				<!-- ======================== -->
				<title>Interlinear text: "<xsl:value-of
						select="interlinear-text/item[@type='title']"/>"</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<meta name="keywords" content="interlinear texts"/>
				<style>
					#control{
					    position:fixed;
					    left:0;
					    width:100%;
					    background-color:#E5E4E2;
					    border-bottom:gray dotted 1px;
					    margin-top:-1em;
					    padding:1em 0em 1em 1em;
					    z-index:2;
					}
					
					.controlWord{background-color:#eceff1;}
					.controlLex{background-color:#fbe9e7;}
					.controlNotes{background-color:#f9fbe7;}
					.controlInterface{background-color:#ffebee;}
					
					.info{
					position:relative;
					padding-top:10em;
					font-size:9pt;
					}
					
					#doc{
					    
					}
					
					
					.ctrl{
					    margin:0;
					    padding:2px 5px 3px 0px;
					    font:bold 0.8em sans-serif;
					}
					
					.ctrlfree{
					    display:inline;
					    margin-left:20px;
					    padding:5px;
					    background-color:none;
					}
					
					.horizontalLine{
					    width:100%;
					    height:5px;
					    border-top:0.5px solid lightgrey;
					    position:relative;
					}
					
					.labelColumn{
					    font:normal .7em serif;
					    text-align:right;
					    vertical-align:middle;
					}
					
					h1{
					    font:1.2em sans-serif, "Doulos SIL", "Charis SIL", "Times New Roman", Times, serif;
					    margin:0;
					    background-color:lightgray;
					}
					.description{
					    display:inline;
					    font:normal 1em serif;
					}
					
					td{
					    height:1em;
					    vertical-align:bottom;
					    white-space:nowrap;
					}
					span{
					    display:inline-block;
					    vertical-align:top;
					}
					
					
					.itx_Frame_Number{
					    font:normal 1em serif;
					    display:inline;
					}
					
					.lexMorphemeFrameNumber{
					    font:normal 1em serif;
					    display:inline;
					}
					
					.itxBaseline{
					    font-style:italic;
					}
					
					.lexMorpheme{
					    font-style:italic;
					}
					
					.lexMorph{
					font-style:italic;
					}
					
					.lexGloss{
					    font-size:.9em;
					    color:maroon;
					}
					
					.lexPOS{
					    font-size:.85em;
					    font-family:sans-serif;
					    color:navy;
					}
					
					.wordGloss{
					    font-size:.9em;
					    color:maroon;
					}
					
					.wordPOS{
					    font-size:.85em;
					    font-family:sans-serif;
					    color:navy;
					}
					
					.itxFreeTranslation{
					    font:normal
					}
					
					.lit{
					    display:inline;
					    margin-left:1.9em;
					    background-color:#CCFFBF;
					    font:normal 1em serif;
					}
					.itxNotes{
					    margin-left:1em;
					    color:mediumblue;
					    font:normal 1em serif;
					}
					
					.punct{
					    margin-top:.1em;
					    padding:.8em .5em 0em .3em;
					    background-color:#80C9FF;
					    height:1.4em;
					    font:bold 1em serif;
					}
					
					sub,
					sup{
					    display:none;
					}
					.hidden{
					    display:none;
					}
					.rowLabel{
					
					}
					.preApGloss{
					
					}
					
					/* Styles for print */
					@media print {
					div.no-print {
					display: none;
					}
				</style>

				<script type="text/javascript"><xsl:text disable-output-escaping="yes">
<![CDATA[
function hasClass(ele,cls){
	return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
}
function addClass(ele,cls){
	if (!hasClass(ele,cls)) ele.className += " "+cls;
}
function removeClass(ele,cls){
	if (hasClass(ele,cls)){
		var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');
		ele.className=ele.className.replace(reg," ");
	}
}
function toggleClass(el,clsName){
	var x = document.getElementsByTagName(el);
	for(var i=0; i<x.length; i++){
		if(element("hide"+clsName).checked==false && hasClass(x[i],clsName)){
			addClass(x[i],"hidden");
		}
		if(element("hide"+clsName).checked==true && hasClass(x[i],clsName)){
			removeClass(x[i],"hidden");
		}
	}
}

// Larry's experiment to turn off Row Labels when WordGloss or WordPOS is clicked.
function toggleWordLevel(){
	toggleClass('tr','wordGloss');
	var target = document.getElementById('hiderowLabel');
        target.focus();
        target.select();
	toggleClass('span','rowLabel');
}

// The function below is similar to above but is used to toggle the segment number span found on lexMorphemeFrameNumber
// in case the user hides the baseline. Note the toggle is reversed from above, and it is tied to the state of the hide baseline checkbox.
function toggleLexMorphemeFrameNumber(el,clsName){
	var x = document.getElementsByTagName(el);
	for(var i=0; i<x.length; i++){
		if(element("hideitxBaseline").checked==true && hasClass(x[i],clsName)){
			addClass(x[i],"hidden");
		}
		if(element("hideitxBaseline").checked==false && hasClass(x[i],clsName)){
			removeClass(x[i],"hidden");
		}
	}
}

function element(id){
	if(document.getElementById != null) {
		return document.getElementById(id);
	}
	if(document.all != null) {
		return document.all[id];
	}
	if(document.layers != null) {
		return document.layers[id];
	}
	return null;
}
// The function below is used by the Copy button for each segment to copy the interlinear table to the clipboard.
function selectElementContents(el) {
	var body = document.body, range, sel;
	if (document.createRange && window.getSelection) {
		range = document.createRange();
		sel = window.getSelection();
		sel.removeAllRanges();
		try {
			range.selectNodeContents(el);
			sel.addRange(range);
		} catch (e) {
			range.selectNode(el);
			sel.addRange(range);
		}
    document.execCommand("copy");
	} else if (body.createTextRange) {
		range = body.createTextRange();
		range.moveToElementText(el);
		range.select();
    range.execCommand("copy");
	}
}
]]></xsl:text>
					</script>

				<title> &#160; </title>
			</head>
			<body>
				<div id="control" class="no-print">
					<!--<button onclick="">Show/hide controls</button>-->
					<!--<br/>-->
					<span class="ctrl ctrlfree">Display:</span>
					<br/>
					<table class="controls" style="border: 1px solid black;">
						<tbody>
							<tr class="controlWord">
								<td>
									<!--Checkbox for hiding itxBaseline row. Starts as unchecked ... i.e. no checked="checked" in this element: <input checked="checked" ... -->
									<span class="ctrl ctrlfree">
										<input
											onclick="toggleClass('tr','itxBaseline'); toggleLexMorphemeFrameNumber('span','lexMorphemeFrameNumber');"
											id="hideitxBaseline" value="itxBaseline" type="checkbox"/>
										<label for="hideitxBaseline">Baseline</label>
									</span>
								</td>
								<!--<td>
									<span class="ctrl ctrlfree">
										<input onclick="toggleClass('tr','wordGloss');"
											id="hidewordGloss" value="wordGloss" type="checkbox"/>
										<label for="hidewordGloss">Word glosses</label>
									</span>
								</td>-->
								<td>
									<span class="ctrl ctrlfree">
										<input onclick="toggleWordLevel();"
											id="hidewordGloss" value="wordGloss" type="checkbox"/>
										<label for="hidewordGloss">Word Glosses</label>
									</span>
								</td>
								<td>
									<span class="ctrl ctrlfree">
										<input onclick="toggleClass('tr','wordPOS');"
											id="hidewordPOS" value="wordPOS" type="checkbox"/>
										<label for="hidewordPOS">Word Categories</label>
									</span>
								</td>
							</tr>
							<tr class="controlMorphs">
								<td>
									<!--Checkbox for hiding lexMorph row -->
									<span class="ctrl ctrlfree">
										<input checked="checked"
											onclick="toggleClass('tr','lexMorph');"
											id="hidelexMorph" value="lexMorph" type="checkbox"/>
										<label for="hidelexMorph">Morphemes</label>
									</span>
								</td>
								<td>
									<!--Checkbox for hiding Pre and Post glosses the gloss of variants -->
									<span class="ctrl ctrlfree">
										<input checked="checked" onclick="toggleClass('span','preApGloss');"
											id="hidepreApGloss" value="preApGloss" type="checkbox"/>
										<label for="hidepreApGloss">Pre and Post glosses on variants</label>
									</span>
								</td>
								<td>
									
								</td>
							</tr>
							<tr class="controlLex">
								<td>
									<!--Checkbox for hiding lexMorpheme row -->
									<span class="ctrl ctrlfree">
										<input checked="checked"
											onclick="toggleClass('tr','lexMorpheme');"
											id="hidelexMorpheme" value="lexMorpheme" type="checkbox"/>
										<label for="hidelexMorpheme">Lex Entries</label>
									</span>
								</td>
								<td>
									<!--Checkbox for hiding lexGloss row -->
									<span class="ctrl ctrlfree">
										<input checked="checked"
											onclick="toggleClass('tr','lexGloss');"
											id="hidelexGloss" value="lexGloss" type="checkbox"/>
										<label for="hidelexGloss">Lex Glosses</label>
									</span>
								</td>
								<td>
									<!--Checkbox for hiding lexPOS row -->
									<span class="ctrl ctrlfree">
										<input 
											onclick="toggleClass('tr','lexPOS');" id="hidelexPOS"
											value="lexPOS" type="checkbox"/>
										<label for="hidelexPOS">Lex Gram Info</label>
									</span>
								</td>
							</tr>
							<tr class="controlNotes">
								<td>
									<!--Checkbox for hiding free translation row-->
									<xsl:if test="//phrase/item[@type='gls']">
										<span class="ctrl ctrlfree">
											<input checked="checked"
												onclick="toggleClass('tr','itxFreeTranslation');"
												id="hideitxFreeTranslation"
												value="itxFreeTranslation" type="checkbox"/>
											<label for="hideitxFreeTranslation">Free
												translation</label>
										</span>
									</xsl:if>
								</td>
								<td>
									<!--Checkbox for hiding literal translation row-->
									<xsl:if test="//phrase/item[@type='lit']">
										<span class="ctrl ctrlfree">
											<input checked="checked"
												onclick="toggleClass('tr','itxLiteralTranslation');"
												id="hideitxLiteralTranslation"
												value="itxLiteralTranslation" type="checkbox"/>
											<label for="hideitxLiteralTranslation">Literal
												translation</label>
										</span>
									</xsl:if>
								</td>
								<td>
									<!--Checkbox for hiding notes row(s)-->
									<xsl:if test="//phrase/item[@type='note']">
										<span class="ctrl ctrlfree">
											<input checked="checked"
												onclick="toggleClass('p','itxNotes');"
												id="hideitxNotes" value="itxNotes" type="checkbox"/>
											<label for="hideitxNotes">Notes</label>
										</span>
									</xsl:if>
								</td>
							</tr>
							<tr class="controlInterface">
								<td>
									<!--Checkbox for hiding Copy button on each segment -->
									<span class="ctrl ctrlfree">
										<input checked="checked"
											onclick="toggleClass('div','copyButton');"
											id="hidecopyButton" value="copyButton" type="checkbox"/>
										<label for="hidecopyButton">Copy buttons</label>
									</span>
								</td>
								<td>
									<!--Checkbox for hiding Row Label on each line -->
									<span class="ctrl ctrlfree">
										<input onclick="toggleClass('span','rowLabel');"
											id="hiderowLabel" value="rowLabel" type="checkbox"/>
										<label for="hiderowLabel">Row labels</label>
									</span>
								</td>
								<td>
									<!--Checkbox for hiding horizontalLines on each segment -->
									<span class="ctrl ctrlfree">
										<input checked="checked"
											onclick="toggleClass('span','horizontalLine');"
											id="hidehorizontalLine" value="horizontalLine"
											type="checkbox"/>
										<label for="hidehorizontalLine">Horizontal Lines</label>
									</span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

					<div class="info no-print">
						<span><h1>Instructions</h1></span>
						<span id="version">Generated from FieldWorks Leipzig HTML Exporter (version
							1.1.4 November 26, 2023)</span>
						<br/>
						<span style="font-weight:bold">Instructions</span>
						<ul>
							<li>Turn off lines that you do not want to appear using the checkboxes above.</li>
							<li>Include the Morphemes line when you want to display allomorphs and/or inflected variant forms. It is recommended that you select either the Morphemes line OR the LexEntries line.</li>
							<li>By default, glosses of inflected variants include the condition Prepend or Post/Appended gloss. e.g. men = man.PL. You can optionally hide these. These glosses come from the Variant Types list for items under Irregular Inflected Variants.</li>
							<li>Copy a segment to the clipboard using the Copy button. It will a
								paste in MS-Word as a table. Use the CanIL LingWord stylesheet
								template to autonumber in the Word document.</li>
						</ul>
						<br/>
						<span style="font-weight:bold">Current Limitations in the HTML and copy to
							MS-Word</span>
						<ul title="Current Limitations in the generated HTML and copy to MS-Word">
							<li>Only works with shorter clauses that are not greater than the width
								of your page margins in Word.</li>
							<li>Requires that each word be interlinearized to LexEntry level.</li>
							<li>Does not handle more than one vernacular representation in the
								baseline.</li>
							<li>Does not handle more than one glossing language.</li>
							<li>Fonts are set and static in the embedded stylesheet of this HTML
								document. You can manually change the CSS in an editor.</li>
						</ul>
					</div>

				<hr/>
				<div id="doc">
					<xsl:apply-templates/>
				</div>
			</body>
		</html>
	</xsl:template>

	<!-- INTERLINEAR-TEXT LEVEL -->

	<xsl:template match="interlinear-text">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="interlinear-text/item[@type='title']">
		<h1>
			<xsl:attribute name="lang"> Title: <xsl:value-of select="@lang"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h1>
	</xsl:template>
	<xsl:template match="interlinear-text/item[@type='title-abbreviation']"/>
	<xsl:template match="interlinear-text/item[@type='source']">
		<p>Source:<xsl:apply-templates/></p>
	</xsl:template>
	<xsl:template match="interlinear-text/item[@type='description']">
		<h2>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>

	<!-- PARAGRAPH LEVEL -->

	<xsl:template match="paragraphs">
		<hr/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="paragraph">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- PHRASE LEVEL -->

	<xsl:template match="phrases">

		<xsl:apply-templates/>
	</xsl:template>
	<!--A flextext phrase is a FLEx segment-->
	<xsl:template match="phrase">
		<!--The segment number is stored in a variable. The variable is placed in the first column of the baseline and also in a hidden span of the morpheme line
			in case the baseline is hidden by the user-->
		<xsl:variable name="vSegmentNumber" select="item[@type='segnum']"/>
		<!-- This variable stores a unique TableNumID for each table generated. A sequence  number of the phrase element in the whole document-->
		<xsl:variable name="vTableID">
			<xsl:text>TableNum</xsl:text>
			<xsl:number level="any" count="phrase"/>
		</xsl:variable>
		<div class="copyButton">
			<input type="button" value="Copy">
				<xsl:attribute name="onclick">
					<xsl:text>selectElementContents(document.getElementById('</xsl:text>
					<xsl:value-of select="$vTableID"/>
					<xsl:text>'));</xsl:text>
				</xsl:attribute>
			</input>
		</div>
		<table class="itx_Words">
			<xsl:attribute name="id">
				<xsl:value-of select="$vTableID"/>
			</xsl:attribute>
			<tbody>
				<!--Segment number and baseline words - Starts as hidden. -->
				<tr class="itxBaseline hidden">
					<!--Segment number-->
					<td>

						<span class="itx_Frame_Number"> (<xsl:value-of select="$vSegmentNumber"
							/>)&#160; </span>
					</td>
					<!-- Count the number of words in the segment -->
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word/item[@type='txt' or @type='punct'] ">
						<!-- Only works with XSLT 2.0 <xsl:variable name="vLongestAnnotation">
							<xsl:value-of select="../morphemes/morph/item[not(string-length() &lt; current()/../morphemes/morph/item/string-length())][1]"/>
						</xsl:variable>-->
						<td class="itxBaseline">
							<xsl:value-of select="text()"/>
						</td>
					</xsl:for-each>
				</tr>

				<!-- Row with Word glosses. Note that it starts as hidden. -->
				<tr class="wordGlossAbove hidden">
					<!--Segment number-->
					<td class="labelColumn">
						<span class="rowLabel">&#160; WdGloss:</span>
					</td>
					<!-- Count the number of words in the segment -->
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word/item[@type='gls'] ">
						<!-- Only works with XSLT 2.0 <xsl:variable name="vLongestAnnotation">
							<xsl:value-of select="../morphemes/morph/item[not(string-length() &lt; current()/../morphemes/morph/item/string-length())][1]"/>
						</xsl:variable>-->
						<td class="wordGloss">
							<xsl:value-of select="text()"/>
						</td>
					</xsl:for-each>
				</tr>

				<!-- Row with Word parts-of-speech. Starts as hidden.-->
				<tr class="wordPOSAbove hidden">
					<!--Segment number-->
					<td class="labelColumn">
						<span class="rowLabel">&#160; WdPOS:</span>
					</td>
					<!-- Count the number of words in the segment -->
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word/item[@type='pos'] ">
						<!-- Only works with XSLT 2.0 <xsl:variable name="vLongestAnnotation">
							<xsl:value-of select="../morphemes/morph/item[not(string-length() &lt; current()/../morphemes/morph/item/string-length())][1]"/>
						</xsl:variable>-->
						<td class="wordGloss">
							<xsl:value-of select="text()"/>
						</td>
					</xsl:for-each>
				</tr>


				<!-- Lexemes row-->
				<!-- Note that the affix dashes are included in the morph, whereas in the gloss and the POS they are not-->
				<tr class="lexMorph">
					<!--Space in cell in column where the example number is housed-->
					<td class="labelColumn">
						<span class="lexMorphemeFrameNumber"> (<xsl:value-of
							select="$vSegmentNumber"/>) &#160; </span>
						<span class="rowLabel hidden">Morphm:</span>
					</td>
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word">
						<!--Want to include punctuation in the morpheme line in case the user decides to hide the baseline, which is standard Leipzig practice-->
						<td>
							
							<xsl:for-each select="morphemes/morph">
								<xsl:variable name="vMorph">
									<xsl:value-of select="item[@type='txt']/text()"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$vMorph=''">&#160;</xsl:when>
									<xsl:otherwise>
										<!-- If the morpheme count is greater than 1 AND the morpheme type is root or stem AND the preceding morpheme was a root or a stem, then put an underscore before the morpheme
										In other words, if a word is made up of mutilple roots or stems, we need a way to separate these other than the hyphen.-->
										<xsl:if
											test="position()>1 and (@type='root' or @type='stem') and (preceding-sibling::node()/@type='root' or preceding-sibling::node()/@type='stem' or preceding-sibling::node()/@type='circumfix') "
											>·</xsl:if>
										<!--<xsl:value-of select="item[@type='cf']/text()"/>-->
										<!--<xsl:variable name="vMorpheme"><xsl:value-of select="item[@type='cf']/text()"/></xsl:variable>-->
										<xsl:value-of select="$vMorph"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</xsl:for-each>
				</tr>
				<tr class="lexMorpheme">
					<!--Space in cell in column where the example number is housed-->
					<td class="labelColumn">
						<span class="lexMorphemeFrameNumber"> (<xsl:value-of
								select="$vSegmentNumber"/>) &#160; </span>
						<span class="rowLabel hidden">LexEntry:</span>
					</td>
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word">
						<!--Want to include punctuation in the morpheme line in case the user decides to hide the baseline, which is standard Leipzig practice-->
						<td>

							<xsl:for-each select="morphemes/morph">
								<xsl:variable name="vMorpheme">
									<xsl:value-of select="item[@type='cf']/text()"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$vMorpheme=''">&#160;</xsl:when>
									<xsl:otherwise>
										<!-- If the morpheme count is greater than 1 AND the morpheme type is root or stem AND the preceding morpheme was a root or a stem, then put an underscore before the morpheme
										In other words, if a word is made up of mutilple roots or stems, we need a way to separate these other than the hyphen.-->
										<xsl:if
											test="position()>1 and (@type='root' or @type='stem') and (preceding-sibling::node()/@type='root' or preceding-sibling::node()/@type='stem' or preceding-sibling::node()/@type='circumfix') "
											>·</xsl:if>
										<!--<xsl:value-of select="item[@type='cf']/text()"/>-->
										<!--<xsl:variable name="vMorpheme"><xsl:value-of select="item[@type='cf']/text()"/></xsl:variable>-->
										<xsl:value-of select="$vMorpheme"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</xsl:for-each>
				</tr>
				<!-- LexGloss row-->
				<tr class="lexGloss">
					<!--Space in cell in column where the example number is housed-->
					<td class="labelColumn">&#160;<span class="rowLabel hidden">LexGls:</span></td>
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word">
						<td>
							<xsl:variable name="vGloss">
								<xsl:value-of select="item[@type='glsPrepend']/text()"/>
								<xsl:value-of select="item[@type='gls']/text()"/>
								<xsl:value-of select="item[@type='glsAppend']/text()"/>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="$vGloss=''">&#160;</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="morphemes/morph">
										<xsl:if
											test="@type='suffix' or @type='suffixing interfix' or @type='infix'">
											<xsl:text>-</xsl:text>
										</xsl:if>
										<xsl:if test="@type='enclitic'">
											<xsl:text>=</xsl:text>
										</xsl:if>
										<!-- If the morpheme count is greater than 1 AND the morpheme type is root or stem AND the preceding morpheme was a root or a stem, then put an underscore before the morpheme
										In other words, if a word is made up of mutilple roots or stems, we need a way to separate these other than the hyphen.-->
										<xsl:if
											test="position()>1 and (@type='root' or @type='stem') and (preceding-sibling::node()/@type='root' or preceding-sibling::node()/@type='stem' or preceding-sibling::node()/@type='circumfix') "
											>·</xsl:if>
										<!--Need to test for FUNCTOR GLOSSES as substrings here and style as SMALL CAPS.
					Might be best to compare against a master list of functor morphemes glosses. -->
										<xsl:variable name="startcase">ABCDEFGHIJKLMNOPQRSTUVWXYZ </xsl:variable>
										<xsl:variable name="endcase"
											>ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘQʀꜱᴛᴜᴠᴡxʏᴢ.</xsl:variable>
										<!--<xsl:value-of select="item[@type='gls']/text()"/>-->
										<!--Also for proper nouns that begin with a capital, we do not want to SMALL CAPS the capital. 
									Here we test: 
									If the first letter of the gloss is a capital then
									    Check the first letter of the txt or cf lines to see if they are the same capital.
									         If so, then do not convert to small caps.-->
										<xsl:variable name="vFirstCapGloss"
											select="substring(item[@type='gls']/text(),1,1)"/>
										<xsl:variable name="vFirstCapMorph"
											select="substring(item[@type='cf']/text(),1,1)"/>
										<xsl:variable name="vFirstCapBaseLine"
											select="substring(item[@type='txt']/text(),1,1)"/>
										<xsl:variable name="vFirstCapWordBaseLine"
											select="substring(../../item[@type='txt']/text(),1,1)"/>
										<xsl:choose>
											<xsl:when
												test="$vFirstCapGloss=$vFirstCapMorph or $vFirstCapGloss=$vFirstCapBaseLine or $vFirstCapGloss=$vFirstCapWordBaseLine">
												<xsl:value-of select="item[@type='gls']/text()"/>
											</xsl:when>
											<xsl:otherwise>
												<span class="preApGloss">
												<xsl:value-of
													select="translate(item[@type='glsPrepend']/text(), $startcase, $endcase)"
												/>
												</span>
												<xsl:value-of
												select="translate(item[@type='gls']/text(), $startcase, $endcase)"
												/>
												<span class="preApGloss">
												<xsl:value-of
													select="translate(item[@type='glsAppend']/text(), $startcase, $endcase)"
												/>
												</span>
											</xsl:otherwise>
										</xsl:choose>
										<!--<font style="font-variant: small-caps"><xsl:value-of select="translate(., $startcase, $endcase)"/></font>-->
										<xsl:if
											test="@type='prefix' or @type='prefixing interfix' or @type='infix'">
											<xsl:text>-</xsl:text>
										</xsl:if>
										<xsl:if test="@type='proclitic'">
											<xsl:text>=</xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:for-each>
				</tr>
				<tr class="lexPOS hidden">
					<!--Space in cell in column where the example number is housed-->
					<td class="labelColumn">&#160;<span class="rowLabel hidden">LexGrmInfo:</span></td>
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word">
						<td>
							<xsl:for-each select="morphemes/morph">
								<xsl:variable name="vMorphMsa">
									<xsl:value-of select="item[@type='msa']/text()"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$vMorphMsa=''">&#160;</xsl:when>
									<xsl:when test="$vMorphMsa='&lt;Not Sure&gt;'">?</xsl:when>
									<xsl:otherwise>
										<xsl:if
											test="@type='suffix' or @type='suffixing interfix' or @type='infix'">
											<xsl:text>-</xsl:text>
										</xsl:if>
										<xsl:if test="@type='enclitic'">
											<xsl:text>=</xsl:text>
										</xsl:if>
										<!-- If the morpheme count is greater than 1 AND the morpheme type is root or stem AND the preceding morpheme was a root or a stem, then put an underscore before the morpheme
										In other words, if a word is made up of mutilple roots or stems, we need a way to separate these other than the hyphen.-->
										<xsl:if
											test="position()>1 and (@type='root' or @type='stem') and (preceding-sibling::node()/@type='root' or preceding-sibling::node()/@type='stem' or preceding-sibling::node()/@type='circumfix') "
											>·</xsl:if>
										<!--<xsl:value-of select="item[@type='cf']/text()"/>-->
										<!--<xsl:variable name="vMorpheme"><xsl:value-of select="item[@type='cf']/text()"/></xsl:variable>-->
										<xsl:value-of select="$vMorphMsa"/>
										<xsl:if
											test="@type='prefix' or @type='prefixing interfix' or @type='infix'">
											<xsl:text>-</xsl:text>
										</xsl:if>
										<xsl:if test="@type='proclitic'">
											<xsl:text>=</xsl:text>
										</xsl:if>

									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</xsl:for-each>
				</tr>
				
				<!-- Provides wordGloss and wordPOS below the morpheme lines -->
				<tr class="wordGloss hidden">
					<!--Segment number-->
					<td class="labelColumn">
						<span class="rowLabel">&#160; WdGloss:</span>
					</td>
					<!-- Count the number of words in the segment -->
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word/item[@type='gls'] ">
						<!-- Only works with XSLT 2.0 <xsl:variable name="vLongestAnnotation">
							<xsl:value-of select="../morphemes/morph/item[not(string-length() &lt; current()/../morphemes/morph/item/string-length())][1]"/>
						</xsl:variable>-->
						<td class="wordGloss">
							<xsl:value-of select="text()"/>
						</td>
					</xsl:for-each>
				</tr>
				
				<!-- Row with Word parts-of-speech. Starts as hidden.-->
				<tr class="wordPOS hidden">
					<!--Segment number-->
					<td class="labelColumn">
						<span class="rowLabel">&#160; WdCat:</span>
					</td>
					<!-- Count the number of words in the segment -->
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word/item[@type='pos'] ">
						<!-- Only works with XSLT 2.0 <xsl:variable name="vLongestAnnotation">
							<xsl:value-of select="../morphemes/morph/item[not(string-length() &lt; current()/../morphemes/morph/item/string-length())][1]"/>
						</xsl:variable>-->
						<td class="wordGloss">
							<xsl:value-of select="text()"/>
						</td>
					</xsl:for-each>
				</tr>
				<!-- LexPOS row-->
				<!--Temporarily getting rid of this *********-->
				<!--tr class="morphmsa">
					<td/>
					<xsl:variable name="vNumWords">
						<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"
						/>
					</xsl:variable>
					<xsl:for-each select="words/word">
						<td class="LexPOS">
							<xsl:for-each select="morphemes/morph">
								<xsl:if test="@type='suffix'">
									<xsl:text>-</xsl:text>
								</xsl:if>
								<xsl:value-of select="item[@type='msa']/text()"/>
								<xsl:if test="@type='prefix'">
									<xsl:text>-</xsl:text>
								</xsl:if>
							</xsl:for-each>
						</td>
					</xsl:for-each>
				</tr-->

				<!-- Word Gloss rows still need to be done-->

				<!--In order to get the colspan correct, we need to count number of columns from above.
				      One column for each word and punctuation.-->
				<xsl:variable name="vNumWords">
					<xsl:value-of select="count(words/word/item[@type='txt' or @type='punct'])"/>
				</xsl:variable>
				<!-- If Free translations exist for the segment then create Free translation row-->
				<xsl:if test="item[@type='gls']">
					<tr class="itxFreeTranslation">
						<td class="labelColumn">&#160;<span class="rowLabel hidden"
							>Free:</span></td>
						<td>
							<xsl:attribute name="colspan">
								<xsl:value-of select="$vNumWords"/>
							</xsl:attribute> &apos;<xsl:value-of select="item[@type='gls']"/>&apos;
						</td>
					</tr>
				</xsl:if>
				<!-- If Literal translations exist for the segment then create Lit translation row-->
				<xsl:if test="item[@type='lit']">
					<tr class="itxLiteralTranslation">
						<td class="labelColumn">&#160;<span class="rowLabel hidden">Lit:</span></td>
						<td>
							<xsl:attribute name="colspan">
								<xsl:value-of select="$vNumWords"/>
							</xsl:attribute> Lit: &apos;<xsl:value-of select="item[@type='lit']"
							/>&apos; </td>
					</tr>
				</xsl:if>
			</tbody>
		</table>
		<!-- Notes are little funky if they are contained in the same table as the interlinear due to their possible length compared to that of the segment. 
					To compensate for this, we create a paragraph for each note. -->
		<xsl:if test="item[@type='note']">
			<xsl:for-each select="item[@type='note']">
				<p class="itxNotes"> Note: <xsl:value-of select="."/>
				</p>
			</xsl:for-each>
		</xsl:if>
		<div>
			<span>&#160;</span><span class="horizontalLine">&#160;</span>
		</div>
	</xsl:template>

	<!--Notes on the segment. Because this is applied against any phrase\item, multiple notes are handled here without problem.-->
	<xsl:template match="phrase/item[@type='note']">
		<xsl:variable name="vNumWords">
			<xsl:value-of select="count(../words/word[item[@type='txt']])"/>
		</xsl:variable>
		<tr class="itxNotes">
			<td/>
			<td>
				<xsl:attribute name="colspan">
					<xsl:value-of select="$vNumWords"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</td>
		</tr>
	</xsl:template>


	<!-- MISCELLANEOUS -->
	<xsl:template match="i">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>

	<xsl:template match="b">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>

	<xsl:template match="title">
		<block font-style="bold">
			<xsl:apply-templates/>
		</block>
	</xsl:template>


	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
