-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local React = require(AuthSignupParent.React)
local Foundation = require(AuthSignupParent.Foundation)
local formatBoldRichText = require(AuthSignupParent.AuthCommon).Utils.formatBoldRichText

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local function SignUpBirthdayField(tbl1)
    local var1 = useTokens()
    local bool1 = not (tbl1.text == nil) and tbl1.text ~= ""
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = "col gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.containerRef
    }
    local tbl3 = {
        Label = React.createElement(InputLabel, {
            Text = if tbl1.isLabelBold then formatBoldRichText(tbl1.label) else tbl1.label,
            RichText = tbl1.isLabelBold,
            isRequired = true,
            size = InputLabelSize.Medium,
            LayoutOrder = 1
        }),
        Field = 0
    }

    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        tag = {
            ["row align-y-center gap-small size-full-1200 padding-x-medium stroke-standard radius-medium"] = true,
            ["stroke-system-emphasis"] = tbl1.isFocused == true,
            ["stroke-emphasis"] = tbl1.isFocused ~= true
        },
        onActivated = tbl1.onActivated,
        ref = tbl1.buttonRef,
        LayoutOrder = 2,
        testId = "--auth-signup-birthday-field"
    }

    local tbl5 = {
        Text = React.createElement(FoundationText, {
            Text = if bool1 then tbl1.text else tbl1.placeholder,
            tag = {
                ["grow auto-xy text-body-large text-align-x-left"] = true,
                ["content-emphasis"] = bool1,
                ["content-default"] = not bool1
            },
            LayoutOrder = 1
        }),
        CalendarIcon = React.createElement(
            Icon,
            {
                name = IconName.Calendar,
                size = IconSize.Large,
                style = var1.Color.Content.Emphasis,
                LayoutOrder = 2
            }
        )
    }
    tbl3.Field = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end

return SignUpBirthdayField
