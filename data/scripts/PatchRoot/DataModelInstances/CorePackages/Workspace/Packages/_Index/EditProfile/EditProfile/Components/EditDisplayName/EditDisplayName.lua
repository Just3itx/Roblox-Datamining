-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local Foundation = require(EditProfileParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local TextInput = Foundation.TextInput
local IconName = Foundation.Enums.IconName

local TextKeys = require(EditProfile.Common.TextKeys)
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local Constants = require(EditProfile.Common.Constants)
local useDisplayNameText = require(EditProfile.Hooks.useDisplayNameText)
local LuauPolyfill = require(EditProfileParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout
local AnalyticsServiceV2 = require(EditProfile.Analytics.AnalyticsServiceV2)

local num1 = game:DefineFastInt("MaxDisplayNameCharacters", 20)
local num2 = game:DefineFastInt("MinDisplayNameCharacters", 3)
local num3 = game:DefineFastInt("DisplayNameValidationNetworkDelay", 500)

return function(tbl1)
    local var1 = useLocalization({ DisplayNameCaption = TextKeys.DisplayNameCaption })

    local var2 = useDisplayNameText()
    local text, var4 = React.useState(tbl1.initialDisplayName)
    local hasError, var6 = React.useState(false)
    local var7, var8 = React.useState(var2.displayNameChangeError)
    local var9, var10 = React.useState(false)
    local var11 = React.useRef(setTimeout(function() end, num3))

    React.useEffect(function()
        if tbl1.updateErrorState then
            tbl1.updateErrorState(hasError or var9)
        end
    end, { hasError, var9 })

    React.useEffect(function()
        var4(tbl1.initialDisplayName)
    end, { tbl1.initialDisplayName })

    local function getErrorMessage(code: number)
        return ({
            [Constants.DisplayNameValidationErrorCodes.TooShort] = var2.nameTooShortError,
            [Constants.DisplayNameValidationErrorCodes.TooLong] = var2.nameTooLongError,
            [Constants.DisplayNameValidationErrorCodes.InvalidCharacters] = var2.nameUnsupportedCharsError,
            [Constants.DisplayNameValidationErrorCodes.Moderated] = var2.nameInappropriateError,
            [Constants.DisplayNameValidationErrorCodes.Throttled] = var2.nameHasChangedError,
            [Constants.DisplayNameValidationErrorCodes.InvalidCharacterSetCombination] = var2.displayNameChangeMixedCharactersError,
            [Constants.DisplayNameValidationErrorCodes.NameNotAvailable] = var2.nameNotAvailableError
        })[code]
            or var2.displayNameChangeError
    end

    local function textChanged(str1: string)
        clearTimeout(var11.current)
        local str2 = str1 or ""
        local num4 = utf8.len(str2) or 0

        var4(str2)
        var6(false)
        var10(false)
        if num4 < num2 then
            AnalyticsServiceV2.sendDisplayNameTooShort(str2)
            var8(var2.nameTooShortError)
            var6(true)
            return
        end

        if num1 < num4 then
            var8(var2.nameTooLongError)
            var6(true)
            return
        end

        var10(true)
        var11.current = setTimeout(function()
            tbl1.validateDisplayName(str2):andThen(function(_)
                var6(false)
                var10(false)
                tbl1.onDataChange(str2)
            end):catch(function(arg1)
                local code = arg1 and arg1.errors and arg1.errors[1] and arg1.errors[1].code or -1

                AnalyticsServiceV2.sendFilteredDisplayName(str2)
                var8((getErrorMessage(code)))
                var6(true)
                var10(false)
            end)
        end, num3)
    end

    local createElement = React.createElement
    local var12 = View
    local tbl2 = {
        tag = "auto-y col gap-medium bg-transparent",
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl3 = {
        Caption = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var1.DisplayNameCaption,
            tag = "text-body-medium text-wrap size-full-0 auto-y text-align-x-left"
        }),
        DisplayNameInput = 0
    }

    local createElement2 = React.createElement
    local var13 = TextInput
    local tbl4 = {
        text = text,
        LayoutOrder = 2,
        label = "",
        tag = "text-body-medium text-wrap size-full-0 auto-y text-align-x-left",
        width = UDim.new(1, 0),
        placeholder = tbl1.initialDisplayName,
        hint = 0,
        onChanged = 0,
        hasError = 0,
        iconTrailing = 0,
        textBoxRef = 0
    }

    if not hasError then
        var7 = string.format("%d/%d", utf8.len(text or "") or 0, num1)
    end

    tbl4.hint = var7

    function tbl4.onChanged(str1: string)
        textChanged(str1)
    end
    tbl4.hasError = hasError
    tbl4.iconTrailing = if text then #text > 0 and {
        name = IconName.CircleX,
        onActivated = function()
            textChanged("")
        end
    } or nil else nil

    tbl4.textBoxRef = tbl1.textBoxRef
    tbl3.DisplayNameInput = createElement2(var13, tbl4)
    return createElement(var12, tbl2, tbl3)
end
