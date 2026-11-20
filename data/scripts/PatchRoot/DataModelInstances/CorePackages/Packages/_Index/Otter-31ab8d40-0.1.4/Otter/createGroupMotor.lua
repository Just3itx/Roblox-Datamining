-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local assign = require(script.Parent.assign)
local createSignal = require(script.Parent.createSignal)

local tbl1 = {
    prototype = {}
}
tbl1.__index = tbl1.prototype

local function createGroupMotor(arg1)
    assert(typeof(arg1) == "table")

    local tbl2 = ({})

    for k, value in pairs(arg1) do
        tbl2[k] = { value = value, complete = true }
    end

    local tbl3 = {
        __goals = {},
        __states = tbl2,
        __allComplete = true,
        __onComplete = createSignal(),
        __onStep = createSignal(),
        __running = false
    }

    setmetatable(tbl3, tbl1)

    return tbl3
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
        self.__running = false
    end
end

function tbl1.prototype:step(num1: number)
    assert(typeof(num1) == "number")

    if self.__allComplete then
        return
    end

    local bool1 = true
    local tbl2 = ({})

    for k, value in pairs(self.__states) do
        if not value.complete then
            local __goal = self.__goals[k]

            if __goal ~= nil then
                local var1 = __goal:step(value, num1)

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

    self.__onStep:fire(tbl2)

    if self.__allComplete and not __allComplete and self.__running then
        self:stop()
        self.__onComplete:fire(tbl2)
    end
end

function tbl1.prototype:setGoal(arg1)
    assert(typeof(arg1) == "table")

    self.__goals = assign({}, self.__goals, arg1)

    for k in pairs(arg1) do
        local var1 = self.__states[k]

        if var1 == nil then
            error(("Cannot set goal for the value %s because it doesn't exist"):format(tostring(k)), 2)
        end

        var1.complete = false
    end

    self.__allComplete = false
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

return createGroupMotor
