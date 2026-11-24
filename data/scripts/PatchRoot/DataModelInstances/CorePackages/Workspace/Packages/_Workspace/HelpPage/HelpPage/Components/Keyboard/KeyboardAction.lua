-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _ConfigTypes = require(scriptParentParentParent.Configs.ConfigTypes)
local ExtraKeysEnum = require(scriptParentParentParent.Enums.ExtraKeysEnum)
local Localization = require(scriptParentParentParentParent.Localization)
local Constants = require(scriptParentParentParent.Constants)
local FFlagHelpPageCCL = require(scriptParentParentParent.Flags.FFlagHelpPageCCL)
local useLocalizedLabels = require(scriptParentParentParent.Hooks.useLocalizedLabels)

local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization
local KEYCODE_ORDER = Constants.HELP_PAGE.KEYCODE_ORDER

local function getKeyCodeName(keyCode: Enum.KeyCode)
    if Constants.HELP_PAGE.KEYCODES_LOCALIZED[keyCode] then
        return {
            needsLocalization = true,
            keyCodeName = Constants.HELP_PAGE.KEYCODES_LOCALIZED[keyCode]
        }
    end

    if Constants.HELP_PAGE.KEYCODES_UNLOCALIZED[keyCode] then
        return {
            needsLocalization = false,
            keyCodeName = Constants.HELP_PAGE.KEYCODES_UNLOCALIZED[keyCode]
        }
    end

    return {
        needsLocalization = false,
        keyCodeName = UserInputService:GetStringForKeyCode(keyCode)
    }
end

