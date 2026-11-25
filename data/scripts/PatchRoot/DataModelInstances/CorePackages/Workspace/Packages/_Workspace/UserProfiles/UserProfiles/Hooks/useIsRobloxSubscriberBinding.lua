-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

local React = require(UserProfilesParent.React)
local SignalsReact = require(UserProfilesParent.SignalsReact)

local createIsRobloxSubscriberGetter = require(script.Parent.createIsRobloxSubscriberGetter)

local function useIsRobloxSubscriberBinding(str1: string?)
    local var1 = React.useMemo(function()
        return createIsRobloxSubscriberGetter(str1)
    end, { str1 })

    return SignalsReact.useSignalBinding(var1)
end

return useIsRobloxSubscriberBinding
