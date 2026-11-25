-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local tutils = require(SduiCoreSystemParent.tutils)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local validateInterface = require(SduiCoreSystem.validateInterface)
local SduiTemplateInterface = SduiConfigTypes.SduiTemplateInterface

local tbl1 = {}

local function deepJoinArrays(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg2 = arg2 or {}

    for _, value in (tutils.deepCopy(arg1)) do
        table.insert(arg2, value)
    end
    return arg2
end

local function deepJoin(arg1, arg2)
    if not arg1 then
        return arg2
    end

    arg2 = arg2 or tbl1

    local var1 = tutils.deepCopy(arg1)
    for value, value2 in arg2 do
        if typeof(value2) == "table" then
            var1[value] = deepJoin(var1[value], value2)
        else
            var1[value] = value2
        end
    end

    return var1
end

local module = {}
module.__index = module

function module.new(_registeredTemplates)
    local tbl2 = {
        _registeredTemplates = _registeredTemplates or {}
    }
    setmetatable(tbl2, module)

    return tbl2
end

function module:getTemplate(str1: string)
    return self._registeredTemplates[str1]
end

function module.shouldResolveTemplate(_, arg1): boolean
    return not (arg1.templateKey == nil) and arg1.templateKey ~= "NONE"
end

function module.resolveTemplateForConfig(arg1, arg2, arg3, tbl2)
    local templateKey = arg2.templateKey
    if not templateKey or templateKey == "NONE" then
        return true
    end
    assert(templateKey, "templateKey must exist")

    tbl2 = tbl2 or {}
    assert(tbl2, "seen exists")
    if tbl2[arg2] then
        arg3.dependencies.logger.reportError(SduiErrors.SduiErrorType.DetectedCycleInTemplates, {
            componentType = arg2.componentType,
            value = templateKey,
            message = `Found cycle in template with key {templateKey}`
        }, arg3.appPage)
        arg2.templateKey = "NONE"
        return false
    end
    tbl2[arg2] = true

    local var1 = arg1._registeredTemplates[templateKey]
    if var1 == nil then
        arg3.dependencies.logger.reportError(SduiErrors.SduiErrorType.FailedToFindTemplate, {
            componentType = arg2.componentType,
            value = templateKey,
            message = `Failed to find template for key {templateKey}`
        }, arg3.appPage)
        arg2.templateKey = "NONE"
        return false
    end
    assert(var1, "template exists")

    local var2, var3 = validateInterface(var1, SduiTemplateInterface, false)
    if not var2 then
        arg3.dependencies.logger.reportError(SduiErrors.SduiErrorType.InvalidComponentConfig, {
            message = `Invalid Template for templateKey {templateKey}. err: {var3}`,
            componentType = arg2.componentType or var1.componentType,
            name = templateKey
        }, arg3.appPage)
    end

    module.resolveTemplateForConfig(arg1, var1, arg3, tbl2)

    arg2.templateKey = "NONE"

    if not arg2.componentType then
        arg2.componentType = var1.componentType
    elseif arg2.componentType and var1.componentType and arg2.componentType ~= var1.componentType then
        arg3.dependencies.logger.reportError(SduiErrors.SduiErrorType.ComponentTypeMismatchWithTemplate, {
            componentType = arg2.componentType,
            value = templateKey,
            message = `Mismatch in componentType for template {templateKey}. Component {arg2.componentType} and template {var1.componentType}`
        }, arg3.appPage)
        return false
    end

    if var1.analyticsData then
        arg2.analyticsData = Cryo.Dictionary.join(var1.analyticsData, arg2.analyticsData or tbl1)
    end

    if var1.props then
        local success, result = pcall(function()
            return (deepJoin(var1.props, arg2.props))
        end)
        if not success then
            arg3.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.FailedToJoinTemplateProps,
                {
                    componentType = arg2.componentType,
                    value = templateKey,
                    message = result
                },
                arg3.appPage
            )
        else
            arg2.props = result
        end
    end

    if var1.children then
        arg2.children = deepJoinArrays(var1.children, arg2.children)
    end

    if var1.conditionalProps then
        arg2.conditionalProps = deepJoinArrays(var1.conditionalProps, arg2.conditionalProps)
    end

    return true
end

return module
