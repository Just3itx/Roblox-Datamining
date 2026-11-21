-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Signal, var2 = require(scriptParentParentParent.Signals).createSignal("")

local module = {}

function module.Get(_)
    local var3 = Signal(false)
    if var3 == "" then
        var3 = HttpService:GenerateGUID(false)
        var2(var3)
    end
    return var3
end

function module.Refresh(_)
    local str1 = HttpService:GenerateGUID(false)
    var2(str1)
    return str1
end

function module.GetSignal(_)
    return Signal
end

return module
