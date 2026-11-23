-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _FeedbackAction = require(script.Parent.FeedbackAction)

local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize

local function UserFeedback(tbl1)
    local testId = tbl1.testId or "user-feedback"
    local onActivated = tbl1.onActivated
    local selectedAction = tbl1.selectedAction

    local tbl2 = ({})
    for layoutOrder, icon in tbl1.icons do
        local iconName = if selectedAction == icon.action then {
            name = icon.iconName,
            variant = IconVariant.Filled
        } else icon.iconName
        local var1 = icon.testId or `{testId}-{icon.iconName}`
        local var2 = icon.testId or `{icon.iconName}-{layoutOrder}`

        local createElement = React.createElement
        local var3 = IconButton
        local tbl3 = {
            LayoutOrder = layoutOrder,
            icon = iconName,
            isDisabled = icon.isDisabled,
            onActivated = 0,
            size = 0,
            variant = 0,
            testId = 0
        }

        function tbl3.onActivated()
            if selectedAction == icon.action and icon.allowRepeatedActivation ~= true then
                return
            end
            onActivated(icon)
        end
        tbl3.size = InputSize.Small
        tbl3.variant = ButtonVariant.Utility
        tbl3.testId = var1
        tbl2[var2] = createElement(var3, tbl3)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-y-center size-full-0 auto-y padding-top-small",
            testId = testId
        },
        {
            Actions = React.createElement(View, { LayoutOrder = 1, tag = "row wrap align-x-right align-y-center gap-small auto-xy" }, tbl2)
        }
    )
end

return UserFeedback
