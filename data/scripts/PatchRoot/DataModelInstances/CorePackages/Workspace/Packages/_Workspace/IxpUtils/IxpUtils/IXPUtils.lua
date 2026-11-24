-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local scriptParentParent = script.Parent.Parent

local ArgCheck = require(scriptParentParent.ArgCheck)
local Symbol = require(scriptParentParent.AppCommonLib).Symbol
local Dash = require(scriptParentParent.Dash)
local React = require(scriptParentParent.React)
local RoactAppExperiment = require(scriptParentParent.RoactAppExperiment)
local useUserExperiment = RoactAppExperiment.useUserExperiment
local ExperimentCacheManager = require(scriptParentParent.ExperimentCacheManager).ExperimentCacheManager
local FFlagAXLegacyIXPExposureLogging = require(scriptParentParent.SharedFlags).FFlagAXLegacyIXPExposureLogging

local var1 = require(scriptParentParent.AppDebug).LogTree.logger("ax.ixp")

local NO_VALUE = Symbol.named("NO_VALUE")

local ixpService = IXPService
local connectUserLayer = RoactAppExperiment.connectUserLayer
local default = ExperimentCacheManager.default

local module = {}

function module.defineIXPTest(tbl1)
    local module2 = {
        name = tbl1.name,
        layer = tbl1.layer,
        recordExposure = if tbl1.recordExposure then tbl1.recordExposure else false,
        logExposureEnabled = if FFlagAXLegacyIXPExposureLogging then tbl1.logExposureEnabled else nil,
        getIsUserInExperiment = tbl1.getIsUserInExperiment,
        isEnabled = 0,
        isEnabledForAll = 0
    }
    function module2.isEnabled()
        return tbl1.getDependentFlagsEnabled() and (tbl1.getEnabledFlag() or tbl1.getEnabledForAllFlag())
    end

    function module2.isEnabledForAll()
        return tbl1.getDependentFlagsEnabled() and tbl1.getEnabledForAllFlag()
    end

    var1:info(
        "[Define IXP Test] {}, layer: {}, isEnabled: {}, isEnabledForAll: {}",
        module2.name,
        module2.layer,
        module2.isEnabled(),
        module2.isEnabledForAll()
    )

    for name, mapLayerToValue in tbl1.variables do
        module2[name] = {
            name = name,
            ixpTest = module2,
            mapLayerToValue = mapLayerToValue,
            lastValue = NO_VALUE
        }
    end

    return module2
end

local function readLayerVariablesForTest(arg1)
    arg1.usedExperimentCacheManager = arg1.usedExperimentCacheManager or ixpService:GetUserStatusForLayer(arg1.layer) ~= Enum.IXPLoadingStatus.Initialized

    return (if arg1.usedExperimentCacheManager then default:getLayerVariables(arg1.layer) else ixpService:GetUserLayerVariables(arg1.layer))
        or {}
end

local function mapTestVariable(tbl1, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local ixpTest = tbl1.ixpTest
    arg1 = arg1 or readLayerVariablesForTest(ixpTest)

    local lastValue = tbl1.mapLayerToValue(arg1, ixpTest.isEnabledForAll())
    if lastValue ~= tbl1.lastValue then
        var1:info("[Read IXP Variable] {} {} = {}", ixpTest.name, tbl1.name, lastValue)
        tbl1.lastValue = lastValue
    end
    return lastValue
end

local function accessLayer(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1.usedExperimentCacheManager then nil else arg2[arg1.layer]
end

local function doConnectTestVariables(tbl1, tbl2, bool1: boolean)
    return connectUserLayer(tbl2, function(arg1)
        local result = ({})
        for value, value2 in tbl1 do
            local ixpTest = value2.ixpTest
            if ixpTest.isEnabled() then
                local var2 = accessLayer(ixpTest, arg1)
                result[value] = mapTestVariable(value2, var2)
            end
        end
        return result
    end, bool1)
end

function module.connectTestVariables(tbl1)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = ({})
    local tbl5 = ({})

    for value, value2 in tbl1 do
        local ixpTest = value2.ixpTest
        if ixpTest.recordExposure then
            tbl3[ixpTest.layer] = true
            tbl5[value] = value2
        else
            tbl2[ixpTest.layer] = true
            tbl4[value] = value2
        end
    end

    local tbl6 = {}

    local var2 = Dash.keys(tbl2)
    if #var2 > 0 then
        table.sort(var2)
        table.insert(tbl6, doConnectTestVariables(tbl4, var2, false))
    end

    local var3 = Dash.keys(tbl3)
    if #var3 > 0 then
        table.sort(var3)
        table.insert(tbl6, doConnectTestVariables(tbl5, var3, true))
    end

    return Dash.pipe(table.unpack(tbl6))
end

function module.useTestVariables(...)
    local tbl1 = { ... }
    local ixpTest = nil
    for _, value in tbl1 do
        if ixpTest then
            ArgCheck.assert(
                value.ixpTest == ixpTest,
                "All test variables passed to IXPUtils.useTestVariables must belong to same IXP test."
            )
        else
            ixpTest = value.ixpTest
        end
    end

    return useUserExperiment({ ixpTest.layer }, function(arg1)
        local var2 = accessLayer(ixpTest, arg1)

        local tbl2 = ({})
        for value, value2 in tbl1 do
            if ixpTest.isEnabled() then
                tbl2[value] = mapTestVariable(value2, var2)
            end
        end

        return table.unpack(tbl2)
    end, ixpTest.recordExposure)
end

local function readTestVariableImpl(func1: (...any) -> (...any), tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local ixpTest = func1.ixpTest

    if not ixpTest.isEnabled() then
        return nil
    end

    local var2 = if tbl1 then tbl1[ixpTest.layer] else nil
    return (mapTestVariable(func1, var2))
end

function module.readTestVariable(func1: (...any) -> (...any))
    if not func1.ixpTest.isEnabled() then
        return nil
    end

    return mapTestVariable(func1, nil)
end

function module.getFromLayers(tbl1, func1: (...any) -> (...any))
    return readTestVariableImpl(func1, tbl1)
end

function module.logExposure(arg1)
    var1:debug("LogUserLayerExposure: {}", arg1.layer)
    ixpService:LogUserLayerExposure(arg1.layer)
end

function module.logLayerExposure(layerName: string)
    var1:debug("LogLayerExposure: {}", layerName)
    ixpService:LogUserLayerExposure(layerName)
end

function module.logExperimentExposure(arg1): boolean
    var1:debug("LogExperimentExposure: {}", arg1.layer)
    if not (arg1.isEnabled() and arg1.getIsUserInExperiment and arg1.getIsUserInExperiment((readLayerVariablesForTest(arg1)))) then
        return false
    end

    ixpService:LogUserLayerExposure(arg1.layer)
    return true
end

function module.useLogExposureOnce(arg1)
    local var2 = React.useRef(false)

    return React.useCallback(function()
        if not var2.current then
            module.logExposure(arg1)
            var2.current = true
        end
    end, { arg1.layer })
end

function module.setMocksForTesting(arg1, arg2, arg3)
    ixpService = arg1 or ixpService
    connectUserLayer = arg2 or connectUserLayer
    default = arg3 or default
end

function module.restoreDefaultsAfterTesting()
    ixpService = IXPService
    connectUserLayer = RoactAppExperiment.connectUserLayer
    default = ExperimentCacheManager.default
end

return module
