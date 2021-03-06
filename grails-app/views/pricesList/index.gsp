<html>
	<head>
	<title>MercadoLibre Argentina - Gu&iacute;a de precios de ACARA</title>
	<meta name="robots" content="index,follow"><meta name="description" content="� Comprar y Vender en MercadoLibre !"><meta name="keywords" content="subastas, subasta, comprar, vender, compra, venta, remate, remates"><meta name="Classification" content="subastas, subasta, comprar, vender, compra, venta, remate, remates">
	<meta content="main" name="layout"/>
	
	<p:javascript src='acaraJS.base'/>
	<p:css name='acaraCSS.base'/>
	
	</head>
<body>
<div class="box noBorder">	


<!-- chico -->

<form class="demo_form box" novalidate="novalidate">
	<fieldset>
		<legend>Guia de precios de ACARA</legend>
		<ul>
			<li class="fieldBox">
				<label class="required" for="brand">
					<span>Marca:<em>*</em></span>
					<select class="required" id="brand" required="required" style="width:250" ></select>
				</label>
			</li>
			<li class="fieldBox">
				<label class="required" for="model">
					<span>Modelo:<em>*</em></span>
					<select class="required" id="model" required="required" style="width:250" ></select>
				</label>
			</li>
			<li class="fieldBox">
				<label class="required" for="version">
					<span>Version:<em>*</em></span>
					<select class="required" id="version" required="required" style="width:250" ></select>
				</label>
			</li>
		</ul>
	</fieldset>
	<p class="actions"><input type="button" class="btn primary" id="priceSearch" value="Buscar precios"></p>
</form>	

<!-- fin chico -->


<!-- inicio precios -->

<fieldset id="versionPrices">
			
									
			<br>
			<!-- Inicio tabla paginas internas -->
			
			<div class="ContentInfo options required" id="pricesTable">
							
								
			</div>
			<br>

</fieldset>

<!-- fin precios -->
</div>
<g:javascript>

jQuery(function ($) {
	$(document).ready(function (e) {
		//alert('b');
		var brandComb = $('#brand');
		var i;
		for(i=0; i< carBrands.length; i++){
				brandComb.append("<option value="+carBrands[i].id+">"+carBrands[i].name+"</option>");
			}
			
		$('#brand').change();	
	
	});
	
	
	
	
});


var openTableComponent = "<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\"><thead id=\"pricesHead\"><tr><th> <p>Version</p> </th><th> <p>0 Km</p></th><th> <p>2010</p></th><th> <p>2009</p></th><th> <p>2008</p></th><th> <p>2007</p></th><th> <p>2006</p></th><th> <p>2005</p></th><th> <p>2004</p></th><th> <p>2003</p></th><th> <p>2002</p></th><th> <p>2001</p></th><th> <p>2000</p></th><th> <p>1999</p></th></tr> </thead><tbody id=\"pricesBody\">";
var closeTableComponent = "</tbody></table>";
var emptyPrice = "-";

$('#brand').change(function(b){
	var brandVal = $('#brand').val();	
	fillModels(brandVal);
});

$('#model').change(function(){
	//ClearAndEnableVersion();
	//var versionComp = $('#version');
	var brandId = $('#brand').val();
	var modelId = $('#model').val();
	fillVersions(brandId, modelId);
});

function singleVersionPricesTable(versionName, priceSymbol, prices){
	var table = openTableComponent;
	table += buildVersionTR(versionName, priceSymbol, prices);
	table += closeTableComponent;
	$('#pricesTable').html(table);
}

function multiVersionPricesTable(brandId, modelId){
 	var table = openTableComponent;
 	var versionsTRs = "";
 	var versionsToPrint = eval('car_model_'+brandId+'_'+modelId);
 	var versionPrices;
	for(var i=0; i < versionsToPrint.length; i++){
		versionPrices =  eval("prices_"+brandId+"_"+modelId+"_"+versionsToPrint[i].id);
		versionsTRs += buildVersionTR(versionsToPrint[i].name, versionsToPrint[i].symbol, versionPrices);
	}
	table += versionsTRs;
	table += closeTableComponent;
	$('#pricesTable').html(table);
}

$('#priceSearch').click(function(){
	var brandId = $('#brand').val();
	var modelId = $('#model').val();
	var versionId = $('#version').val();
	if(versionId=='-1'){
		var versionsToshow = eval('model_'+brandId+'_'+modelId);
		multiVersionPricesTable(brandId, modelId);
	}else{
		var versionName = $("#version option:selected").text();
		var prices = eval('car_prices_'+brandId+"_"+modelId+"_"+versionId);
		var priceSymbol = eval('car_model_'+brandId+'_'+modelId).symbol;
		singleVersionPricesTable(versionName, priceSymbol, prices);
	}

});

function fillModels(brandId){
	 var modelValues = eval('car_brand_'+brandId);	
	 var fill = "";
	 for(var i=0; i< modelValues.length; i++){
			fill += "<option value=\""+modelValues[i].id+"\">"+modelValues[i].name+"</option>";
		}
	 $('#model').html(fill);
	 fillVersions(brandId, modelValues[0].id);
}

function fillVersions(brandId, modelId){
	var versionValues = eval('car_model_'+brandId+'_'+modelId);
	var fill = "<option value=\"-1\">Ver todas</option>";
	for(var i=0; i< versionValues.length; i++){
		fill += "<option value="+versionValues[i].id+">"+versionValues[i].name+"</option>";
	}
	$('#version').html(fill);

}	

function thNode(symbol, content){
	if(content=="0"){
		return "<th><p>"+emptyPrice+"</p></th>";
	}else{
		return "<th><p>"+symbol+' '+content+"</p></th>";
	}
}				

function trNode(content){
	return "<tr>"+content+"</tr>";
}			

function buildVersionTR(versionName, priceSymbol, prices){
	
	var ths = thNode('', versionName);
	ths += thNode(priceSymbol, prices.index0KM);
	ths += thNode(priceSymbol, prices.index2010);
	ths += thNode(priceSymbol, prices.index2009);
	ths += thNode(priceSymbol, prices.index2008);
	ths += thNode(priceSymbol, prices.index2007);
	ths += thNode(priceSymbol, prices.index2006);
	ths += thNode(priceSymbol, prices.index2005);
	ths += thNode(priceSymbol, prices.index2004);
	ths += thNode(priceSymbol, prices.index2003);
	ths += thNode(priceSymbol, prices.index2002);
	ths += thNode(priceSymbol, prices.index2001);
	ths += thNode(priceSymbol, prices.index2000);
	ths += thNode(priceSymbol, prices.index1999);
	return trNode(ths);
}


</g:javascript>



</body>
</html>
