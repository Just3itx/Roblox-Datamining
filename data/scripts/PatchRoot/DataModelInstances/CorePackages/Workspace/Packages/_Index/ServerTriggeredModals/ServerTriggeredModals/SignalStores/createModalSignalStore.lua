-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local Signals = require(ServerTriggeredModalsParent.Signals)
local _ServerDrivenUi = require(ServerTriggeredModalsParent.ServerDrivenUi)
local _EntryPoint = require(ServerTriggeredModals.EntryPoint)

return function()
    local tbl1 = ({})

    local function getOrCreateEntry(arg1)
        local tbl2 = tbl1[arg1]
        if tbl2 == nil then
            local get, set = Signals.createSignal(nil)
            local var1, var2 = Signals.createSignal(false)
            local var3, var4 = Signals.createSignal(false)
            tbl2 = {
                metadata = { get = get, set = set },
                hasShown = { get = var1, set = var2 },
                primaryHandlerClaimed = { get = var3, set = var4 }
            }

            tbl1[arg1] = tbl2
        end
        return tbl2
    end

    return {
        getMetadataGetter = function(arg1)
            return getOrCreateEntry(arg1).metadata.get
        end,
        setMetadata = function(arg1, tbl2)
            getOrCreateEntry(arg1).metadata.set(tbl2)
        end,
        getHasShownGetter = function(arg1)
            return getOrCreateEntry(arg1).hasShown.get
        end,
        setHasShown = function(arg1, bool1: boolean)
            getOrCreateEntry(arg1).hasShown.set(bool1)
        end,
        getPrimaryHandlerClaimedGetter = function(arg1)
            return getOrCreateEntry(arg1).primaryHandlerClaimed.get
        end,
        tryClaimPrimaryHandler = function(arg1): boolean
            local orCreateEntry = getOrCreateEntry(arg1)
            if orCreateEntry.primaryHandlerClaimed.get() then
                return false
            end
            orCreateEntry.primaryHandlerClaimed.set(true)
            return true
        end,
        releasePrimaryHandler = function(arg1)
            getOrCreateEntry(arg1).primaryHandlerClaimed.set(false)
        end
    }
end