local function getKeycodeLayoutOrder(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if KEYCODE_ORDER[arg1] then
        return KEYCODE_ORDER[arg1]
    end

    if arg1 == ExtraKeysEnum.DPad or arg1 == ExtraKeysEnum.TouchPad then
        return math.huge
    end

    return arg1.Value
end

local function getDisplayableKeyCodes(arg1)
    local displayableKeyCodes = {}

    for i = 1, #arg1 do
        local keyCode = arg1[i]
        if keyCode ~= Enum.KeyCode.None and getKeyCodeName(keyCode).keyCodeName ~= "" then
            table.insert(displayableKeyCodes, keyCode)
        end
    end

    return displayableKeyCodes
end

local function KeyCodeComponent(tbl1)
    local var1 = useTokens()
    local keyCodeName = getKeyCodeName(tbl1.keyCode)

    local tbl2 = {}
    if keyCodeName.needsLocalization then
        tbl2[keyCodeName.keyCodeName] = keyCodeName.keyCodeName
    end
    local var2 = useLocalization(tbl2)

    local var3 = keyCodeName.needsLocalization and var2[keyCodeName.keyCodeName] or keyCodeName.keyCodeName
    if tbl1.addSeparator then
        var3 = Constants.HELP_PAGE.SEPARATORS.COMBO .. var3
    end

    return React.createElement(FoundationText, {
        tag = "auto-xy text-body-small text-wrap text-align-x-left",
        textStyle = if FFlagHelpPageCCL and tbl1.disabled then var1.Color.Extended.White.White_50 else var1.Color.Extended.White.White_100,
        Text = var3
    })
end

local function KeyCodeComboComponent(tbl1)
    local var1 = useTokens()
    local displayableKeyCodes = getDisplayableKeyCodes(tbl1.combo)

    local var2 = React.useMemo(function()
        local result = {}

        if tbl1.addSeparator then
            local createElement = React.createElement
            local var2 = View
            local tbl2 = {
                tag = "auto-xy",
                LayoutOrder = -math.huge,
                key = "separator"
            }

            local tbl3 = {
                Separator = React.createElement(FoundationText, {
                    tag = "auto-xy text-body-small text-align-x-left text-truncate-end",
                    textStyle = if FFlagHelpPageCCL and tbl1.disabled then var1.Color.Extended.White.White_50 else var1.Color.Extended.White.White_100,
                    Text = Constants.HELP_PAGE.SEPARATORS.ALTERNATIVE
                })
            }
            table.insert(result, createElement(var2, tbl2, tbl3))
        end

        for i, keyCode in ipairs(displayableKeyCodes) do
            local createElement = React.createElement
            local var2 = View
            local tbl2 = {
                KeyCodeComponent = React.createElement(KeyCodeComponent, { keyCode = keyCode, addSeparator = i ~= 1, disabled = tbl1.disabled })
            }
            table.insert(result, createElement(var2, { tag = "auto-xy", LayoutOrder = i, key = i }, tbl2))
        end

        return result
    end, {
        displayableKeyCodes,
        tbl1.addSeparator,
        tbl1.disabled,
        var1.Color.Extended.White.White_50,
        var1.Color.Extended.White.White_100
    })

    return React.createElement(View, { tag = "row wrap auto-xy" }, var2)
end

local function InputComponent(tbl1)
    local var1 = React.useMemo(function()
        for _, value in ipairs(tbl1.input) do
            table.sort(value, function(arg1, arg2): boolean
                return getKeycodeLayoutOrder(arg1) < getKeycodeLayoutOrder(arg2)
            end)
        end

        table.sort(tbl1.input, function(arg1, arg2)
            if #arg1 ~= #arg2 then
                return #arg1 < #arg2
            end

            for i = 1, #arg1 do
                if arg1[i] ~= arg2[i] then
                    return getKeycodeLayoutOrder(arg1[i]) < getKeycodeLayoutOrder(arg2[i])
                end
            end
            return false
        end)

        local result = {}

        for i, combo in ipairs(tbl1.input) do
            if #getDisplayableKeyCodes(combo) == 0 then
                continue
            end

            local addSeparator = #result ~= 0

            local createElement = React.createElement
            local var1 = View

            local tbl2 = {
                KeyCodeComboComponent = React.createElement(
                    KeyCodeComboComponent,
                    {
                        combo = combo,
                        addSeparator = addSeparator,
                        layoutOrder = i,
                        disabled = tbl1.disabled
                    }
                )
            }
            table.insert(result, createElement(var1, { tag = "auto-xy", LayoutOrder = i, key = i }, tbl2))
        end

        return result
    end, { tbl1.input, tbl1.disabled })

    return React.createElement(View, { tag = "row wrap auto-xy" }, var1)
end

return React.memo(function(tbl1)
    local var1 = useTokens()
    local control = tbl1.control
    local var2 = useLocalizedLabels({ actionText = control.label })

    local keyboardInput = control.keyboardInput

    local input = React.useMemo(function()
        if keyboardInput == nil then
            return nil
        end

        local input = keyboardInput.input
        if input == nil then
            if UserInputService:GetPlatform() == Enum.Platform.OSX then
                return keyboardInput.macInput
            end
            input = keyboardInput.winInput
        end

        return input
    end, { keyboardInput })

    if keyboardInput == nil or input == nil then
        return nil
    end

    local disabled = control.disabled
    local textStyle = if FFlagHelpPageCCL and disabled then var1.Color.Extended.White.White_50 else var1.Color.Extended.White.White_100
    local backgroundStyle = if FFlagHelpPageCCL and disabled then var1.Color.Extended.Gray.Gray_1000 else var1.Color.Extended.Gray.Gray_800
    return React.createElement(View, {
        tag = {
            ["row wrap flex-x-fill align-x-left align-y-center gap-small size-full-0 auto-y padding-small radius-xsmall clip"] = FFlagHelpPageCCL,
            ["row wrap flex-fill align-x-left align-y-center gap-small size-full-1100 padding-x-small radius-xsmall clip"] = not FFlagHelpPageCCL
        },
        backgroundStyle = backgroundStyle,
        LayoutOrder = keyboardInput.layoutOrder
    }, {
        ActionLabelContainer = React.createElement(View, {
            tag = {
                ["col align-x-left align-y-center auto-y"] = FFlagHelpPageCCL,
                ["col align-x-left align-y-center"] = not FFlagHelpPageCCL
            },
            LayoutOrder = 1
        }, {
            ActionLabel = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-title-small text-wrap text-align-x-left",
                    textStyle = textStyle,
                    Text = var2.actionText
                }
            )
        }),
        InputLabelContainer = React.createElement(
            View,
            {
                tag = {
                    ["col align-x-left align-y-center auto-y"] = FFlagHelpPageCCL,
                    ["col align-x-left align-y-center"] = not FFlagHelpPageCCL
                },
                LayoutOrder = 2,
                testId = "input-label-container"
            },
            {
                InputLabel = React.createElement(InputComponent, { input = input, disabled = disabled })
            }
        )
    })
end)
