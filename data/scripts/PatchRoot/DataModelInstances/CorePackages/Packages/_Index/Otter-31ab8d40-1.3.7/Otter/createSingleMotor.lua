-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local createSignal = require(scriptParentParent.Signal).createSignal

local AnimationStepSignal = require(script.Parent.AnimationStepSignal)

local _types = require(script.Parent.types)

local tbl1 = ({})
tbl1.__index = tbl1

local function createSingleMotor(value)
    local var1, var2 = createSignal()
    local var3, var4 = createSignal()

    local tbl2 = {
        __goal = nil,
        __state = { value = value, complete = true },
        __onComplete = var1,
        __fireOnComplete = var2,
        __onStep = var3,
        __fireOnStep = var4,
        __running = false
    }

    setmetatable(tbl2, tbl1)

    return tbl2
end

function tbl1:start()
    if self.__running then
        return
    end

    self.__connection = AnimationStepSignal:Connect(function(arg1)
        self:step(arg1)
    end)

    self.__running = true

    if not self.__goal or not self.__goal.startingValue then
        return
    end

    self.__state.value = self.__goal.startingValue
    if self.__state.initialValue then
        self.__state.initialValue = self.__goal.startingValue
    end
    self:step(0)
end

function tbl1:stop()
    if self.__connection ~= nil then
        self.__connection:Disconnect()
    end

    self.__running = false
end

function tbl1:step(num1: number)
    if self.__state.complete or self.__goal == nil then
        return
    end

    local var1 = self.__goal.step(self.__state, num1)

    if var1 ~= nil then
        self.__state = var1
    end

    self.__fireOnStep(self.__state.value)

    if self.__state.complete and self.__running then
        self:stop()
        self.__fireOnComplete(self.__state.value)
    end
end

function tbl1:setGoal(arg1)
    self.__goal = arg1
    self.__state.complete = false
    self:start()
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

return createSingleMotor
