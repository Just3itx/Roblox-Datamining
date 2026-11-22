-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)
local GreenlistedEndpointsForLogging = require(scriptParentParentParent.Http).Logger.GreenlistedEndpointsForLogging
local _HttpStoreTypes = require(scriptParentParent.HttpStoreTypes)

local function createGrafanaLoggingHandler(arg1)
    return Signals.createEffect(function(arg2)
        local var1 = arg1(arg2)
        if var1.status == "Success" then
            GreenlistedEndpointsForLogging.sendStatusCodeCounter(var1.config.Url, var1.response.StatusCode)
        end
    end)
end

return createGrafanaLoggingHandler
