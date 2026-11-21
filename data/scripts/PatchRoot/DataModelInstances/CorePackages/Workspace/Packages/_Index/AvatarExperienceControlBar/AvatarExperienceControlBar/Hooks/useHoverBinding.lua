-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)

local function useHoverBinding()
    local var1, var2 = React.useBinding(false)

    return var1, (React.useCallback(function(arg1)
        if arg1 == Foundation.Enums.ControlState.Default then
            var2(false)
        elseif arg1 == Foundation.Enums.ControlState.Hover then
            var2(true)
        end
    end, {}))
end

return useHoverBinding
