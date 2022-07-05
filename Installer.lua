print("Launching installer...")
local filesystem = require("filesystem")
local computer = require("computer")
local dict = {}

print("Select language. Выберите язык. (Eng/Рус)")
while true do
  sel = io.read()
  if(string.lower(sel) == "eng") then 
    dict = {"Prepairing working folder...","Downloading files...","Done. Do you want to reboot?(Y/n)","Reinstalling the terminal..."}
    break
  elseif(string.lower(sel) == "рус") then
    dict = {"Подготовка рабочей папки...","Загрузка файлов...","Готово. Хотите перезагрузить?(Y/n)","Переустановка терминала..."}
    break
  end
end

if(not filesystem.exists("/home/MineTerm")) then
  print(dict[1])
  filesystem.makeDirectory("/home/MineTerm")
  filesystem.makeDirectory("/home/MineTerm/logs")
  local file = io.open("/home/.shrc","a")
  file:write("\n/home/MineTerm/MineTerm\n")
  file:close()
  print(dict[2])
  os.execute("wget 'https://pastebin.com/raw/UkqQNak7' /home/MineTerm/Mineterm")
  print(dict[3])
  while true do
    sel = io.read()
    if(sel:lower() == "y") then 
      computer.shutdown(true)
    elseif(sel:lower() == "n") then
      break
    end
  end
elseif(not filesystem.exists("home/MineTerm/logs")) then
  print(dict[4])
  filesystem.makeDirectory("/home/MineTerm/logs")
  os.execute("wget 'https://pastebin.com/raw/UkqQNak7' /home/MineTerm/Mineterm")
end
