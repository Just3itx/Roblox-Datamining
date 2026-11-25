-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot
local Foundation = require(ProfilePlatformParent.Foundation)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local useInspectAvatarTooltip = require(script.Parent.useInspectAvatarTooltip)

local FFlagProfileInspectAndBuyTooltipGamepadFocus = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyTooltipGamepadFocus)

local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local ButtonVariant = Foundation.Enums.ButtonVariant

return (React.forwardRef(function(tbl1, arg1)
    local var1 = useTokens()
    local var2 = useInspectAvatarTooltip()
    local var3 = useLocalization(
        {
            title = "Feature.Profile.Header.InspectAndBuy.Tooltip",
            body = "Feature.Profile.Description.InspectAndBuy"
        }
    )

    React.useImperativeHandle(arg1, function()
        return {
            onDismiss = var2.onDismiss
        }
    end, { var2.onDismiss })

    local var4 = if FFlagProfileInspectAndBuyTooltipGamepadFocus then useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isAutoFocusRoot = true,
        isFocusable = var2.showTooltip
    }) else nil
    local createElement = React.createElement
    local root = Popover.Root
    local tbl2 = {
        isOpen = var2.showTooltip
    }
    local tbl3 = {
        Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl1.anchorRef }),
        Content = 0
    }
    local createElement2 = React.createElement
    local content = Popover.Content
    local tbl4 = {
        side = PopoverSide.Right,
        align = PopoverAlign.Center,
        hasArrow = true,
        radius = Radius.Medium,
        backgroundStyle = var1.Color.System.Contrast
    }
    local tbl5 = { Layout = 0 }
    local createElement3 = React.createElement
    local var5 = View
    local tbl6 = {
        tag = "col gap-xsmall auto-y padding-medium",
        Size = UDim2.fromOffset(160, 0),
        ref = 0
    }

    if not FFlagProfileInspectAndBuyTooltipGamepadFocus then
        var4 = nil
    end

    tbl6.ref = var4
    tbl5.Layout = createElement3(var5, tbl6, {
        Header = React.createElement(View, {
            tag = "row flex-between align-y-center size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, { Text = var3.title, tag = "auto-xy text-title-large content-inverse-emphasis" }),
            CloseButton = React.createElement(
                IconButton,
                {
                    icon = IconName.X,
                    size = IconSize.Small,
                    onActivated = var2.onDismiss,
                    variant = ButtonVariant.OverMedia
                }
            )
        }),
        Body = React.createElement(FoundationText, {
            Text = var3.body,
            tag = "size-full-0 auto-y text-body-medium content-inverse-default",
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2
        })
    })
    tbl3.Content = createElement2(content, tbl4, tbl5)
    return createElement(root, tbl2, tbl3)
end))
