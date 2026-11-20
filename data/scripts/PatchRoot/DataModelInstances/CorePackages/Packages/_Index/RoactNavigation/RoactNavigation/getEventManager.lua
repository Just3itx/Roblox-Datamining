-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getEventManager(arg1)
    local tbl1 = ({})

    local function removeListener(arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl1[arg2]
        local var2 = if var1 then var1[arg1] else nil

        if not var2 then
            return
        end

        local var3 = table.find(var2, arg3)
        table.remove(var2, var3)
    end

    return {
        addListener = function(arg2, arg3)
            tbl1[arg2] = tbl1[arg2] or {}
            tbl1[arg2][arg1] = tbl1[arg2][arg1] or {}

            table.insert(tbl1[arg2][arg1], arg3)

            return {
                remove = function()
                    removeListener(arg2, arg3)
                end
            }
        end,
        emit = function(arg2, arg3)
            local var1 = tbl1[arg2] or {}
            local var2 = if var1[arg1] then table.clone(var1[arg1]) else nil

            if not var2 then
                return
            end

            for _, value in var2 do
                value(arg3)
            end
        end
    }
end

return getEventManager
