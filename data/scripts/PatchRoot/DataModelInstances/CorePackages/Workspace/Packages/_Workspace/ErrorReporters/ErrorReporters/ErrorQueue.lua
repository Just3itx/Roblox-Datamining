-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local RunService = game:GetService("RunService")

local Cryo = require(scriptParentParent.Cryo)
local t = require(scriptParentParent.t)

local module = {}
module.__index = module

local var1 = t.tuple(
    t.callback,
    t.optional(
        t.strictInterface({
            queueTimeLimit = t.optional(t.numberPositive),
            queueErrorLimit = t.optional(t.numberPositive),
            queueKeyLimit = t.optional(t.numberPositive),
            flushImmediately = t.optional(t.boolean)
        })
    )
)
function module.new(_reportMethod: (...any) -> (...any), tbl1)
    assert(var1(_reportMethod, tbl1))

    local tbl2 = tbl1 or {}

    local tbl3 = {
        _reportMethod = _reportMethod,
        _queueTimeLimit = tbl2.queueTimeLimit or 30,
        _queueErrorLimit = tbl2.queueErrorLimit or 30,
        _queueKeyLimit = tbl2.queueKeyLimit or 10,
        _flushImmediately = tbl2.flushImmediately == true,
        _errors = {},
        _totalErrorCount = 0,
        _totalKeyCount = 0,
        _runningTime = 0,
        _renderSteppedConnection = nil
    }

    setmetatable(tbl3, module)

    return tbl3
end

function module:hasError(str1: string): boolean
    return type(str1) == "string" and str1 ~= "" and self._errors[str1] ~= nil
end

function module:addError(str1: string, arg1)
    if type(str1) ~= "string" or str1 == "" then
        return
    end

    if not self._errors[str1] then
        self._errors[str1] = { data = arg1, count = 1 }

        self._totalKeyCount += 1
    else
        self._errors[str1].count = self._errors[str1].count + 1
    end

    self._totalErrorCount += 1

    if self:isReadyToReport() then
        self:reportAllErrors()
    end
end

function module:isReadyToReport(): boolean
    return self._totalKeyCount >= self._queueKeyLimit
        or self._totalErrorCount >= self._queueErrorLimit
        or self._totalErrorCount > 0 and self._runningTime >= self._queueTimeLimit
end

function module:reportAllErrors()
    local var2 = Cryo.Dictionary.join(self._errors, {})

    self._errors = {}
    self._totalErrorCount = 0
    self._totalKeyCount = 0
    self._runningTime = 0

    for k, value in pairs(var2) do
        self._reportMethod(k, value.data, value.count)
    end
end

function module:_onRenderStep(num1: number)
    self._runningTime += num1

    if self:isReadyToReport() then
        self:reportAllErrors()
    end
end

function module:startTimer()
    if self._renderSteppedConnection == nil then
        self._runningTime = if self._flushImmediately then self._queueTimeLimit else 0

        self._renderSteppedConnection = RunService.renderStepped:Connect(function(arg1)
            self:_onRenderStep(arg1)
        end)
    end
end

function module:stopTimer()
    if self._renderSteppedConnection ~= nil then
        self._renderSteppedConnection:Disconnect()
        self._runningTime = 0
        self._renderSteppedConnection = nil
    end
end

return module
