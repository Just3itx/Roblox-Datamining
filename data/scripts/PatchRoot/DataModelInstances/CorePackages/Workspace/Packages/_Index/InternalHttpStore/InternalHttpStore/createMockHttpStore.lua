-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Signals = require(scriptParentParent.Signals)

local _HttpStoreTypes = require(scriptParent.HttpStoreTypes)

local function createMockHttpStore()
    local tbl1 = ({})

    local function getOrCreateResponse(str1: string, config)
        if not tbl1[str1] then
            local get, set = Signals.createSignal({ status = "NotStarted", config = config })

            tbl1[str1] = { get = get, set = set }
        end
        return tbl1[str1]
    end

    return {
        fetch = function(str1: string?, config)
            local var1 = str1 or config.Url
            return getOrCreateResponse(var1, config).get, function() end
        end,
        cancelAll = function() end,
        setResponse = function(str1: string, arg1)
            if tbl1[str1] then
                tbl1[str1].set(arg1)
                return
            end
            local get, set = Signals.createSignal(arg1)
            tbl1[str1] = { get = get, set = set }
        end,
        reset = function()
            tbl1 = {}
        end
    }
end
return createMockHttpStore
