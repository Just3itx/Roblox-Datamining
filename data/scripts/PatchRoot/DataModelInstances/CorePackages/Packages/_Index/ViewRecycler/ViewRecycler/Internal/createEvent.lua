-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createEvent()
    local tbl1 = {}

    return {
        fire = function(...)
            for _, value in tbl1 do
                value(...)
            end
        end,
        connect = function(callback)
            local bool1 = true
            local function func1(...)
                if bool1 then
                    callback(...)
                end
            end
            local var1 = table.clone(tbl1)
            table.insert(var1, func1)
            tbl1 = var1
            return function()
                bool1 = false
                local var2 = table.find(tbl1, func1)
                if var2 ~= nil then
                    local var3 = table.clone(tbl1)
                    table.remove(var3, var2)
                    tbl1 = var3
                end
            end
        end
    }
end

return createEvent
