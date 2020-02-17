function showImage(address) {
		
	/* must not have a window if showing a new window*/
	if (document.getElementById('imageWindow') == null) {
		
		var imageWindow = document.createElement("div");
		imageWindow.id = "imageWindow";		
		imageWindow.innerHTML = "<div id='imageWindowShaded'><a href='javascript:closeImage()'><div id='imageWindowClose'><span id='imageWindowCloseText'>X</span></div></a><a href='javascript:closeImage()'><img id='imageWindowImage' width='800' height='800' src='" + address + "'/></a></div>";
	
		
	/* just update the image*/
	} else {
		var imageWindowImage = document.getElementById("imageWindowImage");
		imageWindowImage.src = address;
	}
	
	var data = document.getElementById("data");
	data.appendChild(imageWindow);
	data.innerHTML = data.innerHTML;
}

function closeImage() {
	var imageWindow = document.getElementById("imageWindow")
	imageWindow.parentNode.removeChild(imageWindow);
}
