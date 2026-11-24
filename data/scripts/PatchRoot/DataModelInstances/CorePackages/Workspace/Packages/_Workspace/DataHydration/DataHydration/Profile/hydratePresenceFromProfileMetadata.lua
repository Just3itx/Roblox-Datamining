-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local PresenceStore = require(DataHydration.Presence.PresenceStore)
local normalizePresenceRawData = require(DataHydration.Presence.normalizePresenceRawData)

local function hydratePresenceFromProfileMetadata(str1: string, tbl1)
    local presence = tbl1 and tbl1.presence
    if presence == nil then
        return
    end

    local var1 = normalizePresenceRawData(presence, str1)
    if var1 == nil then
        return
    end

    PresenceStore.get().UpdateUserPresence(str1, var1, { isUpdatedRealtime = nil, isRealtimeUnknown = true })
end

return hydratePresenceFromProfileMetadata
