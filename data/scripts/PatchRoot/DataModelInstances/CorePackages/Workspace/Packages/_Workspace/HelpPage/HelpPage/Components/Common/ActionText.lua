-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local FoundationText = require(scriptParentParentParentParent.Foundation).Text
local escapeRichText = require(scriptParentParentParent.Utils.escapeRichText)
local useLocalizedLabels = require(scriptParentParentParent.Hooks.useLocalizedLabels)

return (React.memo(function(tbl1)
    local actionLabels = tbl1.actionLabels
    local tbl2 = {}
    for i, actionLabel in ipairs(actionLabels) do
        tbl2[tostring(i)] = actionLabel.label
    end
    local var1 = useLocalizedLabels(tbl2)
    local tbl3 = {}
    for i, actionLabel in ipairs(actionLabels) do
        local var2 = var1[tostring(i)]
        local var3 = escapeRichText(var2)
        if actionLabel.disabled then
            var3 = "<font transparency=\"0.5\">" .. var3 .. "</font>"
        end
        table.insert(tbl3, var3)
    end
    local tag = {
        ["size-full-0 auto-y text-wrap"] = true,
        ["text-label-small"] = tbl1.textVariant == "label-small",
        ["text-title-large"] = tbl1.textVariant ~= "label-small"
    }

    return React.createElement(FoundationText, {
        tag = tag,
        Text = table.concat(tbl3, " / "),
        RichText = true,
        TextXAlignment = tbl1.textXAlignment or Enum.TextXAlignment.Center,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end))
