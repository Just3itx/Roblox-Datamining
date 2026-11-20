-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)

local getFFlagDebugUGCValidationPrintNewStructureResults = require(scriptParentParent.flags.getFFlagDebugUGCValidationPrintNewStructureResults)

local getFFlagUGCValidationLogFailureInfo = require(scriptParentParent.flags.getFFlagUGCValidationLogFailureInfo)

local num1 = game:DefineFastInt("UGCValidationLogFailureLength", 100)

local function getRelativePath(_rootInstance, arg1): string
    if arg1 == nil or arg1 == _rootInstance then
        return ""
    end
    local var1 = _rootInstance:GetFullName() .. "."
    local fullName = arg1:GetFullName()
    assert(
        string.sub(fullName, 1, #var1) == var1,
        `instance {fullName} is not a descendant of root {_rootInstance:GetFullName()}`
    )
    return string.sub(fullName, #var1 + 1)
end

local module = {}
module.__index = module

function module.new(_testEnum: string, arg1)
    local self = setmetatable({}, module)
    self._testEnum = _testEnum
    self._status = ValidationEnums.Status.CANNOT_START
    self._telemetryContext = ""
    self._currentInstance = nil

    assert(arg1, "ValidationReporter.new requires sharedData")
    self._rootInstance = arg1.rootInstance
    self._failures = {}
    self._warnings = {}

    return self
end

function module:begin()
    self._startTime = os.clock()
    self._status = ValidationEnums.Status.IN_PROGRESS
end

function module:setReportingInstance(_currentInstance)
    self._currentInstance = _currentInstance
end

function module:setReportingRoot(_rootInstance)
    self._rootInstance = _rootInstance
end

function module:setTelemetryContext(_telemetryContext: string)
    self._telemetryContext = _telemetryContext
end

function module:fail(failureStringKey: string, failureStringParams, arg1)
    self._status = ValidationEnums.Status.FAIL
    table.insert(self._failures, {
        failureStringKey = failureStringKey,
        failureStringParams = failureStringParams or {},
        instancePath = getRelativePath(self._rootInstance, arg1 or self._currentInstance)
    })
end

function module:warn(failureStringKey: string, failureStringParams, arg1)
    table.insert(self._warnings, {
        failureStringKey = failureStringKey,
        failureStringParams = failureStringParams or {},
        instancePath = getRelativePath(self._rootInstance, arg1 or self._currentInstance)
    })
end

function module.forceError(_, message: string)
    error({ __forceError = true, message = message })
end

function module.fetchError(_, message: string)
    error({ __fetchError = true, message = message })
end

function module:err(_telemetryContext: string)
    if getFFlagDebugUGCValidationPrintNewStructureResults() then
        print("Reporting:", self._testEnum, "has error:", _telemetryContext)
    end
    self._status = ValidationEnums.Status.ERROR
    self._telemetryContext = _telemetryContext

    self._failures = {}
    self._warnings = {}
end

function module:complete()
    local duration = if self._startTime then 1000 * (os.clock() - self._startTime) else 0

    if self._status == ValidationEnums.Status.IN_PROGRESS then
        self._status = ValidationEnums.Status.PASS
    end

    if getFFlagDebugUGCValidationPrintNewStructureResults() and self._status ~= ValidationEnums.Status.PASS then
        print("Reporting:", self._testEnum, "has status", self._status, "in", duration)
    end

    if getFFlagUGCValidationLogFailureInfo() and self._status == ValidationEnums.Status.FAIL then
        for _, value in self._failures do
            self._telemetryContext ..= value.failureStringKey .. ";"
            if not value.failureStringParams then
                continue
            end

            for _, failureStringParam in value.failureStringParams do
                self._telemetryContext ..= tostring(failureStringParam) .. ";"
            end
        end

        self._telemetryContext = string.sub(self._telemetryContext, 1, num1)
    end

    return {
        validationEnum = self._testEnum,
        status = self._status,
        failures = self._failures,
        warnings = self._warnings,
        duration = duration,
        telemetryContext = self._telemetryContext
    }
end

return module
