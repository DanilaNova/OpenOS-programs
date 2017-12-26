local computer = require("computer")
local component = require("component")
local term = require("term")
local colors = require("colors")
local gpu = component.gpu
local info = "MineTerm v1.1.0.0(Beta)\nCreator - Nova23"
local musicnotes = {784, 880, 988, 1175, 1175, 1319, 1175, 988, 784, 784, 880, 988, 988, 880, 784, 880}
local music_startup = {800, 1200, 1000, 800, 1000, 800, 1200}
local logoLineX = {{1,40},{}}
local termlogo = {{},{2,6,8,9,10,12,15,17,18,19,21,22,23,25,26,27,29,30,31,33,37},{2,3,5,6,9,12,13,15,17,22,25,29,31,33,34,36,37},{2,4,6,9,12,14,15,17,18,19,22,25,26,27,29,30,33,35,37},{2,6,9,12,15,17,22,25,29,31,33,37},{2,6,8,9,10,12,15,17,18,19,22,25,26,27,29,31,33,37}}
local starttime = os.time()
local filesystem = require("filesystem")
local event = require("event")
local keyboard = require("keyboard")

function startscreen()
	for i = 1,6 do
		for i2 = 1, #termlogo[i] do
			drawPixel(termlogo[i][i2],i,0xFFFFFF)
		end
	end
	gpu.setBackground(0x0000AA)
	gpu.setForeground(0xFFFFFF)
	term.setCursor(1,8)
end
function drawPixel(x,y,color)
	gpu.setBackground(color)
	gpu.set(x,y," ")
end
function musicbox(music, file)
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
    file:write(music .. "(unknown music.)\n")
    file:flush()
    print("Unknown music.")
  end
end
function check(cmd , file)
  if(cmd == "info") then
    file:write("Info request.\n")
    file:flush()
    gpu.setForeground(0xFF0000)
    print("Warning!The program is at an early stage of development.")
    gpu.setForeground(0xFFFFFF)
    print(info)
    cmnd(file)
  elseif(cmd == "music") then
    file:write("Music request: ")
    file:flush()
    print("Music:\nstartup , bells\nChoose:")
    musica = io.read()
    musicbox(musica, file)
    cmnd(file)
  elseif(cmd == "help") then
    file:write("Command list request.\n")
    file:flush()
    print("help - command list\ninfo - info about program\nmusic - choose music\nshell - exit in OpenOS.")
    cmnd(file)
  elseif(cmd == "shell") then
    file:write("Off terminal.\n")
    file:flush()
    computer.beep(1000,0.2)
    gpu.setBackground(0x000000)
    gpu.setForeground(0XFFFFFF)
    computer.beep(500,0.2)
    term.clear()
  else
    file:write("Unknown command:" .. cmd .. "\n")
    file:flush()
    print("Unknown command.")
    cmnd(file)
  end
end
function cmnd(logfile)
  command = io.read()
  computer.beep(1000,0.05)
  check(command , logfile)
end

term.clear()
print("Launching the Terminal...")
local file = io.open("/home/MineTerm/logs/log-" .. starttime, "w")
file:write(starttime .. "\n")
file:write("Terminal launched.\n")
file:flush()
gpu.setBackground(0x0000AA)
gpu.setForeground(0xFFFFFF)
term.clear()
startscreen()
print("Hello, user,\nEnter the command(help - command list):")
cmnd(file)
file:write("\nNo errors")
file:close()