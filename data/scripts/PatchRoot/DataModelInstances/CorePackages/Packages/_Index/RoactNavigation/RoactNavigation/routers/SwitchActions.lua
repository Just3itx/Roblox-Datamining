-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object
local var1 = require(script.Parent.Parent.NavigationSymbol)("JUMP_TO")

local module = { JumpTo = var1 }

setmetatable(module, {
    __index = function(_, arg1)
        error(("%q is not a valid member of SwitchActions"):format(tostring(arg1)), 2)
    end
})

function module.jumpTo(arg1)
    local tbl1 = { type = var1, preserveFocus = true }
    if arg1 then
        return (Object.assign(tbl1, arg1))
    end

    return tbl1
end

return module
