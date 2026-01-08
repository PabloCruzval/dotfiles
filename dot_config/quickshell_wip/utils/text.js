
function verticalSplit(str, max_size = 10){
	str = str.trim()
	if (str.length > max_size) {
		str = str.slice(0, max_size)
		str += "..."
	}
	return str.split('').map(c => c + "\n").join('')
}

function splitTime(str){
	return str.split(":").join("\n")
}
