-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local SignalsReact = require(WhatsNewParent.SignalsReact)
local _Types = require(WhatsNew.Types)
local GetWhatsNewStore = require(WhatsNew.store.GetWhatsNewStore)

local function useWhatsNewRuntimeState()
    local whatsNewStore = GetWhatsNewStore()
    return SignalsReact.useSignalState(whatsNewStore.getRuntimeStateSignal)
end

return useWhatsNewRuntimeState
