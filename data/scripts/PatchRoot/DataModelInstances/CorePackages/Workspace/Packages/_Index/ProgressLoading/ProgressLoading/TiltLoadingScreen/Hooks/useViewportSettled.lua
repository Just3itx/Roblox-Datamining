-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreenParentParent = script:FindFirstAncestor("TiltLoadingScreen").Parent.Parent

local React = require(TiltLoadingScreenParentParent.React)

local function useViewportSettled(vector2: Vector2)
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        var2(false)
        local var3 = task.delay(0.1, function()
            var2(true)
        end)
        return function()
            pcall(task.cancel, var3)
        end
    end, { vector2.X, vector2.Y })

    return var1
end

return useViewportSettled
