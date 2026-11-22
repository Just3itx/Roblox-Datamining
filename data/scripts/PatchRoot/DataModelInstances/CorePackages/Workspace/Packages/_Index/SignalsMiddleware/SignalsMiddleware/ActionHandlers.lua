-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SignalsExperimental = require(scriptParentParent.SignalsExperimental)

local module = {}

function module.create()
    return {}
end

function module.register(tbl1, str1: string, func1: (...any) -> (...any))
    if not tbl1[str1] then
        tbl1[str1] = {}
    end
    table.insert(tbl1[str1], func1)
end

function module.handleAction(tbl1, arg1)
    local var1 = tbl1[arg1.type]

    if not (var1 and #var1 > 0) then
        return
    end

    SignalsExperimental.batch(function()
        for _, value in var1 do
            value(arg1)
        end
    end)
end

return module
