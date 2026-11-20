-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local HttpService = game:GetService("HttpService")

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize

local _Types = require(AmpV2Wizard.Types)

local function formatValue(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) ~= "table" then
        return tostring(arg1)
    end

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(arg1)
    end)
    if success then
        return result
    end

    return tostring(arg1)
end

local function formatDetails(details): string
    if details == nil then
        return "(no details)"
    end

    local tbl1 = {}
    for k in details do
        table.insert(tbl1, k)
    end
    if #tbl1 == 0 then
        return "(no details)"
    end
    table.sort(tbl1)

    local tbl2 = {}
    for _, value in tbl1 do
        table.insert(tbl2, `{value}: {formatValue(details[value])}`)
    end
    return table.concat(tbl2, "\n")
end

local function sortedOutcomes(transitions) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    if transitions ~= nil then
        for k in transitions do
            table.insert(result, k)
        end
        table.sort(result)
    end
    return result
end

local function UnknownNodeDebugView(tbl1)
    local report = tbl1.report
    local tbl2 = sortedOutcomes(tbl1.transitions)

    local actions = React.useMemo(function()
        local result = {}
        for value, value2 in tbl2 do
            local tbl3 = {
                text = `{value2} ({tbl1.transitions[value2].kind})`,
                variant = if value == 1 then ButtonVariant.Emphasis else ButtonVariant.Standard,
                onActivated = 0
            }

            function tbl3.onActivated()
                if report ~= nil then
                    report(value2)
                end
            end

            table.insert(result, tbl3)
        end

        return result
    end, { table.concat(tbl2, ","), tbl1.transitions, report })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl3 = {
        size = DialogSize.Medium
    }
    local tbl4 = {
        Title = React.createElement(Dialog.Title, { text = `Unrenderable node: {tbl1.nodeType}` }),
        Content = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
            Details = React.createElement(Dialog.Text, { Text = formatDetails(tbl1.details), LayoutOrder = 1 }),
            NoOutcomes = if #tbl2 == 0 then React.createElement(Dialog.Text, { Text = "(no outcomes declared)", LayoutOrder = 2 }) else nil
        }),
        Actions = React.createElement(Dialog.Actions, { LayoutOrder = 3, actions = actions })
    }
    return createElement(root, tbl3, tbl4)
end

return UnknownNodeDebugView
