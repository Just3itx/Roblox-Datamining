-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:35Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ButtonGroup = require(Foundation.Components.ButtonGroup)
local _ButtonVariant = require(Foundation.Enums.ButtonVariant)
local DialogSize = require(Foundation.Enums.DialogSize)
local FillBehavior = require(Foundation.Enums.FillBehavior)
local Orientation = require(Foundation.Enums.Orientation)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withDefaults = require(Foundation.Utility.withDefaults)

local useDialogVariants = require(script.Parent.Parent.useDialogVariants).useDialogVariants
local useDialog = require(script.Parent.Parent.useDialog)

local tbl1 = {
    orientation = Orientation.Horizontal
}

local function DialogActions(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = useDialogVariants()
    local var3 = useDialog()

    local bool1 = var3.responsiveSize == DialogSize.Small
    if var1.orientation ~= Orientation.Vertical then
        bool1 = false
    end
    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = var1.LayoutOrder,
        testId = `{var3.testId}--actions`
    }
    local tbl4 = {
        ActionsContainer = React.createElement(ButtonGroup, {
            buttons = var1.actions or {},
            orientation = if bool1 then Orientation.Vertical else Orientation.Horizontal,
            fillBehavior = FillBehavior.Fill,
            LayoutOrder = 1,
            testId = `{var3.testId}--actions-container`
        }),
        ActionsLabel = if var1.label then React.createElement(
            Text,
            {
                Text = var1.label,
                tag = var2.actionsLabel.tag,
                LayoutOrder = 2,
                testId = `{var3.testId}--actions-label`
            }
        ) else nil
    }
    return createElement(var4, tbl3, tbl4)
end

return DialogActions
