-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local Actions = script.Parent.Parent.Actions
local SetLuauHeapState = require(Actions.SetLuauHeapState)
local SetLuauHeapProfileTarget = require(Actions.SetLuauHeapProfileTarget)
local SetLuauHeapActiveSnapshot = require(Actions.SetLuauHeapActiveSnapshot)
local SetLuauHeapCompareSnapshot = require(Actions.SetLuauHeapCompareSnapshot)
local _LuauHeapTypes = require(script.Parent.Parent.Components.LuauHeap.LuauHeapTypes)

local tbl1 = {
    isClientView = true,
    client = {
        snapshots = {},
        active = 0,
        compare = 0
    },
    server = {
        snapshots = {},
        active = 0,
        compare = 0
    }
}

return function(tbl2, tbl3)
    local var1 = tbl2 or tbl1

    if tbl3.type == SetLuauHeapState.name then
        local var2 = tbl3.isClientState and {
            client = tbl3.sessionState
        } or {
            server = tbl3.sessionState
        }
        return (Immutable.JoinDictionaries(var1, var2))
    elseif tbl3.type == SetLuauHeapProfileTarget.name then
        return Immutable.JoinDictionaries(var1, { isClientView = tbl3.isClientView })
    elseif tbl3.type == SetLuauHeapActiveSnapshot.name then
        if var1.isClientView then
            local client = table.clone(var1.client)
            client.active = tbl3.active
            return Immutable.JoinDictionaries(var1, { client = client })
        end

        local server = table.clone(var1.server)
        server.active = tbl3.active
        return Immutable.JoinDictionaries(var1, { server = server })
    elseif tbl3.type == SetLuauHeapCompareSnapshot.name then
        if var1.isClientView then
            local client = table.clone(var1.client)
            client.compare = tbl3.compare
            return Immutable.JoinDictionaries(var1, { client = client })
        end

        local server = table.clone(var1.server)
        server.compare = tbl3.compare
        return Immutable.JoinDictionaries(var1, { server = server })
    else
        return var1
    end
end
