-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local createCurrentTimeSignal = require(AppChatParent.SignalsUtils).createCurrentTimeSignal

local getUserSendEligibilityStatus = require(AppChat.Utils.getUserSendEligibilityStatus)

local function areResultsEqual(tbl1, tbl2): boolean
    return tbl1.isEligible == tbl2.isEligible and tbl1.isLoading == tbl2.isLoading
end

local function useExternalChatUserEligibility(tbl1)
    local var1 = React.useMemo(function()
        return createCurrentTimeSignal(1)
    end, {})

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(scope)
            if not tbl1.isActive then
                return { isEligible = false, isLoading = true }
            end

            local userSendEligibilityStatus = getUserSendEligibilityStatus({ currentTimestamp = var1(scope), isAvailable = true, scope = scope })

            return {
                isEligible = userSendEligibilityStatus == "eligible",
                isLoading = userSendEligibilityStatus == "loading"
            }
        end, areResultsEqual)
    end, { var1, tbl1.isActive })

    return SignalsReact.useSignalState(var2)
end

return useExternalChatUserEligibility
