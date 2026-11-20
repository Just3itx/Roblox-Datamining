-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)
local ValidationModuleLoader = require(scriptParentParent.validationSystem.ValidationModuleLoader)
local FetchAllDesiredData = require(scriptParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)
local ValidationReporter = require(scriptParentParent.validationSystem.ValidationReporter)

local getFFlagDebugUGCValidationPrintNewStructureResults = require(scriptParentParent.flags.getFFlagDebugUGCValidationPrintNewStructureResults)
local getFFlagUGCValidationFetchErrorMethod = require(scriptParentParent.flags.getFFlagUGCValidationFetchErrorMethod)
local ValidationConstants = require(scriptParentParent.validationSystem.ValidationConstants)
local ErrorSourceStrings = require(scriptParentParent.validationSystem.ErrorSourceStrings)
local TelemetryService = game:GetService("TelemetryService")
game:DefineFastInt("SingleValidationTelemetryThrottleHundrethsPercent", 10000)

local config = {
    eventName = "UgcSingleValidationFinished",
    backends = { "EventIngest" },
    throttlingPercentage = game:GetFastInt("SingleValidationTelemetryThrottleHundrethsPercent"),
    lastUpdated = { 25, 9, 24 },
    description = "Report single ugc validation result to EventIngest backend.",
    links = "https://create.roblox.com/docs/art/validation-errors"
}

local function reportSingleResult(validationEnum: string, arg1, status: string, additionalInfo: string, durationMs: number)
    local customFields = {
        validationJobId = arg1.jobId,
        validationSource = arg1.consumerConfig.source,
        validationEnum = validationEnum,
        status = status,
        durationMs = durationMs,
        additional_info = additionalInfo
    }

    TelemetryService:LogEvent(config, { customFields = customFields })
end

local function getMissingData(arg1, tbl1)
    local missingData = {}
    for _, value in tbl1 do
        if arg1[value] == nil or arg1[value] == FetchAllDesiredData.DATA_FETCH_FAILURE then
            table.insert(missingData, value)
        end
    end

    return missingData
end

local function complete(validationEnum: string, arg1, arg2) -- Luacid: Inlined by compiler; 7 call sites recovered
    local var1 = arg2:complete()
    reportSingleResult(validationEnum, arg1, var1.status, var1.telemetryContext, var1.duration)
    return var1
end

local function ValidationTestWrapper(validationEnum: string, arg1, tbl1)
    local validationModule = ValidationModuleLoader.getValidationModule(validationEnum)
    local validationReporter = ValidationReporter.new(validationEnum, arg1)

    for _, prereqTest in validationModule.prereqTests do
        if tbl1[prereqTest] ~= ValidationEnums.Status.PASS then
            return complete(validationEnum, arg1, validationReporter)
        end
    end

    local missingData = getMissingData(arg1, validationModule.requiredData)
    if #missingData > 0 then
        validationReporter:err(`Missing required data: {table.concat(missingData, ", ")}`)
        return complete(validationEnum, arg1, validationReporter)
    end

    if validationModule.isAssetQualityModule then
        local var1 = arg1.aqsSummaryData[validationEnum]

        if var1 and var1.Error then
            local bool1 = false
            for _, value in var1.Error do
                if validationModule.knownAqsUserErrors[value] ~= nil then
                    validationReporter:fail(validationModule.knownAqsUserErrors[value])
                else
                    if table.find(ValidationConstants.AQSInternalErrorEnum, value) == nil or bool1 ~= false then
                        validationReporter:err(`Unexpected error enum {value}`)
                        return complete(validationEnum, arg1, validationReporter)
                    end

                    validationReporter:fail(ErrorSourceStrings.Keys.AQSInternalError)
                    bool1 = true
                end
            end

            return complete(validationEnum, arg1, validationReporter)
        end
    end

    validationReporter:begin()
    if #getMissingData(arg1, validationModule.conditionalData) > 0 then
        return complete(validationEnum, arg1, validationReporter)
    end

    local success, result = pcall(function()
        validationModule.run(validationReporter, arg1)
    end)

    if not success then
        if type(result) == "table" and result.__forceError then
            error(result.message, 0)
        end

        if getFFlagUGCValidationFetchErrorMethod() and type(result) == "table" and result.__fetchError then
            local var1 = validationModule.shadowFlag() and not validationModule.fflag()
            if arg1.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend and not var1 then
                error(result.message, 0)
            end
            validationReporter:err(result.message)
            return complete(validationEnum, arg1, validationReporter)
        end

        if getFFlagDebugUGCValidationPrintNewStructureResults() then
            print("Validation error:", result)
            print("As this is in debug mode, we will re-call the function for a full error trace: ")
            validationModule.run(validationReporter, arg1)
        end
        validationReporter:err(result)
    end

    return complete(validationEnum, arg1, validationReporter)
end

return ValidationTestWrapper
