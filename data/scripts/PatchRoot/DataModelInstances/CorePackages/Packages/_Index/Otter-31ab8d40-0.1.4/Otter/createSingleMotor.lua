-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local createSignal = require(script.Parent.createSignal)

local tbl1 = {
    prototype = {}
}
tbl1.__index = tbl1.prototype

local function createSingleMotor(value: number)
    assert(typeof(value) == "number")

    local tbl2 = {
        __goal = nil,
        __state = { value = value, complete = true },
        __onComplete = createSignal(),
        __onStep = createSignal(),
        __running = false
    }

    setmetatable(tbl2, tbl1)

    return tbl2
end

function tbl1.prototype:start()
    if self.__running then
        return
    end

    self.__connection = RunService.Heartbeat:Connect(function(deltaTime: number)
        self:step(deltaTime)
    end)

    self.__running = true
end

function tbl1.prototype:stop()
    if self.__connection ~= nil then
        self.__connection:Disconnect()
    end

    self.__running = false
end

function tbl1.prototype:step(num1: number)
    assert(typeof(num1) == "number")

    if self.__state.complete or self.__goal == nil then
        return
    end

    local var1 = self.__goal:step(self.__state, num1)

    if var1 ~= nil then
        self.__state = var1
    end

    self.__onStep:fire(self.__state.value)

    if self.__state.complete and self.__running then
        self:stop()
        self.__onComplete:fire(self.__state.value)
    end
end

function tbl1.prototype:setGoal(arg1)
    self.__goal = arg1
    self.__state.complete = false
    self:start()
end

function tbl1.prototype:onStep(arg1)
    assert(typeof(arg1) == "function")

    return self.__onStep:subscribe(arg1)
end

function tbl1.prototype:onComplete(arg1)
    assert(typeof(arg1) == "function")

    return self.__onComplete:subscribe(arg1)
end

function tbl1.prototype.destroy(arg1)
    arg1:stop()
end

return createSingleMotor
