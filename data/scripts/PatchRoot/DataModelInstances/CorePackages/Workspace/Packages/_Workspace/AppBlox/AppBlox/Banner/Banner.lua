-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Cryo = require(AppBloxParent.Cryo)
local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)

local Button = Foundation.Button
local BannerBadge = require(script.Parent.BannerBadge)
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image

local tbl1 = {
    isContained = true,
    width = UDim.new(1, 0),
    tags = { container = "col auto-y" }
}

return React.memo(function(tbl2) -- name: Banner
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local str1 = "col auto-y"
    if var1.isContained then
        str1 ..= " radius-medium padding-large stroke-standard stroke-default bg-shift-100"
    end

    local var2 = var1.badges and #var1.badges > 0
    local buttons = var1.buttons

    if buttons then
        if #var1.buttons < 2 then
            buttons = not (var1.image or var1.body or var2 or var1.onDismiss)
        else
            buttons = false
        end
    end

    local var3 = React.useMemo(function()
        local result = ({})
        if var1.buttons and #var1.buttons > 0 then
            for k, button in var1.buttons do
                local var3 = "banner-button-" .. k
                result[var3] = React.createElement(
                    Button,
                    Cryo.Dictionary.join(
                        {
                            LayoutOrder = k + 1,
                            size = Foundation.Enums.InputSize.Small,
                            testId = "--banner-button-" .. k
                        },
                        button
                    )
                )
            end
        end
        return result
    end, { var1.buttons })

    local var4 = React.useMemo(function()
        local result = ({})
        if var1.badges then
            for i, value in ipairs(var1.badges) do
                local var4 = "banner-badge-" .. i
                result[var4] = React.createElement(BannerBadge, Cryo.Dictionary.join({ testId = "--banner-badge-" .. i, LayoutOrder = i + 1 }, value))
            end
        end

        return result
    end, { var1.badges })

    local var5 = React.useMemo(function()
        if not var1.onDismiss then
            return nil
        end
        return (React.createElement(IconButton, {
            testId = if var2 then "--banner-badges-dismiss" else "--banner-dismiss",
            LayoutOrder = if var2 then 1 else 3,
            icon = Foundation.Enums.IconName.XSmall,
            isCircular = true,
            variant = Foundation.Enums.ButtonVariant.Utility,
            onActivated = var1.onDismiss
        }))
    end, { var1.onDismiss, var2 })

    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        LayoutOrder = var1.LayoutOrder,
        Size = UDim2.new(var1.width.Scale, var1.width.Offset, 0, 0),
        testId = "--banner",
        tag = str1
    }
    local tbl4 = {
        BadgesRow = if var2 then React.createElement(
            View,
            {
                tag = "row auto-y size-full-0 flex-between gap-large align-y-center padding-bottom-large",
                LayoutOrder = 2
            },
            {
                Badges = React.createElement(View, { LayoutOrder = 1, testId = "--banner-badges", tag = "row auto-xy gap-small fill" }, var4),
                Dismiss = if var5 then React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, { Dismiss = var5 }) else nil
            }
        ) else nil,
        ContentRow = 0
    }

    local createElement2 = React.createElement
    local var7 = View
    local tbl5 = {
        tag = { ["row auto-y size-full-0 gap-large"] = true, ["align-y-center"] = buttons },
        LayoutOrder = 3
    }

    local tbl6 = {
        Icon = if var1.icon and not var1.image then React.createElement(Icon, {
            testId = "--banner-icon",
            LayoutOrder = 1,
            size = Foundation.Enums.IconSize.Large,
            name = var1.icon,
            variant = var1.iconVariant,
            style = var1.iconStyle
        }) else nil,
        Image = if var1.image then React.createElement(View, {
            tag = "auto-xy flex-none bg-shift-100 radius-medium"
        }, {
            Image = React.createElement(
                Image,
                {
                    Image = var1.image,
                    testId = "--banner-image",
                    tag = "size-1800",
                    ScaleType = Enum.ScaleType.Fit
                }
            )
        }) else nil,
        Content = 0,
        Dismiss = 0
    }

    local createElement3 = React.createElement
    local var8 = View
    local tbl7 = {
        LayoutOrder = 2,
        tag = {
            ["auto-xy gap-small align-x-left fill"] = true,
            ["col flex-fill"] = not buttons,
            ["row align-y-center flex-between"] = buttons
        }
    }
    local tbl8 = {
        Title = React.createElement(FoundationText, {
            Text = var1.title,
            testId = "--banner-title",
            tag = "auto-xy text-title-medium content-emphasis fill text-wrap text-align-x-left",
            LayoutOrder = 1
        }),
        InlineButton = if buttons and var1.buttons and var1.buttons[1] then React.createElement(
            Button,
            Cryo.Dictionary.join({ tag = "auto-xy shrink", LayoutOrder = 2, testId = "--banner-button-inline" }, var1.buttons[1])
        ) else nil,
        Subcontent = 0
    }
    local element2

    if buttons then
        element2 = nil
    else
        element2 = React.createElement(View, {
            tag = "auto-xy col gap-large shrink",
            LayoutOrder = 2
        }, {
            Body = if var1.body then React.createElement(FoundationText, {
                testId = "--banner-body",
                Text = var1.body,
                tag = "auto-xy text-body-medium content-default text-wrap text-align-x-left",
                LayoutOrder = 1,
                RichText = true
            }) else nil,
            Buttons = React.createElement(
                View,
                {
                    tag = "row auto-xy grow gap-small wrap",
                    LayoutOrder = 2,
                    testId = "--banner-buttons"
                },
                var3
            )
        })
    end

    tbl8.Subcontent = element2
    tbl6.Content = createElement3(var8, tbl7, tbl8)

    if var2 then
        var5 = nil
    end

    tbl6.Dismiss = var5
    tbl4.ContentRow = createElement2(var7, tbl5, tbl6)
    return createElement(var6, tbl3, tbl4)
end)
