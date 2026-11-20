-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local _ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local SignalsExperimental = require(ViewRecyclerRoblox.Parent.SignalsExperimental)
local axisMap = require(ViewRecyclerRoblox.RobloxAdapter.axisMap)
local RunService = game:GetService("RunService")

local module = {}

local function disconnectAll(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    for _, value in tbl1 do
        value:Disconnect()
    end
    table.clear(tbl1)
end

function module.new(tbl1)
    local axis = tbl1.axis
    local activationMargin = tbl1.activationMargin or 0
    local var1 = tbl1.retentionMargin or activationMargin
    assert(activationMargin >= 0, "activationMargin must be non-negative")
    assert(activationMargin <= var1, "retentionMargin must be at least activationMargin")

    local var2 = nil
    local tbl2 = {}
    local tbl3 = ({})
    local tbl4 = ({})
    local connection = nil
    local bool1 = false

    local function updateTargetGeometry(tbl5)
        local var3 = var2
        if var3 == nil or not tbl5.target:IsDescendantOf(var3) then
            tbl5.contentStart = nil
            tbl5.contentEnd = nil
            return
        end
        local var4 = axisMap.mainOf(var3.CanvasPosition, axis)
        local var5 = axisMap.mainOf(var3.AbsolutePosition, axis)

        local contentStart = var4 + axisMap.mainOf(tbl5.target.AbsolutePosition, axis) - var5

        tbl5.contentStart = contentStart
        tbl5.contentEnd = contentStart + axisMap.mainOf(tbl5.target.AbsoluteSize, axis)
    end

    local function dispatch(tbl5, tbl6) -- Luacid: Inlined by compiler; 4 call sites recovered
        if tbl5 == nil and tbl6 == nil then
            return
        end
        SignalsExperimental.batch(function()
            if tbl5 ~= nil then
                for _, value in tbl5 do
                    value.setActive(false)
                end
            end
            if tbl6 == nil then
                return
            end

            for _, value in tbl6 do
                value.setActive(true)
            end
        end)
    end

    local function deactivateAll()
        local var3 = nil
        for _, value in tbl3 do
            if value.active then
                value.active = false
                var3 = var3 or {}
                table.insert(var3, value)
            end
        end

        dispatch(var3, nil)
    end

    local function evaluate()
        if bool1 then
            return
        end

        local var3 = var2
        if var3 == nil then
            deactivateAll()
            return
        end

        local var4 = axisMap.mainOf(var3.CanvasPosition, axis)
        local var5 = var4 + axisMap.mainOf(var3.AbsoluteWindowSize, axis)
        local var6 = nil
        local var7 = nil

        for _, value in tbl3 do
            local contentStart = value.contentStart
            local contentEnd = value.contentEnd
            local bool2

            if contentStart == nil or contentEnd == nil then
                bool2 = false
            else
                local var8 = if value.active then var1 else activationMargin

                if var4 - var8 < contentEnd then
                    bool2 = contentStart < var5 + var8
                else
                    bool2 = false
                end
            end
            if bool2 == value.active then
                continue
            end

            value.active = bool2
            if bool2 then
                var7 = var7 or {}
                table.insert(var7, value)
            else
                var6 = var6 or {}
                table.insert(var6, value)
            end
        end

        dispatch(var6, var7)
    end

    local function scheduleSettledEvaluation(tbl5) -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        if tbl5 ~= nil then
            tbl4[tbl5] = true
        end
        if connection ~= nil then
            return
        end
        connection = RunService.Heartbeat:Connect(function()
            local var3 = connection
            connection = nil
            if var3 ~= nil then
                var3:Disconnect()
            end
            if bool1 then
                return
            end
            for value in tbl4 do
                tbl4[value] = nil
                if tbl3[value.target] == value then
                    updateTargetGeometry(value)
                end
            end
            evaluate()
        end)
    end

    local function func1(arg1)
        if bool1 or arg1 == var2 then
            return
        end

        disconnectAll(tbl2)
        deactivateAll()
        var2 = arg1
        if arg1 == nil then
            return
        end

        table.insert(tbl2, arg1:GetPropertyChangedSignal("CanvasPosition"):Connect(evaluate))
        table.insert(tbl2, arg1:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(scheduleSettledEvaluation))

        local tbl5 = tbl2
        local destroying = arg1.Destroying

        table.insert(tbl5, destroying:Connect(function()
            func1(nil)
        end))

        for _, value in tbl3 do
            updateTargetGeometry(value)
        end
        evaluate()
    end

    return {
        setViewport = func1,
        register = function(target, setActive: (...any) -> (...any))
            if bool1 then
                return function() end
            end
            assert(tbl3[target] == nil, "target is already registered")

            local tbl5 = {
                target = target,
                setActive = setActive,
                active = false,
                contentStart = nil,
                contentEnd = nil,
                connections = {}
            }
            tbl3[target] = tbl5

            local bool2 = false
            local function unregister()
                if bool2 then
                    return
                end
                bool2 = true
                if tbl3[target] ~= tbl5 then
                    return
                end
                tbl3[target] = nil
                disconnectAll(tbl5.connections)
                if not tbl5.active then
                    return
                end

                tbl5.active = false
                dispatch({ tbl5 }, nil)
            end
            local function updateGeometry()
                scheduleSettledEvaluation(tbl5)
            end
            table.insert(tbl5.connections, target:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateGeometry))
            table.insert(tbl5.connections, target:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateGeometry))
            table.insert(tbl5.connections, target.Destroying:Connect(unregister))
            updateTargetGeometry(tbl5)
            evaluate()
            return unregister
        end,
        destroy = function()
            if bool1 then
                return
            end
            bool1 = true
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
            table.clear(tbl4)
            disconnectAll(tbl2)

            local var3 = nil
            for value, value2 in tbl3 do
                tbl3[value] = nil
                disconnectAll(value2.connections)

                if value2.active then
                    value2.active = false
                    var3 = var3 or {}
                    table.insert(var3, value2)
                end
            end
            var2 = nil
            dispatch(var3, nil)
        end
    }
end
return module
