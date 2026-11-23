-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)

local AnimatedVisibilityContext = require(script.Parent.AnimatedVisibilityContext)

local function useAnimatedVisibility()
    local var1 = React.useContext(AnimatedVisibilityContext)

    if var1 then
        return var1
    end

    warn("useAnimatedVisibility must be used within a AnimatedVisibilityProvider")
    return nil
end

return useAnimatedVisibility
