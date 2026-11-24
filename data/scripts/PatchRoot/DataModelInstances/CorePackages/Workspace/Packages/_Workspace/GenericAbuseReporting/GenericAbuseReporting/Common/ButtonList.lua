-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Cryo = require(GenericAbuseReportingParent.Cryo)
local React = require(GenericAbuseReportingParent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local Icon = Foundation.Icon
local InputLabel = Foundation.InputLabel
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local ControlState = Foundation.Enums.ControlState
local InputLabelSize = Foundation.Enums.InputLabelSize
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local function createButtons<T>(tbl1, arg1, callback: (...any) -> (...any), callback2: ((...any) -> (...any))?, defaultValue: string?)
    local var1 = useTokens()
    local buttons = {}
    local var2, var3 = React.useState(defaultValue or "")
    for k, value in pairs(tbl1) do
        local var4, onHover = React.useState(false)

        local onActivated = React.useCallback(function()
            var3(value.value)
            callback(value.value, value.text)
            if callback2 then
                callback2(arg1[value.value])
            end
            onHover(true)
        end, { callback, callback2, onHover })

        local onStateChanged = React.useCallback(function(arg2)
            if arg2 == ControlState.Hover or arg2 == ControlState.Pressed then
                onHover(true)
                return
            end
            onHover(false)
        end, { onHover, onActivated })

        local createElement = React.createElement
        local var8 = View
        local tbl2 = { tag = "auto-xy col gap-xsmall padding-bottom-xsmall" }

        local tbl3 = { ButtonContainer = 0, Divider = 0 }
        local createElement2 = React.createElement
        local var9 = View
        local tbl4 = {
            tag = "size-full-0 auto-y radius-medium row flex-between",
            onStateChanged = onStateChanged,
            onActivated = onActivated
        }
        local tbl5 = {
            UIPadding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            }),
            Button = React.createElement(InputLabel, {
                Text = value.text,
                textStyle = if var4 then var1.Color.Content.Emphasis else var1.Color.Content.Default,
                onActivated = onActivated,
                onHover = onHover,
                size = InputLabelSize.Medium
            }),
            Icon = if value.value == var2 then React.createElement(Icon, { name = "icons/status/success_small", size = IconSize.Small }) else nil
        }
        tbl3.ButtonContainer = createElement2(var9, tbl4, tbl5)

        tbl3.Divider = React.createElement(View, {
            tag = "size-full-0 auto-y",
            stroke = {
                Thickness = 0.5,
                Color = var1.Color.Content.Default.Color3,
                Transparency = if next(tbl1, k) == nil then 1 else var1.Color.Content.Default.Transparency or 1
            }
        })
        table.insert(buttons, createElement(var8, tbl2, tbl3))
    end

    return buttons
end

local function ButtonList(tbl1)
    local var1 = React.useMemo(function()
        return Cryo.Dictionary.map(tbl1.options, function(arg1)
            return arg1.localizationKey, arg1.value
        end)
    end)

    local var2 = React.useMemo(function()
        return Cryo.Dictionary.map(tbl1.options, function(arg1)
            return arg1.descriptionLocalizationKey, arg1.value
        end)
    end)

    local var3 = useLocalization(var1)
    local var4 = useLocalization(var2)

    local var5 = React.useMemo(function()
        return Cryo.List.map(tbl1.options, function(arg1)
            return {
                text = var3[arg1.value] or "",
                value = arg1.value
            }
        end)
    end, { tbl1.options, var3 })

    local buttons = createButtons(var5, var4, tbl1.onSelected, tbl1.setDescription, tbl1.defaultValue)

    return React.createElement(View, { tag = "size-full col" }, { buttons })
end

return ButtonList
