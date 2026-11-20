-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function addToMap(tbl1, callback, tbl2: {callback: any, disconnected: boolean}) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})

    for k, value in pairs(tbl1) do
        result[k] = value
    end

    result[callback] = tbl2

    return result
end

local function removeFromMap(tbl1, callback) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})

    for k, value in pairs(tbl1) do
        if k ~= callback then
            result[k] = value
        end
    end

    return result
end

local function createSignal()
    local tbl1 = {}

    return {
        subscribe = function(_, callback)
            assert(typeof(callback) == "function", "Can only subscribe to signals with a function.")

            local tbl2 = { callback = callback, disconnected = false }

            tbl1 = addToMap(tbl1, callback, tbl2)

            local function disconnect()
                assert(not tbl2.disconnected, "Listeners can only be disconnected once.")

                tbl2.disconnected = true
                tbl1 = removeFromMap(tbl1, callback)
            end

            return disconnect
        end,
        fire = function(_, ...)
            for k, value in pairs(tbl1) do
                if not value.disconnected then
                    k(...)
                end
            end
        end
    }
end

return createSignal
