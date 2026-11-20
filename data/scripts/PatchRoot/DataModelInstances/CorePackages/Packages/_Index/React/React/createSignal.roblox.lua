-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function fireConnections(tbl1, ...)
    for value, value2 in tbl1 do
        if not value2.disconnected then
            value(...)
        end
    end
    return nil
end

return if require(script.Parent.Parent.Shared).ReactFeatureFlags.enableReentrantSafeSignals then function() -- name: createReentrantSafeSignal
    local tbl1 = ({})
    local tbl2 = ({})
    local num1 = 0

    local function subscribe(callback)
        assert(typeof(callback) == "function", "Can only subscribe to signals with a function.")

        local tbl3 = { callback = callback, disconnected = false }

        if num1 > 0 and tbl1[callback] == nil then
            tbl2[callback] = tbl3
        else
            tbl1[callback] = tbl3
        end

        local function disconnect()
            assert(not tbl3.disconnected, "Listeners can only be disconnected once.")

            tbl3.disconnected = true
            if tbl1[callback] == tbl3 then
                tbl1[callback] = nil
            end
            if tbl2[callback] == tbl3 then
                tbl2[callback] = nil
            end
        end

        return disconnect
    end

    local function fire(...)
        num1 += 1

        local success, result = pcall(fireConnections, tbl1, ...)
        num1 -= 1

        if num1 == 0 and next(tbl2) ~= nil then
            for value, value2 in tbl2 do
                tbl1[value] = value2
            end
            table.clear(tbl2)
        end

        if not success then
            error(result, 0)
        end
    end

    return subscribe, fire
end else function() -- name: createSignal
    local tbl1 = ({})
    local tbl2 = ({})
    local bool1 = false

    local function subscribe(callback)
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
    end

    local function fire(...)
        bool1 = true
        for value, value2 in tbl1 do
            if not (value2.disconnected or tbl2[value]) then
                value(...)
            end
        end

        bool1 = false

        table.clear(tbl2)
    end

    return subscribe, fire
end
