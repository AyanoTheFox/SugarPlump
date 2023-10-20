--&functions&--
function string.split(_str, _split)
    local _t = {}
    for _ in string.gmatch(_str, '([^' .. (_split or '%s') .. ']+)') do table.insert(_t, _) end
    return _t
end

function io.writeFile(_filename, _content)
    local _data = io.open(_filename, 'w')
    _data:write(_content or '')
    _data:close()
end

function io.mkDir(_dirName) os.execute("mkdir " .. _dirName) end

function os.getCurrentOs()
    local _bin = package.cpath:match("%p[\\|/]?%p(%a+)")
    if _bin == 'dll' then return 'windows'
    elseif _bin == 'so' then return 'linux'
    elseif _bin == 'dylib' then return 'macOS'
    else return 'unknow' end
end

function os.getDirItems(_dir)
    assert(type(_dir) ==  'string', "bad argument to #1 in function 'os.getDirItems' (string expected got a " .. type(_dir) .. ")")
    local _f, _t = io.popen('ls ' .. (_dir or '.')), {}
    if os.getCurrentOs() == "windows" then _f = io.popen('dir ' .. (_dir or '')) end
    for _ in _f:lines() do if _ ~= '.' or '..' then table.insert(_t, _) end end
    _f:close()
    if #_t == 1 then
        for _ in tostring(_t[1]):gmatch('([^' .. (_split or '%s') .. ']+)') do table.insert(_t, _) end
        table.remove(_t, 1)
    end
    return _t
end

function os.exists(_data)
    if os.rename(_data, _data) then return true 
    else return false end
end

