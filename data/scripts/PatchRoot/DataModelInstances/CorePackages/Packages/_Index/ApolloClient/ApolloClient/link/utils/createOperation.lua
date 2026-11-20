-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local _types = require(script.Parent.Parent.core.types)

function module.createOperation(arg1, arg2)
    local var1 = Object.assign({}, arg1)
    return (setmetatable(arg2, {
        __index = {
            setContext = function(_, arg3)
                if typeof(arg3) == "function" then
                    var1 = Object.assign({}, var1, arg3(var1))
                    return
                end
                var1 = Object.assign({}, var1, arg3)
            end,
            getContext = function(_)
                return Object.assign({}, var1)
            end
        }
    }))
end

return module
