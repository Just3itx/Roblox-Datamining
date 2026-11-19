-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _ColorMode = require(scriptParentParent.Enums.ColorMode)
local Device = require(scriptParentParent.Enums.Device)
local ThemeName = require(scriptParentParent.Enums.ThemeName)
local _Tokens = require(scriptParentParent.Providers.Style.Tokens)
local _Types = require(script.Parent.Rules.Types)

local Flags = require(scriptParentParent.Utility.Flags)
local devAssert = require(scriptParentParent.Utility.devAssert)
local getGeneratedRules = require(scriptParentParent.Utility.getGeneratedRules)
local getMainGui = require(scriptParentParent.Utility.getMainGui)
local getOverrideAttributes = require(script.Parent.getOverrideAttributes)
local scaleValue = require(scriptParentParent.Utility.scaleValue)

local HttpService = game:GetService("HttpService")
local folder = Instance.new("Folder")
folder.Name = "FoundationStyleSheets" .. HttpService:GenerateGUID(false)

local mainGui = getMainGui()
devAssert(mainGui ~= nil, "MainGui not found")
folder.Parent = mainGui

local tbl1 = ({})

local tbl2 = ({})
local bool1 = false

local function createStyleSheet(colorMode, arg1, num1: number?, tokenOverrides, arg2)
    local device = arg1 or Device.Desktop
    local scale = num1 or 1
    local themeName = arg2 or ThemeName.Default
    local styleSheet = Instance.new("StyleSheet")
    local str1 = `{themeName}-`
    styleSheet.Name = if tokenOverrides ~= nil then `{str1}{colorMode}-{device}-{scale}-{tostring(tokenOverrides)}` else `{str1}{colorMode}-{device}-{scale}`

    styleSheet.Parent = folder
    return {
        themeName = themeName,
        colorMode = colorMode,
        device = device,
        scale = scale,
        tokenOverrides = tokenOverrides,
        overrideAttributes = getOverrideAttributes(themeName, colorMode, device, tokenOverrides),
        instance = styleSheet,
        tags = {},
        rules = getGeneratedRules(themeName, colorMode, device),
        attributes = {},
        refCount = 0
    }
end

local function createStyleRule(arg1, str1: string): StyleRule
    local str2 = "." .. str1
    local var1 = if arg1.modifier == nil then "" else ":" .. arg1.modifier
    local var2 = str2 .. var1 .. (if arg1.pseudo == nil then "" else " ::" .. arg1.pseudo)
    if arg1.pseudoName ~= nil then
        var2 ..= " #" .. arg1.pseudoName
    end

    if arg1.pseudo ~= nil and arg1.pseudoName == nil then
        var2 ..= ", " .. str2 .. var1 .. " > " .. arg1.pseudo
    end

    local styleRule = Instance.new("StyleRule")
    styleRule.Name = var2
    styleRule.Priority = arg1.priority or 1
    styleRule.Selector = var2
    styleRule:SetProperties(arg1.properties)
    return styleRule
end

local function applyAttributes(tbl3, attributes)
    if not attributes then
        return
    end

    for _, value in attributes do
        if tbl3.attributes[value.name] then
            continue
        end

        local var1 = tbl3.overrideAttributes[value.name]
        if var1 == nil then
            var1 = value.value
        end

        if not Flags.FoundationDisableTokenScaling then
            var1 = scaleValue(var1, tbl3.scale)
        end

        tbl3.attributes[value.name] = true
        tbl3.instance:SetAttribute(value.name, var1)
    end
end

local function addRegisteredStyleSheetTags(tbl3, tbl4)
    for _, value in tbl4 do
        if tbl3.tags[value] then
            continue
        end

        local var1 = tbl3.rules[value]
        if not var1 then
            continue
        end

        createStyleRule(var1, value).Parent = tbl3.instance
        applyAttributes(tbl3, var1.attributes)
        if var1.children then
            for _, child in var1.children do
                createStyleRule(child, child.tag).Parent = tbl3.instance
                applyAttributes(tbl3, child.attributes)
            end
        end
        tbl3.tags[value] = true
    end
end

local function resolveStyleSheet(colorMode, arg1, num1: number?, tokenOverrides, arg2)
    local var1 = arg1 or Device.Desktop
    local num2 = num1 or 1
    local var2 = arg2 or ThemeName.Default
    for value, value2 in tbl1 do
        if value2.themeName == var2
            and value2.colorMode == colorMode
            and value2.device == var1
            and value2.scale == num2
            and value2.tokenOverrides == tokenOverrides
        then
            tbl2[value] = nil
            return value
        end
    end
    local styleSheet = createStyleSheet(colorMode, var1, num2, tokenOverrides, var2)
    tbl1[styleSheet.instance] = styleSheet
    return styleSheet.instance
end

local function destroyStyleSheet(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[arg1]
    if var1 == nil or var1.refCount > 0 then
        return
    end
    tbl1[arg1] = nil
    arg1:Destroy()
end

local function flushPendingCleanup()
    bool1 = false
    for value in tbl2 do
        tbl2[value] = nil
        destroyStyleSheet(value)
    end
end

local function scheduleCleanup(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl2[arg1] = true
    if bool1 then
        return
    end
    bool1 = true
    task.delay(5, flushPendingCleanup)
end

local function acquireStyleSheet(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[arg1]
    if var1 == nil then
        return
    end
    var1.refCount += 1

    tbl2[arg1] = nil
end

return {
    resolveStyleSheet = resolveStyleSheet,
    getStyleSheet = function(colorMode, arg1, num1: number?, tokenOverrides, arg2)
        local var1 = resolveStyleSheet(colorMode, arg1, num1, tokenOverrides, arg2)
        acquireStyleSheet(var1)
        return var1
    end,
    addStyleTags = function(arg1, tbl3)
        local var1 = tbl1[arg1]
        if not var1 then
            error("StyleSheet not found in registry")
        end
        addRegisteredStyleSheetTags(var1, tbl3)
    end,
    acquireStyleSheet = acquireStyleSheet,
    releaseStyleSheet = function(arg1)
        local var1 = tbl1[arg1]
        if var1 == nil or var1.refCount == 0 then
            return
        end
        var1.refCount -= 1
        if var1.refCount == 0 then
            scheduleCleanup(arg1)
        end
    end,
    flushPendingCleanup = flushPendingCleanup
}
