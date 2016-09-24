var chatCount = 0;

function bindKeypressEvents(event){
	$('#chat-box').keydown(function(event){
		var enterPressed = event.which == 13;
		if(enterPressed){
			var chatBoxText = $('#chat-box').val();
			var userChatHTML = getUserChatDOM(chatBoxText);
			appendChat(userChatHTML);
			getResponse(chatBoxText);
			$('#chat-box').val("");
			autoScroll();
			event.preventDefault();
		}
	});
}

function bindShowMoreLink(){
	$("a[class^='show-more']").on('click', function(event){
		var className = $(this).attr('class');
		var contentClassName = className + "-content";
		$("."+className).css('display', 'none');
		$("."+contentClassName).css('display', 'block');
	});
}

function appendChat(html){
	chatCount = chatCount + 1;
	$('.content-box').append(html);
	bindShowMoreLink();
}

function getUserChatDOM(content){
	var userChatHTML = "<div class='pushed-chat right-chat'><div class='image-wrapper'><img src='/assets/profile.svg'></div><div class='content'>"+content+"</div></div>";
	return userChatHTML;
}

function getBotChatDOM(content){
	var botChatDOM = "<div class='pushed-chat'><div class='image-wrapper'><img src='/assets/bot.svg'></div><div class='content'>"+content+"</div></div>";
	return botChatDOM;	
}

function getNullPointerHTML(){
	return "<div>Sorry! Couldn't find the results at the moment.</div>";
}

function autoScroll(){
	var alphabetsPerLine = 50;
	var totalNumberOfLines = $(".content-box").html().length/alphabetsPerLine;
	var heightOfOneLine = 30;
	$(".content-box").animate({
		scrollTop: heightOfOneLine*totalNumberOfLines
	}, 500);
}

function handleQuestions(){

}

function putItInShowMore(content){
	var inShowMore = false
	if(content.length > 100){
		inShowMore = true;
	}
	return inShowMore;
}

function handleLinks(data){
	var linksHTML = ["", ""];
	if(data && data.length != 0){
		for(var i=0; i < data.length; i++){
			var link = data[i];
			if(putItInShowMore(linksHTML[0])){
				linksHTML[1] = linksHTML[1] + htmlFormat.getLink(link);
			}
			else{
				linksHTML[0] = linksHTML[0] + htmlFormat.getLink(link);
			}
		}
		linksHTML[0] = "<div>"+linksHTML[0]+"</div>";
		linksHTML[1] = htmlFormat.getShowMore("show-more-"+chatCount+"-link", linksHTML[1]);
		linksHTML = linksHTML[0] + linksHTML[1];
		appendChat(getBotChatDOM(linksHTML));
	}
	else{
		appendChat(getBotChatDOM(getNullPointerHTML()));
	}
}

function handleHelp(data){
	var helpHTML = "";
	for(var i=0; i<data.length; i++){
		var help = data[i];
		helpHTML = helpHTML + "<div>"+help+"</div>";
	}
	helpHTML = "<div>"+helpHTML+"</div>";

	appendChat(getBotChatDOM(helpHTML));
}

function handleChemicalReactions(data){
	var chemicalReactionsHTML = ["", ""];
	if(data && data.length != 0){
		for(var i=0; i < data.length; i++){
			var chemicalReaction = data[i];
			if(putItInShowMore(chemicalReactionsHTML[0])){
				chemicalReactionsHTML[1] = chemicalReactionsHTML[1] + htmlFormat.getChemicalReaction(chemicalReaction);
			}
			else{
				chemicalReactionsHTML[0] = chemicalReactionsHTML[0] + htmlFormat.getChemicalReaction(chemicalReaction);
			}
		}
		chemicalReactionsHTML[0] = "<div>"+chemicalReactionsHTML[0]+"</div>";
		chemicalReactionsHTML[1] = htmlFormat.getShowMore("show-more-"+chatCount+"-chemical-reaction", chemicalReactionsHTML[1]);
		chemicalReactionsHTML = chemicalReactionsHTML[0] + chemicalReactionsHTML[1];
		appendChat(getBotChatDOM(chemicalReactionsHTML));
	}
	else{
		appendChat(getBotChatDOM(getNullPointerHTML()));	
	}
}

function handleQuotes(){

}

function handleImages(){

}

function handleShowMore(){

}

function handleExamples(data){
	var examplesHTML = ["", ""];
	if(data && data.length != 0){
		for(var i=0; i<data.length; i++){
			var example = data[i];
			console.debug("example id", example.id);
			var name = example.name;
			var contentBlock = getContentBlock(example);
			var contentBlockHTML = getContentBlockHTML(contentBlock);
			contentBlockHTML = "<div class='content-wrapper'><h2>"+example.name+"</h2><div>"+contentBlockHTML+"</div></div>";
			if(putItInShowMore(examplesHTML[0])){
				examplesHTML[1] = examplesHTML[1] + contentBlockHTML;
			}
			else{
				examplesHTML[0] = examplesHTML[0] + contentBlockHTML;
			}
		}
		examplesHTML[0] = "<div>"+examplesHTML[0]+"</div>";
		examplesHTML[1] = htmlFormat.getShowMore("show-more-"+chatCount+"-example", examplesHTML[1]);
		examplesHTML = examplesHTML[0] + examplesHTML[1];
		appendChat(getBotChatDOM(examplesHTML));
	}
	else{
		appendChat(getBotChatDOM(getNullPointerHTML()));
	}
}

