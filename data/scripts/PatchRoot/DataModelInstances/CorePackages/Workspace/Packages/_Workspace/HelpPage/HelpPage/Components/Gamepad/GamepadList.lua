-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _ConfigTypes = require(scriptParentParentParent.Configs.ConfigTypes)
local Constants = require(scriptParentParentParent.Constants)
local _ActionText = require(scriptParentParentParent.Components.Common.ActionText)
local ControlActionRow = require(scriptParentParentParent.Components.Common.ControlActionRow)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Enums = Foundation.Enums
local useTokens = Foundation.Hooks.useTokens
local ExtraKeysEnum = require(scriptParentParentParent.Enums.ExtraKeysEnum)
local FFlagHelpPageCCL = require(scriptParentParentParent.Flags.FFlagHelpPageCCL)
local useLocalizedLabels = require(scriptParentParentParent.Hooks.useLocalizedLabels)

local var1 = React.memo(function(tbl1)
    local var1 = useLocalizedLabels({ action = tbl1.action })

    return React.createElement(
        FoundationText,
        {
            Text = var1.action,
            tag = "auto-xy text-title-large text-align-x-center text-align-y-center"
        }
    )
end)

local var2 = React.memo(function(tbl1)
    local var2 = useTokens()
    local style = tbl1.isDisabled and {
        Color3 = var2.Color.Content.Default.Color3,
        Transparency = 0.5
    } or nil

    local var4 = React.useMemo(function()
        local result = ({})

        for _, button in ipairs(tbl1.buttons) do
            if button ~= ExtraKeysEnum.TouchPad then
                local var4

                if tbl1.isSpatial then
                    var4 = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_SPATIAL[button]
                elseif Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[tbl1.platform] then
                    if tbl1.platform == Enum.Platform.PS5 and Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION_5[button] ~= nil then
                        var4 = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION_5[button]
                    else
                        var4 = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION[button]
                    end
                else
                    var4 = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_XBOX[button]
                end
                result[button] = var4
            elseif Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[tbl1.platform] then
                if tbl1.platform == Enum.Platform.PS5 and Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION_5[button] ~= nil then
                    result[button] = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION_5[button]
                else
                    result[button] = Constants.HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION[button]
                end
            end
        end

        return result
    end, { tbl1.buttons, tbl1.isSpatial, tbl1.platform })

    local var5 = React.useMemo(function()
        local result = {}

        if tbl1.addBlankIcon and tbl1.layoutOrderReversed then
            table.insert(
                result,
                React.createElement(View, {
                    Size = UDim2.fromOffset(var2.Size.Size_600, var2.Size.Size_600),
                    BackgroundTransparency = 1,
                    LayoutOrder = -1,
                    key = "BlankIconBefore"
                })
            )
        end

        for value, name in var4 do
            local createElement = React.createElement
            local var5 = View
            local tbl2 = {
                tag = "align-x-center align-y-center auto-xy",
                LayoutOrder = Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[value],
                key = Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[value]
            }
            local tbl3 = {
                Icon = React.createElement(Icon, { name = name, size = Enums.IconSize.Large, style = style, testId = tbl1.testId })
            }
            table.insert(result, createElement(var5, tbl2, tbl3))
        end

        return result
    end, {
        var4,
        tbl1.addBlankIcon,
        tbl1.layoutOrderReversed,
        style,
        tbl1.testId,
        var2.Size.Size_600
    })

    local num1 = #tbl1.buttons + (if tbl1.addBlankIcon and tbl1.layoutOrderReversed then 1 else 0)
    local xOffset = var2.Size.Size_600 * num1 + var2.Gap.XSmall * (num1 - 1)

    return React.createElement(View, {
        tag = {
            ["row align-x-center align-y-center gap-xsmall auto-xy"] = not FFlagHelpPageCCL,
            ["row align-x-right align-y-center gap-xsmall auto-y"] = FFlagHelpPageCCL and not tbl1.layoutOrderReversed,
            ["row align-x-left align-y-center gap-xsmall auto-y"] = FFlagHelpPageCCL and tbl1.layoutOrderReversed
        },
        Size = if FFlagHelpPageCCL then UDim2.fromOffset(xOffset, 0) else nil,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId .. "Container"
    }, var5)
end)

