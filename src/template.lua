return {
    dirs = {
        "assets",
        "assets/fonts",
        "assets/images",
        "assets/preloaded",
        "assets/sounds",
        "assets/videos",
        "libs",
        "src",
        "src/archives",
        "src/modules",
        "src/states"
    },
    files = {
        {
            name = "main.lua",
            content = [[
function love.load(_argc, _argv)
    --&libs&--
    --%graphicals libs%--
    gamestate = require "libs/gamestate"
    moonshine = require "libs/moonshine"
    camera = require "libs/camera"
    --%dataBank libs%--
    json = require "libs/json"
    lip = require "libs/lip"
    --%others%--
    timer = require "libs/timer"
    collision = require "libs/collision"
    require "libs/lep"
    --%addons%--
    atlasparser = require "libs/addons/atlasparser"
    --&vars&--
    --%tables%--
    --%gamestate states%--
    states = {}
    states.firststate = require "src/states/firststate"
    --%data tipes%--
    font = love.graphics.setNewFont(12) --defaultFont
    --&cmds&--
    love.graphics.setDefaultFilter("nearest", "nearest") --defaultfilter
    gamestate.registerEvents({"update"; "textinput"; "textedited"; "keypressed"; "touchpressed"; "touchmoved"; "touchreleased"})
    gamestate.switch(states.firststate)
end

function love.draw() gamestate.current():draw() end

function love.textedited(_t, _s, _l) suit.textedited(_t, _s, _l) end

function love.keypressed(_k) suit.keypressed(_k) end

function love.textinput(_t) suit.keypressed(_t) end
]]
        },
        {
            name = "conf.lua",
            content = [[
function love.conf(t)
--^settings^--
    t.window.fullscreen = true
    t.window.width = 740
    t.window.height = 460
--^game^--
    t.window.title = "new project"
    t.icon = nil
    t.author = "AyanoTheFox"
--^save^--
    t.externalstorage = true
    t.indentity = "FoxToolBoxDefault" 
end
]]
        },
        {
            name = "src/states/firststate.lua",
            content = [[
firststate = {}

function firststate:enter()
    
end

function firststate:draw()
    love.graphics.print("Hello World, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 2, 2, font:getWidth("Hello world!") / 2, font:getHeight() / 2)
end

function firststate:update(_elapsed)
    
end

return firststate
]]
        },
        {
            name = "README.md",
            content = [[
## FoxToolBox
 The FoxToolBox is only a group of libaries that i use to make my softwares, games and projects on love2d engine

### libaries Credits
 - [hump/camera by Vrld](https://github.com/vrld/hump)
 - [hump/gamestate by Vrld](https://github.com/vrld/hump)
 - [hump/time by Vrld](https://github.com/vrld/hump)
 - [moonshine by Vrld](https://github.com/vrld/moonshine)
 - [SUIT by Vrld](https://github.com/vrld/SUIT)
 - [LIP by Videah](https://github.com/videah/Love_INI_Parser/blob/master/LIP.lua)
 - [json by Actboy168](https://github.com/actboy168/json.lua/blob/master/json.lua)
 - [LEP by AyanoTheFoxy (me :3)](https://gist.github.com/AyanoTheFox/ca2578d4ba54dd32fc142e84e5681bd3)
]]
        },
        {
            name = ".gitignore",
            content = [[]]
        },
        {
            name = "LICENSE",
            cobtent = [[]]
        },
        {
            name = "CHANGELOG",
            cobtent = [[]]
        }
    }
}