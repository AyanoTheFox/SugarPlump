function os.exists(_data)
    if os.rename(_data, _data) then return true 
    else return false end
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

function os.gGetDirItems(_dir) 
    local t = {}
    if os.exists(_dir) then
        for _, child in ipairs(os.getDirItems(_dir)) do
            os.gGetDirItems(_dir .. '/' .. child)
            table.insert(t, _dir .. "/" .. child)
        end
    end
    return t
end

-- function os.capture(_cmd, _raw)
--     local _f = assert(io.popen(_cmd, 'r'))
--     local _s = assert(_f:read('*a'))
--     _f:close()
--     
--     if _raw then return _s else
--         _s = string.gsub(_s, '^%s+', '')
--         _s = string.gsub(_s, '%s+$', '')
--         _s = string.gsub(_s, '[\n\r]+', ' ')
--         return _s
--     end
-- end

function os.getCurrentOs()
    local _bin = package.cpath:match("%p[\\|/]?%p(%a+)")
    if _bin == 'dll' then return 'windows'
    elseif _bin == 'so' then return 'linux'
    elseif _bin == 'dylib' then return 'macOS'
    else return 'unknow' end
end

return os