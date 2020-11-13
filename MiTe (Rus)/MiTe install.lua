print("Запуск установщика...")
local filesystem = require("filesystem")
if(not (filesystem.exists("/home/MineTerm"))) then
	print("Установка терминала...")
	filesystem.makeDirectory("/home/MineTerm")
	filesystem.makeDirectory("/home/MineTerm/logs")
	os.execute("wget 'https://pastebin.com/raw/zwDRa6jS' /home/MineTerm/Mineterm")
	local file = io.open("/home/.shrc","a")
	file:write("\n/home/MineTerm/MineTerm")
	file:close()
elseif(not (filesystem.exists("home/MineTerm/logs"))) then
	print("Ремонт терминала...")
	filesystem.makeDirectory("/home/MineTerm/logs")
	os.execute("wget 'https://pastebin.com/raw/zwDRa6jS' /home/MineTerm/Mineterm")
end