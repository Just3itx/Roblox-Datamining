-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local React = require(AuthSignupParent.React)
local Foundation = require(AuthSignupParent.Foundation)
local AuthCommon = require(AuthSignupParent.AuthCommon)
local UserGender = AuthCommon.Enums.UserGender
local formatBoldRichText = AuthCommon.Utils.formatBoldRichText

local View = Foundation.View
local Chip = Foundation.Chip
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize
local ChipSize = Foundation.Enums.ChipSize
local IconName = Foundation.Enums.IconName

local function SignUpGenderChips(tbl1)
    local onGenderSelected = tbl1.onGenderSelected

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }

    local tbl3 = {
        Label = React.createElement(InputLabel, {
            Text = if tbl1.isLabelBold then formatBoldRichText(tbl1.label) else tbl1.label,
            RichText = tbl1.isLabelBold,
            size = InputLabelSize.Medium,
            LayoutOrder = 1
        }),
        Options = React.createElement(View, { tag = "row gap-small auto-xy", LayoutOrder = 2 }, {
            Female = React.createElement(Chip, {
                text = tbl1.femaleText,
                leading = IconName.HeadFemale,
                size = ChipSize.Large,
                isChecked = tbl1.gender == UserGender.Female,
                onActivated = function()
                    onGenderSelected(UserGender.Female)
                end,
                LayoutOrder = 1,
                testId = "--auth-signup-gender-female"
            }),
            Male = React.createElement(Chip, {
                text = tbl1.maleText,
                leading = IconName.HeadMale,
                size = ChipSize.Large,
                isChecked = tbl1.gender == UserGender.Male,
                onActivated = function()
                    onGenderSelected(UserGender.Male)
                end,
                LayoutOrder = 2,
                testId = "--auth-signup-gender-male"
            })
        })
    }

    return createElement(var1, tbl2, tbl3)
end

return SignUpGenderChips
