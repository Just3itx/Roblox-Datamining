-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local SduiListEntryNormalizer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryNormalizer)
local SduiListEntrySorter = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntrySorter)
local SduiListEntryRenderer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryRenderer)
local SduiPoolEntryHelpers = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPoolEntryHelpers)
local _SduiPoolStoreTypes = require(SduiCoreSystem.ClientBinding.SduiPoolStoreTypes)
local FFlagSduiPerSectionPoolSizing = require(SduiCoreSystemParent.SharedFlags).FFlagSduiPerSectionPoolSizing

local FFlagSduiComponentListReuseByEntryIndex = require(SduiCoreSystem.ClientBinding.PropBuilder.FFlagSduiComponentListReuseByEntryIndex)

local PropResultCategory = SduiClientBindingTypes.PropResultCategory

local function canSorterReorder(tbl1, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= nil then
        return true
    end
    for _, value in tbl1 do
        if value.sortRankProp ~= nil then
            return true
        end
    end
    return false
end

local function buildItemsFromEntries(tbl1, arg1, tbl2, arg2, arg3, arg4, arg5, arg6, arg7, bool1: boolean?, arg8, arg9)
    if tbl2 ~= nil and canSorterReorder(tbl1, arg1) then
        tbl2 = nil
    end

    tbl1 = SduiListEntrySorter.applyOrder(tbl1, arg1, arg7, arg3, arg2, arg4, arg6)

    local inputSlicer = nil
    local entryConfigExtrasFn = nil
    local var1 = SduiPoolEntryHelpers.computePoolSections(tbl1, if FFlagSduiPerSectionPoolSizing then arg9 else nil)

    if arg8 ~= nil or SduiPoolEntryHelpers.sectionsHaveMultiRow(var1) then
        local var2 = if arg8 == nil then nil else arg8(arg7)
        local poolEntryFns = SduiPoolEntryHelpers.createPoolEntryFns(var1, arg2, arg3, arg4, arg5, var2, arg9)

        inputSlicer = poolEntryFns.inputSlicer
        entryConfigExtrasFn = poolEntryFns.entryConfigExtrasFn
    end
    if inputSlicer == nil then
        inputSlicer = SduiListEntryRenderer.createInputSlicer(arg2, arg3, arg4, arg5)
    end

    return SduiListEntryRenderer.buildEntryConfigs(
        tbl1,
        inputSlicer,
        tbl2,
        arg4,
        arg5,
        arg6,
        arg3,
        arg7,
        bool1,
        entryConfigExtrasFn
    )
end

local function buildComponentList(_: string, arg1, arg2, arg3, arg4, arg5)
    local source = arg1 and arg1.source
    local defaultItem = arg1 and arg1.default_item
    local orderedIdentifiers = arg1 and arg1.ordered_identifiers
    local itemOverrides = arg1 and arg1.item_overrides
    local deferItemBuild = arg1 and arg1.defer_item_build

    if source == nil then
        local tbl1 = {
            message = "ComponentList missing source",
            name = arg4.debugName,
            componentType = arg4.currentComponentType,
            parserName = arg4.currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl1, arg4.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl1, arg4.appPage)
        return function()
            return {
                data = {}
            }
        end, PropResultCategory.PropSignal
    end

    local type = source.type
    local value = source.value

    local var1 = SduiListEntryRenderer.captureErrorContext(arg4)

    local poolConfig = arg1 and arg1.pool_config
    local var2 = SduiPoolEntryHelpers.resolvePoolDataGetter(poolConfig and poolConfig.pool_path, arg2, arg4, arg3)

    local poolEntryConfigs = SduiPoolEntryHelpers.buildPoolEntryConfigs(poolConfig)

    if type == "binding_path" then
        local var3 = nil
        return SduiPropUtils.generateDynamicBindingPropValue(value, arg2, arg4, arg3, function(arg6, arg7)
            local var4 = SduiListEntryNormalizer.normalizeBoundData(arg6, defaultItem, itemOverrides, arg4)

            local var5, var6 = buildItemsFromEntries(
                var4,
                orderedIdentifiers,
                var3,
                arg3,
                arg2,
                arg4,
                var1,
                arg5,
                arg7,
                deferItemBuild,
                var2,
                poolEntryConfigs
            )
            if not FFlagSduiComponentListReuseByEntryIndex then
                var3 = var5

                return var5
            end

            local tbl1 = ({})
            for value2, value3 in var6 do
                tbl1[value3] = var5[value2]
            end
            var3 = tbl1
            return var5
        end), PropResultCategory.PropSignal
    elseif type == "literal" then
        local items = value and value.items
        if items == nil then
            return function()
                return {
                    data = {}
                }
            end, PropResultCategory.PropSignal
        end

        return function(arg6)
            local success, result = pcall(function()
                local var3 = SduiListEntryNormalizer.normalizeLiteralItems(items, defaultItem, arg4)

                return (buildItemsFromEntries(
                    var3,
                    orderedIdentifiers,
                    nil,
                    arg3,
                    arg2,
                    arg4,
                    var1,
                    arg5,
                    arg6,
                    deferItemBuild,
                    var2,
                    poolEntryConfigs
                ))
            end)

            if success then
                return { data = result }
            end

            local tbl1 = {
                message = `Failed to build ComponentList from literal source: {SduiParseHelpers.stringifyValue(result)}`,
                name = var1.name,
                componentType = var1.componentType,
                parserName = var1.parserName
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl1, var1.nodeContext)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl1, var1.appPage)

            return {
                data = {}
            }
        end, PropResultCategory.PropSignal
    else
        if type == "pool" then
            return Signals.createComputed(function(arg6)
                local success, result = pcall(function()
                    local _section = (arg3(arg6) or {})._section
                    if typeof(_section) ~= "table" then
                        return {}
                    end
                    local cells = _section.cells
                    if typeof(cells) ~= "function" then
                        return {}
                    end
                    local var3 = cells(arg6)
                    if #var3 == 0 then
                        return {}
                    end

                    local tbl1 = {}
                    local tbl2 = table.create(#var3, 0)
                    for value2, value3 in var3 do
                        if value3.item ~= nil then
                            table.insert(tbl1, value3.item)
                            tbl2[value2] = #tbl1
                        end
                    end

                    local var4 = SduiListEntryNormalizer.normalizeBoundData(tbl1, defaultItem, itemOverrides, arg4)
                    local var5, var6 = buildItemsFromEntries(var4, orderedIdentifiers, nil, arg3, arg2, arg4, var1, arg5, arg6, deferItemBuild, nil, nil)

                    if #var5 ~= #tbl1 then
                        local tbl3 = {
                            message = `Pool-backed ComponentList dropped {#tbl1 - #var5} of {#tbl1} items;` .. " pool templates must resolve to valid templates and must not use is_component_filtered",
                            name = var1.name,
                            componentType = var1.componentType,
                            parserName = var1.parserName
                        }
                        if FFlagSduiErrorPaths then
                            addSduiErrorContextFields(tbl3, var1.nodeContext)
                        end
                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl3, var1.appPage)
                    end

                    local tbl3 = ({})
                    for value2, value3 in var6 do
                        tbl3[value3] = var5[value2]
                    end

                    local result = {}
                    for value2, value3 in var3 do
                        local var7 = tbl2[value2]
                        if var7 == 0 then
                            table.insert(result, { isBlank = true })
                        else
                            local var8 = tbl3[var7]
                            if var8 ~= nil then
                                var8.realIndex = value3.realIndex
                                var8.spanOverride = value3.spanOverride
                                table.insert(result, var8)
                            end
                        end
                    end
                    return result
                end)
                if success then
                    return { data = result }
                end

                local tbl1 = {
                    message = `Failed to build ComponentList from pool source: {SduiParseHelpers.stringifyValue(result)}`,
                    name = var1.name,
                    componentType = var1.componentType,
                    parserName = var1.parserName
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl1, var1.nodeContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl1, var1.appPage)

                return {
                    data = {}
                }
            end), PropResultCategory.PropSignal
        end
        error(`Unknown ComponentList source kind: {type}`)
    end
end
return buildComponentList