local var3 = React.memo(function(tbl1)
    local var3 = useTokens()
    local layoutOrder = if tbl1.layoutOrderReversed then 1 else 2
    local num2 = #tbl1.buttons + (if tbl1.addBlankIcon and tbl1.layoutOrderReversed then 1 else 0)
    local iconWidth = var3.Size.Size_600 * num2 + var3.Gap.XSmall * (num2 - 1)
    local bool1 = true
    for _, actionLabel in ipairs(tbl1.actionLabels) do
        if not actionLabel.disabled then
            bool1 = false
            break
        end
    end

    return React.createElement(ControlActionRow, {
        actionLabels = tbl1.actionLabels,
        layoutOrderReversed = tbl1.layoutOrderReversed,
        layoutOrder = tbl1.layoutOrder,
        iconWidth = iconWidth,
        testId = "GamepadActionText-" .. tbl1.testId,
        icon = React.createElement(var2, {
            buttons = tbl1.buttons,
            platform = tbl1.platform,
            addBlankIcon = tbl1.addBlankIcon,
            layoutOrderReversed = tbl1.layoutOrderReversed,
            isSpatial = tbl1.isSpatial,
            isDisabled = bool1,
            testId = "GamepadActionIcon-" .. tbl1.testId,
            LayoutOrder = layoutOrder
        })
    })
end)

local var4 = React.memo(function(tbl1)
    local var4, var5, var6 = React.useMemo(function()
        local tbl2 = {}
        local tbl3 = {}
        local tbl4 = {}

        for testId, control in tbl1.controls do
            if not control.gamepadInput then
                continue
            end

            local gamepadInput = control.gamepadInput
            local input = gamepadInput.input

            if input == nil then
                if tbl1.isSpatial then
                    input = gamepadInput.spatialGamepadInput
                elseif Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[tbl1.platform] then
                    input = gamepadInput.playstationInput
                else
                    input = gamepadInput.xboxInput
                end
            end

            if input == nil or not (#input > 0) then
                continue
            end

            local var4 = Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[input[1]]

            if tbl1.layoutOrderReversed then
                var4 = -var4
            end

            if FFlagHelpPageCCL then
                local createElement = React.createElement
                local var5 = var3
                local tbl5 = {
                    actionLabels = 0,
                    buttons = 0,
                    platform = 0,
                    layoutOrder = 0,
                    layoutOrderReversed = 0,
                    addBlankIcon = 0,
                    isSpatial = 0,
                    testId = 0,
                    key = 0
                }
                local actionLabels = control.actionLabels

                if not actionLabels then
                    actionLabels = {{
                        label = control.label
                    }}
                end

                tbl5.actionLabels = actionLabels

                tbl5.buttons = input
                tbl5.platform = tbl1.platform
                tbl5.layoutOrder = var4
                tbl5.layoutOrderReversed = tbl1.layoutOrderReversed
                tbl5.addBlankIcon = tbl1.addBlankIcon
                tbl5.isSpatial = tbl1.isSpatial
                tbl5.testId = testId
                tbl5.key = "ActionRow-" .. testId
                table.insert(tbl4, createElement(var5, tbl5))
            else
                local createElement = React.createElement
                local var5 = View
                local tbl5 = {
                    tag = "col align-y-center size-0-1000 auto-x",
                    LayoutOrder = var4,
                    key = "Text-" .. testId
                }
                local tbl6 = {
                    ActionText = React.createElement(var1, { action = control.label, testId = "GamepadActionText-" .. testId })
                }
                table.insert(tbl2, createElement(var5, tbl5, tbl6))

                local createElement2 = React.createElement
                local var6 = View
                local tbl7 = {
                    tag = "col align-y-center size-0-1000 auto-x",
                    LayoutOrder = var4,
                    key = "Icon-" .. testId
                }
                local tbl8 = {
                    IconContainer = React.createElement(var2, {
                        buttons = input,
                        platform = tbl1.platform,
                        addBlankIcon = tbl1.addBlankIcon,
                        layoutOrderReversed = tbl1.layoutOrderReversed,
                        isSpatial = tbl1.isSpatial,
                        testId = "GamepadActionIcon-" .. testId
                    })
                }
                table.insert(tbl3, createElement2(var6, tbl7, tbl8))
            end
        end

        return tbl2, tbl3, tbl4
    end, {
        tbl1.controls,
        tbl1.platform,
        tbl1.addBlankIcon,
        tbl1.layoutOrderReversed,
        tbl1.isSpatial
    })

    if FFlagHelpPageCCL then
        return React.createElement(View, { tag = "col gap-small size-full-0 auto-y" }, var6)
    end

    return React.createElement(View, { tag = "row gap-small auto-xy" }, {
        TextCol = React.createElement(View, {
            tag = {
                ["col align-x-right auto-xy"] = not tbl1.layoutOrderReversed,
                ["col align-x-left auto-xy"] = tbl1.layoutOrderReversed
            },
            LayoutOrder = if tbl1.layoutOrderReversed then 3 else 1
        }, var4),
        IconCol = React.createElement(View, { tag = "col auto-xy", LayoutOrder = 2 }, var5)
    })
end)

return React.memo(var4)
