-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Signals = require(RobloxSubscriptionPurchaseAppParent.Signals)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local UserProfiles = require(RobloxSubscriptionPurchaseAppParent.UserProfiles)

local function useReferrerName(num1: number?)
    local bool1 = not (num1 == nil) and num1 ~= 0

    local var1 = React.useMemo(function()
        if not (bool1 and num1) then
            return nil
        end
        return UserProfiles.Stores.UserProfileStore.get().fetchNamesByUserIds({ tostring(num1) })
    end, { bool1, num1 })

    local var2 = React.useMemo(function()
        if not var1 then
            return function(_)
                return nil
            end
        end
        return (Signals.createComputed(function(arg1)
            local var2 = var1(arg1)
            if not var2 or var2.status ~= "success" or not var2.data or #var2.data == 0 then
                return nil
            end
            local var3 = var2.data[1]
            local names = var3 and var3.names

            if names then
                return names.getDisplayName(arg1) or names.getUsername(arg1) or ""
            end

            return nil
        end))
    end, { var1 })

    return SignalsReact.useSignalState(var2)
end

return useReferrerName
