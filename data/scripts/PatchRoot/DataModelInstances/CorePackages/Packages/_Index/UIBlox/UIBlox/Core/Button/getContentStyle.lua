-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ControlState = require(scriptParentParent.Control.Enum.ControlState)

return function(arg1, arg2, arg3)
    local var1 = arg1[arg2] or arg1[ControlState.Default]

    local tbl1 = {
        Color = arg3.Theme[var1].Color,
        Transparency = arg3.Theme[var1].Transparency
    }

    if arg2 == ControlState.Disabled or arg2 == ControlState.Pressed then
        tbl1.Transparency = 0.5 * tbl1.Transparency + 0.5
    end

    return tbl1
end
