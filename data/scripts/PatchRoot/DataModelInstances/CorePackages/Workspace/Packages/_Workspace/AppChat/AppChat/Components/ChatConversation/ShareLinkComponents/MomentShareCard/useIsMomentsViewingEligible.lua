-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local SharedFlags = require(AppChatParent.SharedFlags)
local SignalsReact = require(AppChatParent.SignalsReact)

local FFlagEnableArgus = SharedFlags.FFlagEnableArgus

local GetMomentsCapabilities = require(AppChatParent.MomentsCommon.GetMomentsCapabilities)

local function useIsMomentsViewingEligible()
    local var1 = SignalsReact.useSignalState(GetMomentsCapabilities(false).getHasMomentsAccess)

    return FFlagEnableArgus and var1
end

return useIsMomentsViewingEligible
