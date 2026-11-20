-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)

local useDialogVariants = require(script.Parent.Parent.useDialogVariants).useDialogVariants
local useDialog = require(script.Parent.Parent.useDialog)

local function DialogText(tbl1)
    local var1 = useDialogVariants()
    local var2 = useDialog()

    return React.createElement(Text, {
        Text = tbl1.Text,
        RichText = true,
        tag = var1.contentText.tag,
        LayoutOrder = tbl1.LayoutOrder,
        testId = `{var2.testId}--text`
    })
end

return DialogText
