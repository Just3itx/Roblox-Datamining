-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local React = require(GamePlayButtonParent.React)
local Foundation = require(GamePlayButtonParent.Foundation)
local PopForcePickerModel = require(script.Parent.PopForcePickerModel)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Popover = Foundation.Popover
local IconName = Foundation.Enums.IconName

local tbl1 = {
    Color3 = Color3.fromRGB(66, 49, 17),
    Transparency = 0
}
local tbl2 = {
    Color3 = Color3.fromRGB(255, 222, 128),
    Transparency = 0
}
local brightYellow = Color3.fromRGB(255, 205, 77)

local function PickerRow(tbl3)
    local createElement = React.createElement
    local var1 = View
    local tbl4 = {
        LayoutOrder = tbl3.LayoutOrder,
        testId = tbl3.testId,
        onActivated = tbl3.onActivated,
        selection = { Selectable = true },
        backgroundStyle = if tbl3.selected then tbl1 else tbl3.tokens.Color.Surface.Surface_100,
        stroke = {
            Color = if tbl3.selected then brightYellow else tbl3.tokens.Color.Stroke.Default.Color3,
            Transparency = if tbl3.selected then 0 else 1,
            Thickness = tbl3.tokens.Stroke.Standard
        },
        tag = "row align-y-center gap-small size-full-0 auto-y padding-small radius-small"
    }

    local tbl5 = {
        Choice = React.createElement(Icon, {
            LayoutOrder = 1,
            name = IconName.Check,
            size = tbl3.tokens.Size.Size_400,
            style = not tbl3.selected and { Transparency = 1 } or tbl2,
            testId = tbl3.testId .. "-check"
        }),
        Location = 0,
        Ping = 0
    }
    local createElement2 = React.createElement
    local var2 = View
    local tbl6 = { LayoutOrder = 2, tag = "col fill gap-xxsmall size-0-0 auto-y" }

    local tbl7 = {
        Name = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl3.name,
            textStyle = if tbl3.selected then tbl2 else tbl3.tokens.Color.Content.Emphasis,
            tag = "size-full-0 auto-y text-label-medium text-wrap"
        }),
        Detail = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = tbl3.detail,
                tag = "size-full-0 auto-y text-body-small text-wrap content-muted"
            }
        )
    }
    tbl5.Location = createElement2(var2, tbl6, tbl7)

    tbl5.Ping = if tbl3.ping then React.createElement(
        FoundationText,
        {
            LayoutOrder = 3,
            Text = tbl3.ping,
            textStyle = tbl3.pingStyle,
            tag = "auto-xy text-label-small"
        }
    ) else nil
    return createElement(var1, tbl4, tbl5)
end

