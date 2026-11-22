-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local createSignal = require(scriptParentParent.Signals).createSignal

local _types = require(script.Parent.types)

local HttpService = game:GetService("HttpService")

local function fetch(options)
    local var1, var2 = createSignal(function()
        return { status = "pending" }
    end)

    local var3 = HttpService:RequestInternal(options)

    var3:Start(function(bool1: boolean, error)
        if bool1 then
            var2({ status = "success", data = error })
            return
        end
        var2({ status = "error", error = error })
    end)

    local function cancelRequest()
        var3:Cancel()
    end

    return var1, cancelRequest
end

return fetch