--&variables&--
--%tables%--
template = {
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
    love.graphics.print("Hello World", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, 2, 2, font:getWidth("Hello world!") / 2, font:getHeight() / 2)
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
            name = ".gitignore"
        },
        {
            name = "LICENSE"
        },
        {
            name = "CHANGELOG"
        }
    }
}
cmdsList = {
    {
        name = "help",
        descript = "<none> | Give the basics Sugarplump commands",
        callback = function(_params)
            if #_params > 0 then 
                print("\27[1;91m" .. "The 'help' command haven't arguments" .. "\27[0m") 
            else
                print("\27[0m" .. "These some common Sugarplump commands.")
                print("\27[33m" .. "Class:\n" ..  "\27[34m" .. "- name (<param1>, <param2>, ... | description)" .. "\27[0m")
                for _, cmd in ipairs(cmdsList) do
                    if _ == 1 then
                        print("\27[33m" .. "\nHelper commands:" .. "\27[0m")
                    elseif _ == 4 then
                        print("\27[33m" .. "\nProject manager:" .. "\27[0m")
                    elseif _ == 9 then
                        print("\27[33m" .. "\nLovegame path:" .. "\27[0m")
                    end
                    print("\27[34m" .. "- " .. cmd.name .. " (" .. cmd.descript .. ")" .. "\27[0m") 
                end
            end
        end
    },
    {
        name = "show-projects",
        descript = "<none> | Show you alls löveprojects",
        callback = function(_params)
            if #_params > 0 then 
                print("\27[1;91m" .. "The 'show-projects' command haven't arguments" .. "\27[0m") 
            elseif os.exists("loveprojects") then
                for _, dir in ipairs(os.getDirItems("loveprojects")) do
                    print(_ .. " - " .. dir)
                end
            else
                print("\27[1;91m" .. "Cannot access the 'loveprojects' path (no such directory)" .. "\27[0m") 
            end
        end
    },
    {
        name = "close",
        descript = "<none> | Finish the program",
        callback = function(_params)
            if #_params > 0 then 
                print("\27[1;91m" .. "The 'close' command haven't arguments" .. "\27[0m") 
            else 
                run = false
                print("\27[0m" .. "Thank you for use us device.")
            end
        end
    },
    {
        name = "project-new",
        descript = "<none> | Create a new lövegame project",
        callback = function(_params)
            if #_params > 0 then 
                print("\27[1;91m" .. "The 'project-new' command haven't arguments." .. "\27[0m")
            else
                for _, dir in ipairs(template.dirs) do io.mkDir(dir) end
                for _, file in ipairs(template.files) do io.writeFile(file.name, file.content) end
                print("\27[0m" .. "Project created.")
            end
        end
    },
    {
        name = "project-load",
        descript = "<project_name> | Load a project to the lovegame path",
        callback = function(_params)
            if #_params <= 0 then
                print("\27[1;91m" .. "You need write the project name to load it." .. "\27[0m")
                return nil
            end
            local _projectName = "loveprojects/" .. _params[1]
            if #_params > 1 then
                print("\27[1;91m" .. "Many arguments to the command 'project-load'." .. "\27[0m")
            elseif not os.exists("loveprojects") then
                print("\27[1;91m" .. "Cannot access the 'loveprojects' path (no such directory)" .. "\27[0m") 
            elseif not os.exists(_projectName) then
                print("\27[1;91m" .. "The project '" .. _params[1] .. "' not exists." .. "\27[0m")
            else
                for _, dir in ipairs(os.getDirItems(_projectName)) do
                    os.rename(_projectName .. "/" .. dir, "../../" .. dir)
                end
                os.remove(_projectName) --when the path is empty we dont use it
                print("\27[0m" .. "Project loaded.")
            end
        end
    },
    {
        name = "project-save",
        descript = "<project_name> | Save the current project",
        callback = function(_params)
            if #_params <= 0 then
                print("\27[1;91m" .. "You need write the project name to save it" .. "\27[0m")
                return nil
            end
            local _projectName = "loveprojects/" .. _params[1]
            if #_params > 1 then
                print("\27[1;91m" .. "Many arguments to the 'project-save' command" .. "\27[0m")
            else
                if not os.exists("loveprojects") then io.mkDir("loveprojects") end
                if not os.exists(_projectName) then io.mkDir(_projectName) end
                for _, dir in ipairs(os.getDirItems(".")) do
                    if dir ~= "sugarplump.lua" then
                        os.rename(dir, _projectName .. dir)
                    end
                end
                print("\27[0m" .. "Project saved.")
            end
        end
    },
    {
        name = "project-rename",
        descript = "<project_name>, <project_newName> | It rename the path with the project",
        callback = function(_params)
            if #_params <= 0 then
                print("\27[1;91m" .. "You need write the project name to rename it" .. "\27[0m")
                return nil
            end
            local _projectName = "loveprojects" .. _params[1]
            local _newProjectName = "loveprojects" .. _params[2]
            if #_params > 2 then
                print("\27[1;91m" .. "Many arguments to the 'project-rename' command" .. "\27[0m")
            elseif not os.exists("loveprojects") then
                print("\27[1;91m" .. "Cannot access the 'loveprojects' path (no such directory)" .. "\27[0m") 
            elseif #_params == 1 then
                print("\27[1;91m" .. "You need write the new project name to rename it" .. "\27[0m")
            else
                if os.rename(_projectName, _newProjectName) then
                    print("\27[0m" .. "Project renamed.")
                else
                    print(te.patterns.dange .. "Cannot be rename the project." .. "\27[0m")
                end
            end
        end
    },
    {
        name = "project-remove",
        descript = "<project_name> | It remove the path with the project name",
        callback = function(_params)
            if #_params <= 0 then
                print("\27[1;91m" .. "You need write the project name" .. "\27[0m")
                return nil
            end
            local _projectName = "loveprojects/" .. _params[1]
            if #_params > 1 then 
                print("\27[1;91m" .. "Many arguments to the command 'project-remove'." .. "\27[0m")
            elseif not os.exists("loveprojects") then
                print("\27[1;91m" .. "Cannot access the 'loveprojects' path (no such directory)" .. "\27[0m") 
            elseif not os.exists(_projectName) then
                print("\27[1;91m" .. "The project '" .. _params[1] .. "' not exists." .. "\27[0m")
            else
                if os.remove(_projectName) then
                    print("\27[0m" .. "Project removed.")
                else
                    print(te.patterns.dange .. "Cannot be remove the project." .. "\27[0m")
                end
            end
        end
    },
    {
        name = "project-current-remove",
        descript = "<none> | Remove the current löveproject",
        callback = function(_params)
            if #_params > 0 then
                print("\27[1;91m" .. "The 'project-current-remove' command haven't arguments." .. "\27[0m")
            else
                for _, dir in ipairs(os.getDirItems(".")) do if dir ~= "sugarplump.lua" then os.remove(dir) end end
                print("\27[0m" .. "Project removed")
            end
        end
    }
}
--%booleans%--
run = true
--&introduction&--
print("\27[0m" .. "Welcome to Sugarplump - " .. "\27[36m" .. "löv" .. "\27[35m" .. "e2d" .. "\27[0m" .. " project manager")
cmdsList[1].callback({}) --call a list of commands
--&main loop&--
while run do
    local _inputStr = io.read() --get the user inpit
    local _token = string.split(_inputStr, "%s")
    table.remove(_token, 1) --remove the command name
    for _, cmd in ipairs(cmdsList) do
        if _inputStr == cmd.name then
            cmd.callback(_token)
            break
        elseif _ == #cmdsList then
            print("\27[1;91m" .. "This command not exists." .. "\27[0m")
        end
    end
end