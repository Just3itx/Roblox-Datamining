-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")

local axisMap = require(ViewRecyclerRoblox.RobloxAdapter.axisMap)

local module = {}

function module.attach(tbl1)
    local instance = tbl1.instance
    local axis = tbl1.axis
    local getState = tbl1.getState
    local onItemMeasured = tbl1.onItemMeasured
    local isRendered = tbl1.isRendered

    local tbl2 = ({})
    local var1 = nil
    local var2 = nil
    local tbl3 = ({})

    local function publish(arg1): boolean
        if isRendered ~= nil and not isRendered() then
            return false
        end
        local absoluteSize = instance.AbsoluteSize
        if axisMap.crossOf(absoluteSize, axis) <= 0 then
            return true
        end

        local var3 = axisMap.mainOf(instance.AbsoluteSize, axis)

        if var1 ~= arg1 or var2 ~= var3 then
            onItemMeasured(arg1, var3)
            var1 = arg1
            var2 = var3
        end
        return true
    end

    local function func1()
        local state = getState()
        if state == nil or tbl3[state] ~= nil then
            return
        end

        local connection = nil
        connection = RunService.Heartbeat:Once(function()
            tbl2[connection] = nil
            if tbl3[state] == connection then
                tbl3[state] = nil
            end

            local state2 = getState()
            if state2 ~= state then
                return
            end
            if not publish(state2) then
                func1()
            end
        end)
        tbl2[connection] = true
        tbl3[state] = connection
    end

    local connection = instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(func1)

    return {
        scheduleSettle = func1,
        measureNow = function()
            local state = getState()
            if state ~= nil then
                publish(state)
            end
        end,
        getPendingCount = function(): number
            local num1 = 0
            for _ in tbl2 do
                num1 += 1
            end
            return num1
        end,
        disconnect = function()
            connection:Disconnect()
            for value in tbl2 do
                value:Disconnect()
            end
            table.clear(tbl2)
            table.clear(tbl3)
        end
    }
end
return module
