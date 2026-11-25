-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)

local function useDataHydrationAccountGeneration()
    return SignalsReact.useSignalState(getSduiApiStore().getAccountGeneration)
end

return useDataHydrationAccountGeneration
