-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)
local class = require(scriptParent.class)
local format = require(scriptParent.format)
local join = require(scriptParent.join)

local var1 = class("Error", function(name: string, message: string, tags)
    return {
        name = name,
        message = message or "An error occurred",
        tags = tags or {}
    }
end)

function var1.toString(arg1)
    return format("{}: {}\n{}", arg1.name, format(arg1.message, arg1.tags), arg1.stack)
end

function var1.joinTags(arg1, arg2)
    return var1.new(arg1.name, arg1.message, join(arg1.tags, arg2 or {}))
end

function var1.throw(arg1, arg2)
    local var2 = arg1:joinTags(arg2)
    var2.stack = debug.traceback()
    error(var2)
end

return var1
