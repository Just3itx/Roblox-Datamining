-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)
local HttpSessionTracker = require(scriptParentParent.HttpSessionTracker)
local _HttpStoreTypes = require(scriptParentParent.HttpStoreTypes)

local function createCancelRequestHandler(arg1)
    local var1 = HttpSessionTracker.currentSession()
    return Signals.createComputed(function(arg2)
        local var2 = arg1(arg2)
        return if var1 == HttpSessionTracker.currentSession() then var2 else {
            status = "Failed",
            config = var2.config,
            cancelled = true
        }
    end)
end
return createCancelRequestHandler
