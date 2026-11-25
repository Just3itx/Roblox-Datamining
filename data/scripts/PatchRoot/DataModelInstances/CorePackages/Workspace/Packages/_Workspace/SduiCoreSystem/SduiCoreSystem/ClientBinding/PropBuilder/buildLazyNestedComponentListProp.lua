-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Cryo = require(SduiCoreSystemParent.Cryo)
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
local Signals = require(SduiCoreSystemParent.Signals)

local buildInputsForNestedComponent = require(SduiCoreSystem.ClientBinding.PropBuilder.buildInputsForNestedComponent)
local buildComponentList = require(SduiCoreSystem.ClientBinding.PropBuilder.buildComponentList)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local buildConfigForComponent = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder).buildConfigForComponent
local _SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local PropResultCategory = SduiClientBindingTypes.PropResultCategory
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local splitDottedPath = require(SduiCoreSystem.ClientBinding.splitDottedPath)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local tbl1 = {}

local function buildItemList(arg1, tbl2, inputs, arg2, arg3, arg4, tbl3, arg5, arg6, bool1: boolean?, str1: string?)
    local itemList = {}
    for value, value2 in tbl2 do
        local var1 = if FFlagSduiErrorPaths then str1 else nil
        local inlineComponent, bool2

        if value2 and value2.inline_component ~= nil then
            inlineComponent = value2.inline_component
            bool2 = true
            if FFlagSduiErrorPaths then
                var1 = nil
            end
        elseif value2 and value2.roblox_component and value2.roblox_component ~= "" then
            if FFlagSduiErrorPaths then
                local templateForRobloxComponent = arg3.getTemplateForRobloxComponent(value2.roblox_component)
                if templateForRobloxComponent then
                    var1 = value2.roblox_component
                else
                    var1 = str1
                end

                inlineComponent = templateForRobloxComponent or arg1
            else
                inlineComponent = arg3.getTemplateForRobloxComponent(value2.roblox_component) or arg1
            end

            bool2 = false
        elseif bool1 ~= true then
            bool2 = false
            inlineComponent = arg1
        else
            bool2 = true
            inlineComponent = arg1
        end

        if tbl3 and tbl3[value] then
            local var2 = tbl3[value]
            if SduiPropUtils.isComponentVisible(var2, arg6) then
                table.insert(itemList, var2)
            end
        else
            local computed = Signals.createComputed(function(arg7)
                if bool2 then
                    return Cryo.Dictionary.join(arg2(arg7), value2 or tbl1)
                end

                local var2

                if inputs then
                    var2 = table.clone(value2)
                    local success, result = pcall(function()
                        buildInputsForNestedComponent(arg2, inputs, arg5, arg7, var2, arg3)
                    end)

                    if not success then
                        local tbl4 = {
                            message = `Failed to build inputs for nested component in list: {SduiParseHelpers.stringifyValue(result)}`,
                            name = arg3.debugName,
                            componentType = arg3.currentComponentType,
                            parserName = arg3.currentParserName
                        }
                        if FFlagSduiErrorPaths then
                            addSduiErrorContextFields(tbl4, arg3.errorContext)
                        end
                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl4, arg3.appPage)
                    end
                else
                    var2 = value2
                end
                return var2
            end)

            local var2 = buildConfigForComponent

            local var3 = nil
            local var4 = if bool2 then arg5 else nil
            local var5 = nil
            if not FFlagSduiErrorPaths then
                var1 = nil
            end

            local identifier = if FFlagSduiErrorPaths and typeof(value2) == "table" then value2.identifier else nil
            local var6 = var2(inlineComponent, computed, arg3, arg4, var3, var4, var5, var1, identifier)

            if var6 and SduiPropUtils.isComponentVisible(var6, arg6) then
                table.insert(itemList, var6)
            end
        end
    end

    return itemList
end

