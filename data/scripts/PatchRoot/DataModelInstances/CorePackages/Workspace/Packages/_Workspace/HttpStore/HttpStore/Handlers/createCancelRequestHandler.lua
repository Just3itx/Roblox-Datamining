-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)
local HttpSessionTracker = require(scriptParentParent.HttpSessionTracker)
local _InternalHttpStore = require(scriptParentParentParent.InternalHttpStore)

local function createCancelRequestHandler(num1: number)
    return function(arg1)
        return Signals.createComputed(function(arg2)
            local var1 = arg1(arg2)
            return if num1 == HttpSessionTracker.currentSession() then var1 else {
                status = "Failed",
                config = var1.config,
                cancelled = true
            }
        end)
    end
end
return createCancelRequestHandler
