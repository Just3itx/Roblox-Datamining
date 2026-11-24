-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Initiated = "Initiated",
    Pending = "Pending",
    Cancelled = "Cancelled",
    Failed = "Failed",
    Completed = "Completed"
}

local tbl1 = {
    [0] = module.Initiated,
    [1] = module.Pending,
    [2] = module.Cancelled,
    [3] = module.Failed,
    [4] = module.Completed
}

function module.fromValue(arg1)
    if arg1 == nil then
        return nil
    end

    if type(arg1) == "number" then
        return tbl1[arg1]
    end

    if type(arg1) == "string" then
        for _, value in pairs(module) do
            if value == arg1 then
                return arg1
            end
        end
    end

    return nil
end

return module