local function buildOrderedTemplateDataList(arg1, arg2, arg3, arg4, arg5)
    local entryMapPath = arg1.entry_map_path
    local entryOrder = arg1.entry_order
    local templateDataMap = arg1.template_data_map

    if entryOrder == nil then
        error("Missing entry_order in ordered_template_data")
    end
    if templateDataMap == nil or typeof(templateDataMap) ~= "table" then
        error("Missing or invalid template_data_map in ordered_template_data")
    end

    local var1 = if entryMapPath and entryMapPath ~= "" then splitDottedPath(entryMapPath) else nil
    local kind = if entryOrder then entryOrder.kind else nil
    local var2 = if kind and kind.type == "binding_path" then splitDottedPath(kind.value) else nil

    return Signals.createComputed(function(arg6)
        local success, result = pcall(function()
            local items = nil
            if var2 then
                items = SduiPropUtils.resolveBindingPathValue(arg6, var2, arg2, arg3, nil, nil, arg4)
            elseif kind and kind.type == "literal" then
                items = kind.value and kind.value.items
            end
            if items == nil then
                error("entry_order resolved to nil in ordered_template_data")
            end

            local var3 = if var1 then SduiPropUtils.resolveBindingPathValue(arg6, var1, arg2, arg3, nil, nil, arg4) else nil
            local result = {}
            for _, item in items do
                if typeof(item) == "table" then
                    item = item.identifier
                end

                local var4 = item

                if var4 == nil or var4 == "" then
                    continue
                end

                local var5 = templateDataMap[var4]
                local var6 = if var3 then var3[var4] else nil
                local inlineComponent = if var5 then var5.inline_component else nil
                local robloxComponent = if var6 and var6.roblox_component and var6.roblox_component ~= "" then var6.roblox_component elseif var5 and var5.roblox_component then var5.roblox_component else nil

                if robloxComponent == nil and inlineComponent == nil then
                    local tbl2 = {
                        message = `No roblox_component or inline_component for identifier "{var4}" in ordered_template_data (not in template_data_map or feed entry)`,
                        name = arg4.debugName,
                        componentType = arg4.currentComponentType,
                        parserName = arg4.currentParserName
                    }
                    if FFlagSduiErrorPaths then
                        addSduiErrorContextFields(tbl2, arg4.errorContext)
                    end
                    SduiLogger.reportError(SduiErrors.SduiErrorType.UnknownTemplateDataIdentifier, tbl2, arg4.appPage)
                else
                    local success, result2 = pcall(function()
                        local var7 = SduiPropUtils.resolveTemplate(robloxComponent, inlineComponent, arg4)

                        local bool1 = inlineComponent ~= nil
                        local inputs = if var5 then var5.inputs else nil

                        local computed = Signals.createComputed(function(arg7)
                            local tbl2

                            if bool1 then
                                tbl2 = table.clone(arg3(arg7))
                            else
                                tbl2 = {}
                                if inputs then
                                    buildInputsForNestedComponent(arg3, inputs, arg2, arg7, tbl2, arg4)
                                end
                            end

                            if var6 then
                                local value = if var6.input_data and var6.input_data.kind and var6.input_data.kind.value then var6.input_data.kind.value else nil

                                if typeof(value) == "table" then
                                    for value2, value3 in value do
                                        tbl2[value2] = value3
                                    end
                                end
                            end

                            return tbl2
                        end)

                        return buildConfigForComponent(
                            var7,
                            computed,
                            arg4,
                            arg5,
                            nil,
                            if bool1 then arg2 else nil,
                            nil,
                            if FFlagSduiErrorPaths and not bool1 then robloxComponent else nil,
                            if FFlagSduiErrorPaths then var4 else nil
                        )
                    end)

                    if not success then
                        local tbl2 = {
                            message = `Failed to build ordered_template_data entry for identifier {var4}: {SduiParseHelpers.stringifyValue(result2)}`,
                            name = arg4.debugName,
                            componentType = arg4.currentComponentType,
                            parserName = arg4.currentParserName
                        }
                        if FFlagSduiErrorPaths then
                            addSduiErrorContextFields(tbl2, arg4.errorContext)
                        end
                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)
                    elseif result2 and SduiPropUtils.isComponentVisible(result2, arg6) then
                        table.insert(result, result2)
                    end
                end
            end
            return result
        end)

        if success then
            return { data = result }
        end

        local tbl2 = {
            message = `Failed to build ordered_template_data component list: {SduiParseHelpers.stringifyValue(result)}`,
            name = arg4.debugName,
            componentType = arg4.currentComponentType,
            parserName = arg4.currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl2, arg4.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)
        return {
            data = {}
        }
    end), PropResultCategory.PropSignal
