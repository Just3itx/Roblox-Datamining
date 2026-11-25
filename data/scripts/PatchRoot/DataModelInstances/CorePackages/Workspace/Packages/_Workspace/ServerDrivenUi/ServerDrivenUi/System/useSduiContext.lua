-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)

local CollectionItemSize = require(ServerDrivenUiParent.CollectionViews).CollectionViewTypes.CollectionItemSize
local Signals = require(ServerDrivenUiParent.Signals)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiComponentDefinitions = require(ServerDrivenUi.System.SduiComponentDefinitions)
local SduiInstrumentation = SduiCoreSystem.SduiInstrumentation
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiTemplateRegistry = SduiCoreSystem.SduiTemplateRegistry
local SduiUsageRecorder = SduiCoreSystem.SduiUsageRecorder
local recordV1RegisteredTemplates = SduiCoreSystem.recordV1RegisteredTemplates
local useSduiDataStore = require(ServerDrivenUi.DataStore.useSduiDataStore)
local SduiErrors = SduiCoreSystem.SduiErrors

local FFlagLuaAppLayoutParamsInContext = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppLayoutParamsInContext

local tbl1 = {
    numColumns = 3,
    fractionalItemAmount = 0,
    columnGap = 24,
    sideMargin = 24,
    verticalPadding = 16
}

local useSduiDependencies = require(ServerDrivenUi.System.useSduiDependencies)

local function useSduiContext(tbl2)
    local var1 = React.useMemo(function()
        return SduiInstrumentation.new()
    end, {})
    var1:startTimerFlow("useSduiContext")

    local dependencies = useSduiDependencies(var1)

    local componentDefinitions = React.useMemo(function()
        return tbl2.componentDefinitions or SduiComponentDefinitions.new()
    end, { tbl2.componentDefinitions })

    local templateRegistry = React.useMemo(function()
        return SduiTemplateRegistry.new(tbl2.templates)
    end, { tbl2.templates })
    React.useEffect(function()
        recordV1RegisteredTemplates(tbl2.appPage, tbl2.templates)
        SduiUsageRecorder.scheduleFlush()
    end, { tbl2.appPage, tbl2.templates })

    local dataStore = useSduiDataStore()

    local var6 = nil
    if FFlagLuaAppLayoutParamsInContext then
        local var7 = React.useMemo(function()
            return Signals.createSignal(tbl1)
        end, {})

        var6 = React.useCallback(function(arg1)
            return Signals.createComputed(function(arg2)
                if tbl2.pageLayoutConfig then
                    return (tbl2.pageLayoutConfig[arg1] or tbl2.pageLayoutConfig[CollectionItemSize.Small])(arg2)
                end
                SduiLogger.reportError(
                    SduiErrors.SduiErrorType.NoPageLayoutConfig,
                    {
                        message = `No page layout config available for {tbl2.appPage}, returning default config`
                    },
                    tbl2.appPage
                )
                return (var7(arg2))
            end)
        end, { tbl2.pageLayoutConfig })
    end

    local useMemo = React.useMemo
    local function func1()
        local tbl3 = {
            dependencies = dependencies,
            appPage = tbl2.appPage,
            dataUpdatedTimestamp = tbl2.dataUpdatedTimestamp,
            componentDefinitions = componentDefinitions,
            templateRegistry = templateRegistry,
            dataStore = dataStore,
            getPageLayoutConfig = if FFlagLuaAppLayoutParamsInContext then var6 else nil
        }

        setmetatable(tbl3, {
            __tostring = function(): string
                return "SduiContext"
            end
        })
        return tbl3
    end

    local appPage = tbl2.appPage
    local dataUpdatedTimestamp = tbl2.dataUpdatedTimestamp
    local var7 = if FFlagLuaAppLayoutParamsInContext then var6 else nil
    local var8 = useMemo(func1, { dependencies, appPage, dataUpdatedTimestamp, componentDefinitions, templateRegistry, dataStore, var7 })

    var1:stopTimerFlow("useSduiContext", var8)
    return var8
end

return useSduiContext
