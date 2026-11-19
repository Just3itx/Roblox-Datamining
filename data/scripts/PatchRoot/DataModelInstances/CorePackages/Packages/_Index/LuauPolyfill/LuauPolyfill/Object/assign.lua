-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:51:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.None)
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1, arg2, arg3, arg4, ...)
    if arg2 ~= nil and typeof(arg2) == "table" then
        for k, value in pairs(arg2) do
            if value == None then
                arg1[k] = nil
            else
                arg1[k] = value
            end
        end
    end

    if arg3 ~= nil and typeof(arg3) == "table" then
        for k, value in pairs(arg3) do
            if value == None then
                arg1[k] = nil
            else
                arg1[k] = value
            end
        end
    end

    if arg4 ~= nil and typeof(arg4) == "table" then
        for k, value in pairs(arg4) do
            if value == None then
                arg1[k] = nil
            else
                arg1[k] = value
            end
        end
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)

        if var1 == nil or typeof(var1) ~= "table" then
            continue
        end

        for k, value in pairs(var1) do
            if value == None then
                arg1[k] = nil
            else
                arg1[k] = value
            end
        end
    end

    return arg1
end
