-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)
local UserProfile = require(ShareSheetParent.DataHydration.UserProfile)

local signal = Signals.createSignal(nil)

return {
    useUserInfo = function(str1: string?)
        local var1 = React.useMemo(function()
            if str1 == nil then
                return nil
            end

            return UserProfile.getAndFetchUserInfo(str1)
        end, { str1 or "" })

        local var2 = SignalsReact.useSignalState(if var1 ~= nil then var1.info else signal)
        local var3 = SignalsReact.useSignalState(if var1 ~= nil then var1.status else signal)

        if str1 == nil then
            return nil
        end

        return {
            displayName = if var2 == nil then "" else var2.displayName,
            username = if var2 == nil then "" else var2.username,
            isLoading = var3 == "NotReady"
        }
    end
}
