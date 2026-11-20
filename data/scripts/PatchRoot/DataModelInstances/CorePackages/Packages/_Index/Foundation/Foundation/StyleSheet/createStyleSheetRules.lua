-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local StyleRule = require(scriptParent.StyleRule)
local _Types = require(scriptParent.Rules.Types)

local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local Flags = require(Foundation.Utility.Flags)
local _getOverrideAttributes = require(scriptParent.getOverrideAttributes)
local scaleValue = require(Foundation.Utility.scaleValue)

local function insertRule(tbl1, arg1, str1: string)
    local properties = arg1.properties

    local str2 = "." .. str1
    local var1 = if arg1.modifier == nil then "" else ":" .. arg1.modifier
    local var2 = str2 .. var1 .. (if arg1.pseudo == nil then "" else " ::" .. arg1.pseudo)
    if arg1.pseudoName ~= nil then
        var2 ..= " #" .. arg1.pseudoName
    end

    if arg1.pseudo ~= nil and arg1.pseudoName == nil then
        var2 ..= ", " .. str2 .. var1 .. " > " .. arg1.pseudo
    end

    table.insert(
        tbl1,
        React.createElement(StyleRule, { key = var2, Priority = arg1.priority, Selector = var2, properties = properties })
    )
end

local function updateRuleAttributes(arg1, attributes, tbl1, num1: number?, arg2)
    num1 = if Flags.FoundationDisableTokenScaling then 1 else num1 or 1

    for _, value in attributes or {} do
        local var1 = if arg2 then arg2[value.name] else nil

        if var1 == nil then
            var1 = value.value
        end

        local var2 = scaleValue(var1, num1)
        if tbl1[value.name] ~= var2 then
            arg1:SetAttribute(value.name, var2)
            tbl1[value.name] = var2
        end
    end
end

local function createStyleSheetRules(tbl1, tbl2, arg1, tbl3, num1: number?, arg2)
    local styleSheetRules = {}

    for value, _ in tbl2 do
        local var1 = tbl1[value]

        if var1 == nil then
            continue
        end

        if arg1 and tbl3 then
            updateRuleAttributes(arg1, var1.attributes, tbl3, num1, arg2)
        end

        insertRule(styleSheetRules, var1, value)

        if not var1.children then
            continue
        end

        for _, child in var1.children do
            if arg1 and tbl3 then
                updateRuleAttributes(arg1, child.attributes, tbl3, num1, arg2)
            end

            insertRule(styleSheetRules, child, child.tag)
        end
    end

    return styleSheetRules
end

return createStyleSheetRules