return React.memo(function(tbl3) -- name: PopForcePickerView
    local tokens = tbl3.tokens
    local bool1 = tbl3.forcedPop ~= ""
    local displayCode = PopForcePickerModel.getDisplayCode(tbl3.forcedPop)
    local tbl4 = {
        Auto = React.createElement(PickerRow, {
            LayoutOrder = 0,
            name = "Automatic matchmaking",
            detail = "Let Roblox choose a server",
            selected = not bool1,
            tokens = tokens,
            testId = "pop-picker-auto",
            onActivated = function()
                tbl3.onSelect("")
            end
        })
    }
    for layoutOrder, row in tbl3.rows do
        local var1

        if row.rttMs == nil then
            var1 = tokens.Color.Content.Muted
        elseif row.rttMs < 80 then
            var1 = tokens.Color.System.Success
        elseif row.rttMs < 160 then
            var1 = tokens.Color.System.Warning
        else
            var1 = tokens.Color.System.Alert
        end

        local popCode = row.popCode
        local createElement = React.createElement
        local func1 = PickerRow
        local tbl5 = {
            LayoutOrder = layoutOrder,
            name = PopForcePickerModel.getLocationName(row.popCode),
            detail = PopForcePickerModel.getDisplayCode(row.popCode),
            ping = PopForcePickerModel.formatPing(row.rttMs),
            pingStyle = var1,
            selected = row.popCode == tbl3.forcedPop,
            tokens = tokens,
            testId = "pop-picker-row-" .. row.popCode,
            onActivated = 0
        }

        function tbl5.onActivated()
            tbl3.onSelect(row.popCode)
        end

        tbl4[popCode] = createElement(func1, tbl5)
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var1 = nil
    local tbl5 = { Trigger = 0, Menu = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl6 = {
        LayoutOrder = tbl3.LayoutOrder,
        testId = "pop-force-picker",
        ref = tbl3.anchorRef,
        onActivated = tbl3.onToggleMenu,
        selection = { Selectable = true },
        backgroundStyle = if bool1 then tbl1 else tokens.Color.Surface.Surface_200,
        stroke = {
            Color = if bool1 then brightYellow else tokens.Color.Stroke.Default.Color3,
            Transparency = if bool1 then 0 else tokens.Color.Stroke.Default.Transparency,
            Thickness = tokens.Stroke.Standard
        },
        tag = "row align-y-center gap-xsmall auto-xy padding-small radius-small"
    }

    local tbl7 = { Label = 0, Chevron = 0 }
    local createElement3 = React.createElement
    local var3 = FoundationText
    local tbl8 = { LayoutOrder = 1, Text = 0, textStyle = 0, tag = "auto-xy text-label-small" }

    if not bool1 then
        displayCode = if tbl3.compact then "Auto" else "Server: Auto"
    end

    tbl8.Text = displayCode
    tbl8.textStyle = if bool1 then tbl2 else tokens.Color.Content.Emphasis
    tbl7.Label = createElement3(var3, tbl8)

    tbl7.Chevron = React.createElement(Icon, {
        LayoutOrder = 2,
        name = IconName.ChevronSmallDown,
        size = tokens.Size.Size_400,
        style = if bool1 then tbl2 else tokens.Color.Content.Emphasis
    })
    tbl5.Trigger = createElement2(var2, tbl6, tbl7)
    local var4

    if tbl3.isOpen then
        local createElement4 = React.createElement
        local root = Popover.Root
        local tbl9 = { isOpen = true }
        local tbl10 = {
            Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl3.anchorRef }),
            Content = 0
        }
        local createElement5 = React.createElement
        local content = Popover.Content
        local tbl11 = {
            side = {
                position = Foundation.Enums.PopoverSide.Bottom,
                offset = tokens.Padding.Small
            },
            align = Foundation.Enums.PopoverAlign.End,
            hasArrow = false,
            onPressedOutside = tbl3.onClose,
            backgroundStyle = tokens.Color.Surface.Surface_200,
            radius = Foundation.Enums.Radius.Medium,
            ref = tbl3.focusRef
        }
        local tbl12 = { MenuScroll = 0 }
        local createElement6 = React.createElement
        local scrollView = Foundation.ScrollView
        local tbl13 = {
            testId = "pop-picker-menu",
            Size = UDim2.fromOffset(tbl3.menuSize.X, tbl3.menuSize.Y),
            onAbsoluteCanvasSizeChanged = tbl3.onCanvasSizeChanged,
            scroll = {
                CanvasSize = UDim2.fromOffset(0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y
            }
        }
        local tbl14 = { Panel = 0 }
        local createElement7 = React.createElement
        local var5 = View
        local tbl15 = { tag = "col gap-small size-full-0 auto-y padding-medium" }

        local tbl16 = {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = "Choose your server location",
                tag = "size-full-0 auto-y text-label-large text-wrap content-emphasis"
            }),
            Subtitle = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = "Server ping · lowest first",
                tag = "size-full-0 auto-y text-body-small text-wrap content-muted"
            }),
            Rows = React.createElement(
                View,
                {
                    LayoutOrder = 3,
                    tag = "col gap-small size-full-0 auto-y",
                    padding = UDim.new(0, tokens.Stroke.Standard)
                },
                tbl4
            ),
            More = 0,
            Empty = 0,
            Error = 0,
            Hint = 0
        }
        local element

        if tbl3.hasMore then
            element = React.createElement(Foundation.Button, {
                LayoutOrder = 4,
                text = if tbl3.showAll then "Show closest five" else "Show all locations",
                variant = Foundation.Enums.ButtonVariant.Utility,
                size = Foundation.Enums.InputSize.Small,
                onActivated = tbl3.onToggleShowAll,
                testId = "pop-picker-show-all"
            })
        else
            element = nil
        end

        tbl16.More = element

        tbl16.Empty = if #tbl3.rows == 0 then React.createElement(FoundationText, {
            LayoutOrder = 5,
            Text = "No server ping samples yet. Reopen to refresh.",
            tag = "size-full-0 auto-y text-body-small text-wrap content-muted"
        }) else nil

        tbl16.Error = if tbl3.errorText then React.createElement(
            FoundationText,
            {
                LayoutOrder = 6,
                Text = tbl3.errorText,
                tag = "size-full-0 auto-y text-body-small text-wrap content-alert"
            }
        ) else nil

        tbl16.Hint = React.createElement(FoundationText, {
            LayoutOrder = 7,
            Text = "Applies to all experiences until you choose Auto or restart Roblox.",
            tag = "size-full-0 auto-y text-body-small text-wrap content-muted"
        })
        tbl14.Panel = createElement7(var5, tbl15, tbl16)
        tbl12.MenuScroll = createElement6(scrollView, tbl13, tbl14)
        tbl10.Content = createElement5(content, tbl11, tbl12)
        var4 = createElement4(root, tbl9, tbl10)
    else
        var4 = nil
    end

    tbl5.Menu = var4
    return createElement(fragment, var1, tbl5)
end)
