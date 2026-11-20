-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createSignal(arg1)
    local tbl1 = ({})
    local tbl2 = ({})

    local getValue = arg1
    local bool1 = false

    local function fire(arg2)
        getValue = arg2
        bool1 = true
        for value, value2 in tbl1 do
            if not (value2.unsubscribed or tbl2[value]) then
                value(arg2)
            end
        end

        bool1 = false
        for value, value2 in tbl2 do
            tbl1[value] = value2
        end
        table.clear(tbl2)
    end

    return {
        subscribe = function(_, callback)
            local tbl3 = { callback = callback, unsubscribed = false }

            if bool1 and not tbl1[callback] then
                tbl2[callback] = tbl3
            else
                tbl1[callback] = tbl3
            end

            return {
                unsubscribe = function(_)
                    tbl3.unsubscribed = true
                    tbl1[callback] = nil
                    tbl2[callback] = nil
                end
            }
        end,
        getValue = function(_)
            return getValue
        end
    }, fire
end

return createSignal
