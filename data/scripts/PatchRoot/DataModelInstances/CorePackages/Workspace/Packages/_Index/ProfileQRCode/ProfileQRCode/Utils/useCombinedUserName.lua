-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent

local React = require(ProfileQRCodeParent.React)
local Signals = require(ProfileQRCodeParent.Signals)
local SignalsReact = require(ProfileQRCodeParent.SignalsReact)
local var1 = require(ProfileQRCodeParent.UserProfiles).Stores.UserProfileStore.get()

return function(str1: string)
    local var2 = React.useMemo(function()
        if str1 == "" then
            return function(): string
                return ""
            end
        end

        return Signals.createComputed(function(arg1)
            local var2 = var1.fetchNamesByUserIds({ str1 })(arg1)
            local var3 = var2 and var2.data and var2.data[1]
            local names = var3 and var3.names

            if names then
                return names.getCombinedName(arg1) or ""
            end

            return ""
        end)
    end, { str1 })

    return SignalsReact.useSignalState(var2) or ""
end
