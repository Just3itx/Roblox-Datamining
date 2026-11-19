-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local withDefaults = require(Foundation.Utility.withDefaults)

local PopoverContext = require(script.Parent.PopoverContext)

local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local _Types = require(Foundation.Components.Types)

local tbl1 = { testId = "--foundation-popover" }

local function Popover(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local anchor, setAnchor = React.useState(nil)
    local anchorUri, setAnchorUri = React.useState(nil)

    local value = React.useMemo(function()
        return {
            anchor = anchor,
            setAnchor = setAnchor,
            anchorUri = anchorUri,
            setAnchorUri = setAnchorUri,
            isOpen = var1.isOpen,
            testId = var1.testId
        }
    end, {
        anchor,
        anchorUri,
        var1.isOpen,
        var1.testId
    })
    return React.createElement(PopoverContext.Provider, { value = value }, var1.children)
end

return Popover
