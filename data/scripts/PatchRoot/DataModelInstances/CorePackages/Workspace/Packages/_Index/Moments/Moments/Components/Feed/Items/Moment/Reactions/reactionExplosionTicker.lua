-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local function createTicker(tbl1)
    local stepSignal = if tbl1 == nil then nil else tbl1.stepSignal
    local clock = (if tbl1 == nil then nil else tbl1.clock) or os.clock

    local tbl2 = {}
    local connection = nil

    local function step(num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = num1 or clock()

        for _, value in table.clone(tbl2) do
            value(var1)
        end
    end

    local function connectIfNeeded() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil or #tbl2 == 0 then
            return
        end
        connection = (stepSignal or RunService.PreRender):Connect(function()
            step(false)
        end)
    end

    local function disconnectIfEmpty() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil and #tbl2 == 0 then
            connection:Disconnect()
            connection = nil
        end
    end

    return {
        add = function(func1: (...any) -> (...any))
            table.insert(tbl2, func1)
            connectIfNeeded()
            local bool1 = false
            return function()
                if bool1 then
                    return
                end
                bool1 = true
                local var1 = table.find(tbl2, func1)
                if var1 ~= nil then
                    table.remove(tbl2, var1)
                end

                disconnectIfEmpty()
            end
        end,
        step = step,
        getActiveCount = function(): number
            return #tbl2
        end,
        isConnected = function(): boolean
            return connection ~= nil
        end
    }
end

return {
    createTicker = createTicker,
    shared = createTicker()
}
