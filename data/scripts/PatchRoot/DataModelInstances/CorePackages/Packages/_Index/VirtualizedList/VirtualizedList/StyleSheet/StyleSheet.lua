-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local module = {}
function module.compose(arg1, arg2)
    return if arg1 == nil or arg2 == nil then if arg1 == nil then arg2 else arg1 else { arg1, arg2 }
end

function module.create(arg1)
    if _G.__DEV__ then
        Array.forEach(Object.keys(arg1), function(arg2)
            if arg1[arg2] then
                Object.freeze(arg1[arg2])
            end
        end)
    end
    return arg1
end
return module
