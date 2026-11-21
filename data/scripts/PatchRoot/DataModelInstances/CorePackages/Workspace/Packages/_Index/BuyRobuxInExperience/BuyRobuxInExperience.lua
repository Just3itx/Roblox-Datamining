-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local BuyRobuxRouting = require(scriptParent.BuyRobuxRouting)

local module = {}

function module.openBuyRobux(arg1, callback: (...any) -> (...any), str1: string)
    BuyRobuxRouting.logBuyRobuxRoutingCallsite(str1)
    local var1 = BuyRobuxRouting.resolveAndLogDestination(arg1)
    if var1.kind == "web" then
        callback(var1.url)
        return
    end

    callback(BuyRobuxRouting.fallbackWebUrl(arg1))
end

module["jest.config"] = script["jest.config"]
return module