function handleData(data){
	if(data){
		contentBlockHTML = getContentBlockForData(data);
		appendChat(getBotChatDOM(contentBlockHTML));
	}
	else{
		appendChat(getBotChatDOM(getNullPointerHTML()));
	}	
}

function getContentBlockForData(data){
	var topic = data;
	console.debug("topic id", topic.id);
	var name = topic.name;
	var contentBlock = getContentBlock(topic);
	var contentBlockHTML = getContentBlockHTML(contentBlock);
	contentBlockHTML = "<div class='content-wrapper'><h2>"+topic.name+"</h2><div>"+contentBlockHTML+"</div></div>";
	return contentBlockHTML;
}

function getContentBlockHTML(contentBlock){
	var contentBlockHTML = "";
	for(var cb=0; cb < contentBlock.length; cb++){
		var content = contentBlock[cb];
		if(content){
			if(content.type == "image"){
				contentBlockHTML = contentBlockHTML + htmlFormat.getImage(content);
			}
			else if(content.type == "paragraph"){
				contentBlockHTML = contentBlockHTML + htmlFormat.getParagraph(content.content);
			}
			else if(content.type == "table"){
				contentBlockHTML = contentBlockHTML + htmlFormat.getTable(content.content);
			}
			else if(content.type == "chemicalReaction"){
				contentBlockHTML = contentBlockHTML + htmlFormat.getChemicalReaction(content.content);
			}
			else if(content.type == "quote"){
				contentBlockHTML = contentBlockHTML + htmlFormat.getQuote(content.content);	
			}
			else if(content.type == "sub_heading"){
				contentBlockHTML = contentBlockHTML + getContentBlockForData(content.content);
			}
		}
		else{
			console.debug("empty element position", cb);
		}
	}
	return contentBlockHTML;
}

function getContentBlock(content){
	var contentBlock = new Array(content.element_count);
	if(content.images){
		for(var im=0; im < content.images.length; im++){
			var image = content.images[im];
			var position = image.position;
			contentBlock[position] = {"type": "image", "content": image, "chapter_id": content.chapter_id};
		}
	}
	if(content.paragraphs){
		for(var pa=0; pa < content.paragraphs.length; pa++){
			var paragraph = content.paragraphs[pa];
			var position = paragraph.position;
			contentBlock[position] = {"type": "paragraph", "content": paragraph};
		}
	}
	if(content.tables){
		for(var ta=0; ta < content.tables.length; ta++){
			var table = content.tables[ta];
			var position = table.position;
			contentBlock[position] = {"type": "table", "content": table};
		}
	}
	if(content.chemical_reactions){
		for(var ch=0; ch < content.chemical_reactions.length; ch++){
			var chemical_reaction = content.chemical_reactions[ch];
			var position = chemical_reaction.position;
			contentBlock[position] = {"type": "chemicaReaction", "content": chemical_reaction};
		}
	}
	if(content.quotes){
		for(var qu=0; qu < content.quotes.length; qu++){
			var quote = content.quotes[qu];
			var position = quote.position;
			contentBlock[position] = {"type": "quote", "content": quote};
		}	
	}
	if(content.sub_headings){
		for(var sh=0; sh < content.sub_headings.length; sh++){
			var sub_heading = content.sub_headings[sh];
			var position = sub_heading.position;
			contentBlock[position] = {"type": "sub_heading", "content": sub_heading};
		}
	}
	return contentBlock;
}

var htmlFormat = (function(){

	return{
		getShowMore: function(id, content){
			return "<a class='"+id+"'>Show more...</a><div style='display: none;' class='"+id+"-content'>"+content+"</div>";
		},
		getImage: function(content){
			var chapter_id = content.chapter_id;
			content = content.content;
			var image = "assets/book/"+chapter_id+"/"+content.name+".png";
			return "<div><img class='figure' src='"+image+"'/></div>";
		},
		getParagraph: function(content){
			return "<p>"+content.content+"</p>";
		},
		getQuote: function(content){
			return "<h2>"+content.content+"</h2>";
		},
		getChemicalReaction: function(content){
			var description = content.description;
			var imageHTML = "";
			if(content.name && content.name != null){
				var image = "assets/book/"+content.chapter_id+"/"+content.name+".png";
				imageHTML = "<div><img class='figure' src='"+image+"'/></div>";
			}
			var chemicaReactionHTML = imageHTML + "<p>"+description+"</p>"
			return chemicaReactionHTML;
		},
		getLink: function(content){
			var url = "https://"+content.url;
			return "<div class='content-wrapper'><a target='_blank' href="+url+">"+content.name+"</a></div>";
		}
	}
}());

function handleResponse(data){
	if(data.message){
		appendChat(getBotChatDOM(data.message));
	}
	else if(data.question){
		handleQuestions(data.question);
	}
	else if(data.link){
		handleLinks(data.link);
	}
	else if(data.help){
		handleHelp(data.help);
	}
	else if(data.chemicalReaction){
		handleChemicalReactions(data.chemicalReaction);
	}
	else if(data.quote){
		handleQuotes(data.quote);
	}
	else if(data.images){
		handleImages(data.images);
	}
	else if(data.example){
		handleExamples(data.example);
	}
	else if(data.data){
		handleData(data.data);
	}
}

function getResponse(text){
	$('.loading').css('display', 'block');
	$.ajax({
		url: "api/v0/response",
		data: "q="+text,
		success: function(data, textStatus, jqXHR){
			$('.loading').css('display', 'none');
			handleResponse(data);
			autoScroll();
		}
	})
}

$(document).ready(function(){
	bindKeypressEvents();	
});
