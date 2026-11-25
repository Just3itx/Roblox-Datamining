-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local var1 = require(ProfilePlatform.Stores.GetInspectAvatarTooltipStore)(false)

local function useInspectAvatarTooltip()
    local showTooltip = useSignalState(var1.getIsOpen)

    React.useEffect(function()
        var1.tryShow()

        return function()
            var1.hide()
        end
    end, {})

    return {
        showTooltip = showTooltip,
        onDismiss = var1.permanentlyDismiss
    }
end

return useInspectAvatarTooltip
