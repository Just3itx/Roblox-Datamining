-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)

local InputLabelSize = require(Foundation.Enums.InputLabelSize)

local Medium = InputLabelSize.Medium

return React.memo(function(tbl1) -- name: InputHint
    local var1 = tbl1.size or Medium

    local tag = React.useMemo(function()
        return {
            ["size-0 auto-xy text-wrap text-align-x-left text-align-y-top"] = true,
            ["content-muted"] = tbl1.isDisabled,
            ["content-default"] = not tbl1.isDisabled,
            ["text-caption-small"] = var1 == InputLabelSize.Small or var1 == InputLabelSize.XSmall,
            ["text-caption-medium"] = var1 == InputLabelSize.Medium or var1 == InputLabelSize.Large
        }
    end, { tbl1.isDisabled, var1 })

    return React.createElement(
        Text,
        {
            Text = tbl1.text,
            tag = tag,
            testId = tbl1.testId,
            LayoutOrder = tbl1.LayoutOrder,
            padding = tbl1.padding
        }
    )
end)
