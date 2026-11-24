-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = { Free = "Free", RobloxSubscription = "RobloxSubscription" }

local tbl1 = { module.RobloxSubscription, module.Free }

local tbl2 = {
    robloxsubscription = module.RobloxSubscription,
    free = module.Free
}

function module.fromValue(arg1)
    if type(arg1) == "number" then
        return tbl1[arg1]
    elseif type(arg1) == "string" then
        return tbl2[string.lower(arg1)]
    end

    return nil
end

return module
