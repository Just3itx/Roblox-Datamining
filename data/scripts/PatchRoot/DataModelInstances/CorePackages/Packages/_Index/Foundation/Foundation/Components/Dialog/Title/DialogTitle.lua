-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local useDialog = require(script.Parent.Parent.useDialog)
local useDialogVariants = require(script.Parent.Parent.useDialogVariants).useDialogVariants

local function DialogTitle(tbl1)
    local var1 = useTokens()
    local var2 = useDialog()
    local var3 = useDialogVariants()

    return React.createElement(
        View,
        {
            tag = var3.title.tag,
            LayoutOrder = Constants.MIN_LAYOUT_ORDER + 1,
            padding = {
                right = if var2.hasHeroMedia then nil else UDim.new(0, var3.closeAffordance.offset + var1.Size.Size_1000),
                top = if var2.hasHeroMedia then nil else UDim.new(0, var1.Size.Size_500)
            },
            testId = `{var2.testId}--title`
        },
        {
            Title = React.createElement(Text, { tag = var3.titleText.tag, Text = tbl1.text })
        }
    )
end

return DialogTitle
