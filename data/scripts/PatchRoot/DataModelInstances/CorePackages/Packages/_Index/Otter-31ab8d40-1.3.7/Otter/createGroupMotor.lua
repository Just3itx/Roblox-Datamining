-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Object = require(scriptParentParent.Collections).Object
local createSignal = require(scriptParentParent.Signal).createSignal

local AnimationStepSignal = require(script.Parent.AnimationStepSignal)

local _types = require(script.Parent.types)

local tbl1 = ({})
tbl1.__index = tbl1

local function createGroupMotor(tbl2)
    local tbl3 = ({})

    for k, value in pairs(tbl2) do
        tbl3[k] = { value = value, complete = true }
    end

    local var1, var2 = createSignal()
    local var3, var4 = createSignal()

    local tbl4 = {
        __goals = {},
        __states = tbl3,
        __allComplete = true,
        __onComplete = var1,
        __fireOnComplete = var2,
        __onStep = var3,
        __fireOnStep = var4,
        __running = false
    }

    setmetatable(tbl4, tbl1)

    return tbl4
end

function tbl1:start(bool1: boolean)
    if self.__running then
        return
    end

    self.__connection = AnimationStepSignal:Connect(function(arg1)
        self:step(arg1)
    end)

    self.__running = true

    if bool1 then
        self:step(0)
    end
end

function tbl1:stop()
    if self.__connection ~= nil then
        self.__connection:Disconnect()
        self.__running = false
    end
end

function tbl1:step(num1: number)
    if self.__allComplete then
        return
    end

    local bool1 = true
    local tbl2 = ({})

    for k, value in pairs(self.__states) do
        if not value.complete then
            local __goal = self.__goals[k]

            if __goal ~= nil then
                local var1 = __goal.step(value, num1)

                if var1 ~= nil then
                    self.__states[k] = var1
                    value = var1
                end
            else
                value.complete = true
            end

            if not value.complete then
                bool1 = false
            end
        end

        tbl2[k] = value.value
    end

    local __allComplete = self.__allComplete
    self.__allComplete = bool1

    self.__fireOnStep(tbl2)

    if self.__allComplete and not __allComplete and self.__running then
        self:stop()
        self.__fireOnComplete(tbl2)
    end
end

function tbl1:setGoal(tbl2)
    self.__goals = Object.assign({}, self.__goals, tbl2)

    local bool1 = false
    local tbl3 = ({})
    for k, value in pairs(tbl2) do
        local var1 = self.__states[k]
        if value.startingValue then
            bool1 = true
            var1.value = value.startingValue
            if var1.initialValue then
                var1.initialValue = value.startingValue
            end
        end
        tbl3[k] = var1.value

        if var1 == nil then
            error(("Cannot set goal for the value %s because it doesn't exist"):format(tostring(k)), 2)
        end

        var1.complete = false
    end

    self.__allComplete = false
    self:start(bool1)
end

function tbl1:onStep(arg1)
    local var1 = self.__onStep:subscribe(arg1)

    return function()
        var1:unsubscribe()
    end
end

function tbl1:onComplete(arg1)
    local var1 = self.__onComplete:subscribe(arg1)

    return function()
        var1:unsubscribe()
    end
end

function tbl1.destroy(arg1)
    arg1:stop()
end

return createGroupMotor
