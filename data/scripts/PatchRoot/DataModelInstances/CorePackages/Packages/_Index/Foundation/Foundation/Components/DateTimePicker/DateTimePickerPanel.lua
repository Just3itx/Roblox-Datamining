-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:41:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DateTimeCalendarConstants = require(script.Parent.Utilities.DateTimeCalendarConstants)
local DateTimeLayoutUtilities = require(script.Parent.Utilities.DateTimeLayoutUtilities)

local Button = require(Foundation.Components.Button)
local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local Divider = require(Foundation.Components.Divider)
local Translator = require(Foundation.Utility.Localization.Translator)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function DateTimePickerPanel(tbl1)
    local var1 = useTokens()
    local var2 = useScaledValue(DateTimeLayoutUtilities.PANE_WIDTH)
    local var3 = useScaledValue(DateTimeLayoutUtilities.CALENDAR_WIDTH)
    local var4 = useScaledValue(DateTimeLayoutUtilities.TIME_LIST_WIDTH)

    local applyButton = React.createElement(Button, {
        isDisabled = tbl1.isApplyButtonDisabled,
        LayoutOrder = 2,
        onActivated = tbl1.onApply,
        testId = `{tbl1.testId}--apply-button`,
        text = Translator:FormatByKey("CommonUI.Controls.Action.Apply"),
        variant = ButtonVariant.Emphasis
    })

    local cancelButton = React.createElement(Button, {
        LayoutOrder = 3,
        onActivated = tbl1.onCancel,
        testId = `{tbl1.testId}--cancel-button`,
        text = Translator:FormatByKey("CommonUI.Controls.Action.Cancel"),
        variant = ButtonVariant.Standard
    })

    local str1 = if tbl1.isSectioned then "padding-x-large padding-y-large" else "padding-top-large"
    local element3

    if tbl1.showReset and tbl1.onReset then
        element3 = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = `row align-y-center gap-small size-full-0 auto-y {str1}`
            },
            {
                ResetButton = React.createElement(Button, {
                    isDisabled = tbl1.isResetButtonDisabled,
                    LayoutOrder = 1,
                    onActivated = tbl1.onReset,
                    testId = `{tbl1.testId}--reset-button`,
                    text = Translator:FormatByKey("CommonUI.Controls.Action.ResetAll"),
                    variant = ButtonVariant.Utility
                }),
                PrimaryActions = React.createElement(
                    View,
                    { LayoutOrder = 2, tag = "row align-x-right grow gap-small auto-y" },
                    { ApplyButton = applyButton, CancelButton = cancelButton }
                )
            }
        )
    else
        element3 = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = `row flex-fill gap-small size-full-0 auto-y {str1}`
            },
            { ApplyButton = applyButton, CancelButton = cancelButton }
        )
    end
    local var5 = 2 * var2 + 3 * var1.Padding.Large
    local contentWidth = DateTimeLayoutUtilities.computeSingleWithTimeLayout(var3, var4, var1, DateTimeCalendarConstants.NUM_CALENDAR_GRID_ROWS).contentWidth

    if tbl1.sectionedLayout == "dual" then
        contentWidth = var5
    elseif tbl1.sectionedLayout ~= "singleWithTime" then
        contentWidth = nil
    end

    local clip = tbl1.isSectioned == true
    local bool2 = clip and tbl1.sectionedLayout ~= nil

    return React.createElement(View, {
        Size = if contentWidth then UDim2.fromOffset(contentWidth, 0) else nil,
        tag = {
            col = true,
            ["bg-surface-200"] = true,
            ["stroke-default"] = true,
            ["radius-large"] = true,
            ["auto-y"] = bool2,
            ["auto-xy"] = not bool2,
            clip = clip,
            ["padding-large"] = not clip
        }
    }, {
        Content = tbl1.children,
        ActionsDivider = if tbl1.isSectioned then React.createElement(Divider, { LayoutOrder = 2 }) else nil,
        Actions = element3
    })
end

return DateTimePickerPanel
