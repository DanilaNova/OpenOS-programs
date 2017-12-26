print("Launching installer...")
local filesystem = require("filesystem")
if(not (filesystem.exists("/home/MineTerm"))) then
	print("Install the terminal...")
	filesystem.makeDirectory("/home/MineTerm")
	filesystem.makeDirectory("/home/MineTerm/logs")
	os.execute("wget 'https://pastebin.com/raw/UkqQNak7' /home/MineTerm/Mineterm")
	local file = io.open("/home/.shrc","a")
	file:write("\n/home/MineTerm/MineTerm")
	file:close()
elseif(not (filesystem.exists("home/MineTerm/logs"))) then
	print("Fixing the terminal...")
	filesystem.makeDirectory("/home/MineTerm/logs")
	os.execute("wget 'https://pastebin.com/raw/UkqQNak7' /home/MineTerm/Mineterm")
end