end

local function buildLazyNestedComponentListProp(str1: string, arg1, arg2, arg3, arg4, arg5)
    local currentComponentType = arg4.currentComponentType
    local currentParserName = arg4.currentParserName

    if str1 == "array_map" then
        local var1 = SduiPropUtils.resolveTemplateFromData(arg1, arg4)
        local bindingPath = arg1.binding_path
        if bindingPath == nil or bindingPath == "" then
            error(`No bindingPath specified for roblox_component {arg1.roblox_component}`)
        end

        local bool1 = arg1.inline_component ~= nil

        local itemList = nil
        return SduiPropUtils.generateDynamicBindingPropValue(bindingPath, arg2, arg4, arg3, function(arg6, arg7)
            itemList = buildItemList(
                var1,
                arg6,
                arg1.inputs,
                arg3,
                arg4,
                arg5,
                itemList,
                arg2,
                arg7,
                bool1,
                if FFlagSduiErrorPaths and not bool1 then arg1.roblox_component else nil
            )

            return itemList
        end), PropResultCategory.PropSignal
    end

    if str1 ~= "item_list" then
        if str1 == "ordered_template_data" then
            return buildOrderedTemplateDataList(arg1, arg2, arg3, arg4, arg5)
        elseif str1 == "conditional" then
            return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, buildLazyNestedComponentListProp), PropResultCategory.PropSignal
        elseif str1 == "component_list" then
            return buildComponentList(str1, arg1, arg2, arg3, arg4, arg5)
        end

        error(`Could not build prop. Unknown propDefinitionType: {str1}`)
        return
    end

    if typeof(arg1) ~= "table" then
        error(`Missing or invalid templateDataList {typeof(arg1)}`)
    end

    local items = arg1.items
    if typeof(items) ~= "table" then
        error(`Missing or invalid templateDataList.items {typeof(arg1)}`)
    end

    return Signals.createComputed(function(arg6)
        local success, result = pcall(function()
            local result = {}
            for _, item in items do
                local var1 = SduiPropUtils.resolveTemplateFromData(item, arg4)

                local bool1 = item.inline_component ~= nil
                local inputs = item.inputs

                local var2 = if bool1 then arg3 else Signals.createComputed(function(arg7)
                    local result2 = {}
                    if inputs then
                        local success, result3 = pcall(function()
                            buildInputsForNestedComponent(arg3, inputs, arg2, arg7, result2, arg4)
                        end)

                        if not success then
                            local tbl2 = {
                                message = `Failed to build inputs for nested component in item_list: {SduiParseHelpers.stringifyValue(result3)}`,
                                name = arg4.debugName,
                                componentType = currentComponentType,
                                parserName = currentParserName
                            }
                            if FFlagSduiErrorPaths then
                                addSduiErrorContextFields(tbl2, arg4.errorContext)
                            end
                            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)
                        end
                    end

                    return result2
                end)

                local configForComponent = buildConfigForComponent(
                    var1,
                    var2,
                    arg4,
                    arg5,
                    nil,
                    if bool1 then arg2 else nil,
                    nil,
                    if FFlagSduiErrorPaths and not bool1 then item.roblox_component else nil
                )

                if configForComponent and SduiPropUtils.isComponentVisible(configForComponent, arg6) then
                    table.insert(result, configForComponent)
                end
            end

            return result
        end)

        if success then
            return { data = result }
        end

        local tbl2 = {
            message = `Failed to build item_list component list: {SduiParseHelpers.stringifyValue(result)}`,
            name = arg4.debugName,
            componentType = currentComponentType,
            parserName = currentParserName
        }
        if FFlagSduiErrorPaths then
            addSduiErrorContextFields(tbl2, arg4.errorContext)
        end
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, arg4.appPage)

        return {
            data = {}
        }
    end), PropResultCategory.PropSignal
end

return buildLazyNestedComponentListProp
