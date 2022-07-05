local computer = require("computer")
local component = require("component")
local term = require("term")
local gpu = component.gpu
local info = "MineTerm v0.1.2(Beta)\nСоздатель - Nova23"
local musicnotes = {784, 880, 988, 1175, 1175, 1319, 1175, 988, 784, 784, 880, 988, 988, 880, 784, 880}
local music_startup = {800, 1200, 1000, 800, 1000, 800, 1200} --Музыка при запуске
local starttime = os.time()
local event = require("event")
local startpic = { --Лого MiTe
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0xFF0000,0,0,0,0xFF0000,0,0xFFA500,0xFFA500,0xFFA500,0,0xFFFF00,0,0,0xFFFF00,0,0x008000,0x008000,0x008000,0,0x00BFFF,0x00BFFF,0x00BFFF,0,0x0000FF,0x0000FF,0x0000FF,0,0xEE82EE,0xEE82EE,0,0,0x800080,0,0,0,0x800080,0},
	{0,0xFF0000,0xFF0000,0,0xFF0000,0xFF0000,0,0,0xFFA500,0,0,0xFFFF00,0xFFFF00,0,0xFFFF00,0,0x008000,0,0,0,0,0x00BFFF,0,0,0x0000FF,0,0,0,0xEE82EE,0,0xEE82EE,0,0x800080,0x800080,0,0x800080,0x800080,0},
	{0,0xFF0000,0,0xFF0000,0,0xFF0000,0,0,0xFFA500,0,0,0xFFFF00,0,0xFFFF00,0xFFFF00,0,0x008000,0x008000,0x008000,0,0,0x00BFFF,0,0,0x0000FF,0x0000FF,0x0000FF,0,0xEE82EE,0xEE82EE,0,0,0x800080,0,0x800080,0,0x800080,0},
	{0,0xFF0000,0,0,0,0xFF0000,0,0,0xFFA500,0,0,0xFFFF00,0,0,0xFFFF00,0,0x008000,0,0,0,0,0x00BFFF,0,0,0x0000FF,0,0,0,0xEE82EE,0,0xEE82EE,0,0x800080,0,0,0,0x800080,0},
	{0,0xFF0000,0,0,0,0xFF0000,0,0xFFA500,0xFFA500,0xFFA500,0,0xFFFF00,0,0,0xFFFF00,0,0x008000,0x008000,0x008000,0,0,0x00BFFF,0,0,0x0000FF,0x0000FF,0x0000FF,0,0xEE82EE,0,0xEE82EE,0,0x800080,0,0,0,0x800080,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
}
local minreq = {["ColorDepth"] = 4, ["Memory"] = 6000}

function checkreq() --Сравнивание характерискик компьютера
	if(gpu.maxDepth()<minreq["ColorDepth"]) then
		return 1
	elseif(computer.totalMemory()<minreq["Memory"]) then
		return 2
	else
		return 0
	end
end
function picprint(pictable) --Отрисовка изображений
	local OldBG = gpu.getBackground()
	for i = 1, #pictable do
		for i2 = 1, #pictable[i] do
			if(pictable[i][i2] ~= 0) then
				gpu.setBackground(pictable[i][i2])
				gpu.set(i2,i," ")
			end
		end
	end
	gpu.setBackground(OldBG)
	local cur = #pictable + 1
	term.setCursor(1,cur)
end

function musicbox(music, file) --Проигрывание музыки
  if(music == "startup") then
    file:write("startup.\n")
    file:flush()
    for i = 1, #music_startup do
      computer.beep(music_startup[i],0.2)
    end
  elseif(music == "bells") then
    file:write("bells.\n")
    file:flush()
    for i = 1, #musicnotes do
      computer.beep(musicnotes[i],0.2)
    end
  else
    file:write(music .. "(неизвестная музыка.)\n")
    file:flush()
    print("Неизвестная музыка.")
  end
end

function check(cmd , file)
  if(cmd == "info") then --Информация о терминале
    file:write("Запрос информации.\n")
    file:flush()
    gpu.setForeground(0xFF0000)
    print("Внимание!Программа находится в ранней стадии разработки.")
    gpu.setForeground(0x0000FF)
    print(info)
    cmnd(file)
  elseif(cmd == "music") then --Музыка
    file:write("Запрос музыки: ")
    file:flush()
    print("Музыка:\nstartup , bells\nВыберите музыку:")
    musica = io.read()
    musicbox(musica, file)
    cmnd(file)
  elseif(cmd == "picture") then --Просмотр изображений
    file:write("Запрос изображения:")
    file:flush()
    print("Изображения\nstartpic\nВыберите:")
    pichoose = io.read()
    if(pichoose == "startpic") then
      term.clear()
      file:write(pichoose)
      file:flush()
      picprint(startpic)
      waiting = {event.pull("key_down")}
      term.clear()
      cmnd(file)
    else
      file:write(pichoose .. "(Неизвестное изображение)\n")
      file:flush()
      print("Такого изображения нет")
    end 
	cmnd(file)
  elseif(cmd == "help") then --Помощь
    file:write("Запрос списка комманд.\n")
    file:flush()
    print("help - помошь\ninfo - информация о программе\nmusic - выбрать музыку\npicture - посмотреть изображение\nshell - выйти в OpenOS.")
    cmnd(file)
  elseif(cmd == "lua") then --Запуск интерпретатора lua
    debug.debug()
    cmnd(file)
  elseif(cmd == "shell") then --Выход в OpenOS
    file:write("Выход из терминала.\n")
    file:flush()
    computer.beep(1000,0.2)
    gpu.setBackground(0x000000)
    gpu.setForeground(0XFFFFFF)
    computer.beep(500,0.2)
    term.clear()
  else
    file:write("Нейзвестная комманда:" .. cmd .. "\n")
    file:flush()
    print("Такой коммманды не существует.")
    cmnd(file)
  end
end
function cmnd(logfile)
  command = io.read():lower()
  computer.beep(1000,0.05)
  check(command , logfile)
end

term.clear()
print("Запуск терминала...")
local req = checkreq()
if(req ~= 0) then
  if(req == 1) then
    error("Для нормальной работы нужна глубина цвета как минимум "..minreq["ColorDepth"]..".",0)
  elseif(req == 2) then
    error("Для нормальной работы нужно как минимум ".. math.round(minreq["Memory"]/1000) .."кб памяти",0)
  else
    error("Несоответствие требований. Подробности неизветсны. Код ошибки 1"..req)
  end
end
local file = io.open("/home/MineTerm/data/logs/log-" .. starttime, "w")
file:write(starttime .. "\n")
file:write("Терминал запущен.\n")
file:flush()
gpu.setBackground(0xA9A9A9)
gpu.setForeground(0x0000FF)
term.clear()
picprint(startpic)
print("Здравствуйте, пользователь,\nВведите комманду(help - помощь):")
cmnd(file)
file:write("\nОшибок нет")
file:close()