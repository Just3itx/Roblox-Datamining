-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent

local React = require(CurrencyTransfersParent.React)
local Signals = require(CurrencyTransfersParent.Signals)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)

local UserProfiles = require(CurrencyTransfersParent.UserProfiles)

local function useUserNameFromUserId(num1: number?)
    local var1 = num1 and num1 ~= 0

    local var2 = React.useMemo(function()
        if not (var1 and num1) then
            return nil
        end
        return UserProfiles.Stores.UserProfileStore.get().fetchNamesByUserIds({ tostring(num1) })
    end, { var1, num1 })

    local var3 = React.useMemo(function()
        if not var2 then
            return function(_)
                return nil
            end
        end
        return (Signals.createComputed(function(arg1)
            local var3 = var2(arg1)
            if not var3 or var3.status ~= "success" or not var3.data or #var3.data == 0 then
                return nil
            end
            local var4 = var3.data[1]
            local names = var4 and var4.names

            if names then
                return names.getDisplayName(false) or names.getUsername(false) or ""
            end

            return nil
        end))
    end, { var2 })

    return SignalsReact.useSignalState(var3)
end

return useUserNameFromUserId
