-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createSignal()
    local tbl1 = ({})
    local tbl2 = ({})
    local bool1 = false

    return {
        subscribe = function(_, callback)
            assert(typeof(callback) == "function", "Can only subscribe to signals with a function.")

            local tbl3 = { callback = callback, disconnected = false }

            if bool1 and not tbl1[callback] then
                tbl2[callback] = tbl3
            end

            tbl1[callback] = tbl3

            local function disconnect()
                assert(not tbl3.disconnected, "Listeners can only be disconnected once.")

                tbl3.disconnected = true
                tbl1[callback] = nil
                tbl2[callback] = nil
            end

            return disconnect
        end,
        fire = function(_, ...)
            bool1 = true
            for k, value in pairs(tbl1) do
                if not (value.disconnected or tbl2[k]) then
                    k(...)
                end
            end

            bool1 = false

            for k, _ in pairs(tbl2) do
                tbl2[k] = nil
            end
        end
    }
end

return createSignal
