-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Signals = require(scriptParentParent.Signals)
local _HttpSignals = require(scriptParentParent.HttpSignals)

local _HttpStoreTypes = require(scriptParent.HttpStoreTypes)

local function createParsedResponse(arg1, config)
    return Signals.createComputed(function(arg2)
        local var1 = arg1(arg2)
        if var1.status == "success" then
            local data = var1.data
            return { status = "Success", config = config, response = data }
        end
        if var1.status ~= "error" then
            return { status = "Fetching", config = config }
        end

        local error = var1.error
        return { status = "Failed", config = config, response = error }
    end)
end

return createParsedResponse
