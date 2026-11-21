-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea

local TextKeys = require(EditProfile.Common.TextKeys)
local Constants = require(EditProfile.Common.Constants)
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization

return function(tbl1)
    local var1 = useLocalization({
        AboutModalCaption = TextKeys.AboutModalCaption,
        AboutPlaceholder = TextKeys.AboutPlaceholder,
        PinLocked = TextKeys.PinLocked,
        ThrottleError = TextKeys.TooManyAttemptsTryAgainLater
    })

    local text, var3 = React.useState(tbl1.bioText)
    local hasError, var5 = React.useState(string.len(tbl1.bioText) >= 1000)

    local function textChanged(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local num1 = string.len(str1)

        var3(str1)
        var5(num1 > 1000)

        if tbl1.onDataChange then
            tbl1.onDataChange(string.sub(str1, 1, 1000))
        end
    end

    local var6 = if tbl1.errorCode == Constants.DescriptionErrorCodes.PinLocked then var1.PinLocked else var1.ThrottleError
    local createElement = React.createElement
    local var7 = View
    local tbl2 = { tag = "col size-full-0 auto-y gap-large" }

    local tbl3 = {
        Caption = React.createElement(
            FoundationText,
            {
                tag = "text-body-medium text-wrap size-full-0 auto-y text-align-x-left",
                Text = var1.AboutModalCaption
            }
        ),
        BioTextArea = 0
    }

    local createElement2 = React.createElement
    local var8 = TextArea

    local tbl4 = {
        text = text,
        width = UDim.new(1, 0),
        onChanged = function(arg1)
            textChanged(arg1)
        end,
        hint = 0,
        placeholder = 0,
        label = "",
        hasError = 0,
        numLines = 4,
        textBoxRef = 0
    }

    if not tbl1.errorCode then
        var6 = string.format("%d/%d", string.len(text), 1000)
    end

    tbl4.hint = var6

    tbl4.placeholder = var1.AboutPlaceholder

    tbl4.hasError = hasError or tbl1.errorCode ~= nil

    tbl4.textBoxRef = tbl1.textBoxRef
    tbl3.BioTextArea = createElement2(var8, tbl4)
    return createElement(var7, tbl2, tbl3)
end
