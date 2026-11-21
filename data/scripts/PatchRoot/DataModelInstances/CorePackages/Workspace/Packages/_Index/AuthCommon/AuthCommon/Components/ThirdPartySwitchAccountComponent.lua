-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local React = require(AuthCommonParent.React)
local Foundation = require(AuthCommonParent.Foundation)

local DividerWithText = require(AuthCommon.Components.DividerWithText)
local useLocalization = require(AuthCommonParent.Localization).Hooks.useLocalization
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()
    local onActivated = React.useCallback(function()
        if tbl1.onActivated then
            tbl1.onActivated()
        end
        if ThirdPartyUserService then
            ThirdPartyUserService:ShowAccountPicker()
        end
    end, { tbl1.onActivated })

    local var3 = useLocalization({ dividerText = tbl1.dividerTextKey, labelText = tbl1.labelTextKey })

    local selection = {
        Selectable = not tbl1.isDisabled,
        NextSelectionUp = tbl1.nextSelectionUp
    }

    if tbl1.labelTextKey then
        local scale = var1.Config.UI.Scale
        local tag = if tbl1.isDisabled then "content-inverse-default" else "content-emphasis"
        return React.createElement(View, {
            LayoutOrder = tbl1.layoutOrder,
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 10 * scale)
            },
            tag = "auto-xy"
        }, {
            Label = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = var3.labelText,
                    tag = "auto-xy text-title-medium content-default"
                }
            ),
            SwitchAccountButton = React.createElement(View, {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(0, var1.Size.Size_1200),
                padding = Vector2.new(13 * scale, 0),
                ref = tbl1.buttonRef,
                testId = "--auth-platform-account-switch-button",
                selection = selection,
                isDisabled = tbl1.isDisabled,
                onActivated = onActivated,
                tag = "row align-y-center gap-small auto-x radius-medium bg-over-media-0"
            }, {
                Image = React.createElement(Image, {
                    LayoutOrder = 1,
                    Image = "rbxasset://textures/ui/Shell/Icons/PlatformLogo.png",
                    Size = UDim2.fromOffset(var1.Size.Size_600, var1.Size.Size_600),
                    tag = tag
                }),
                TextWrapper = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "auto-xy padding-right-xsmall"
                }, {
                    Text = React.createElement(FoundationText, { Text = tbl1.thirdPartyUserName, tag = "auto-xy text-label-large " .. tag })
                })
            })
        })
    end

    local str1, str2

    if tbl1.isDisabled then
        str1 = "stroke-muted"
        str2 = "content-inverse-default"
    else
        str1 = "stroke-action-subtle"
        str2 = "content-default"
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col align-x-center gap-xxlarge size-full-0 auto-xy"
        },
        {
            Divider = React.createElement(DividerWithText, {
                layoutOrder = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                size = UDim2.new(1, 0, 0, 0),
                width = 0,
                height = 0,
                font = var1.Typography.CaptionSmall.Font,
                fontSize = var1.Typography.CaptionSmall.FontSize,
                color3 = var1.Color.Content.Muted.Color3,
                transparency = var1.Color.Content.Muted.Transparency,
                text = if var3 then var3.dividerText else "",
                padding = var1.Size.Size_800
            }),
            SwitchAccountButton = React.createElement(View, {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, var1.Size.Size_1200),
                tag = "row gap-medium align-y-center align-x-center radius-medium " .. str1,
                ref = tbl1.buttonRef,
                testId = "--auth-platform-account-switch-button",
                selection = selection,
                isDisabled = tbl1.isDisabled,
                onActivated = onActivated
            }, {
                Image = React.createElement(Image, {
                    LayoutOrder = 0,
                    Image = "rbxasset://textures/ui/Shell/Icons/PlatformLogo.png",
                    Size = UDim2.fromOffset(var1.Size.Size_400, var1.Size.Size_400),
                    tag = "align-x-center align-x-left align-y-center " .. str2
                }),
                Text = React.createElement(FoundationText, { LayoutOrder = 1, Text = tbl1.thirdPartyUserName, tag = "auto-xy " .. str2 })
            })
        }
    )
end
