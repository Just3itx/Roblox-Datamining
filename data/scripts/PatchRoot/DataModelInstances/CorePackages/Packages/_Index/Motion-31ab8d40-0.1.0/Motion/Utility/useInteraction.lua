-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)

local function useInteraction(callback: (...any) -> (...any))
    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState(false)

    return {
        onInputBegan = function(_, arg1)
            if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
                var2(true)
            end
        end,
        onInputEnded = function(_, arg1)
            if arg1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end

            if var1 and var3 then
                callback()
            end
            var2(false)
        end,
        onMouseEnter = function()
            var4(true)
        end,
        onMouseLeave = function()
            var4(false)
            var2(false)
        end
    }, var1, var3
end

return useInteraction
