-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local UIBlox = require(AvatarExperienceCommonParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local ItemCardComponents = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).ItemCardComponents

local ItemCardIcon = ItemCardComponents.ItemCardIcon
local ItemCardBadge = ItemCardComponents.ItemCardBadge
local Responsive = require(AvatarExperienceCommonParent.Responsive)
local useLastInput = Responsive.useLastInput
local useIsSpatial = Responsive.useIsSpatial
local useSelectedOverlayButton = require(script.Parent.useSelectedOverlayButton)

local FFlagAXInventoryDurablesSupport = AvatarExperienceFlags.FFlagAXInventoryDurablesSupport
local FFlagAXFixBadgeStatusConfigOptions = AvatarExperienceFlags.FFlagAXFixBadgeStatusConfigOptions
local FFlagAXShowFaeUpsell = AvatarExperienceFlags.FFlagAXShowFaeUpsell
local FFlagAXMarketplaceItemCardIndicatorStack = AvatarExperienceFlags.FFlagAXMarketplaceItemCardIndicatorStack

local function func1(badge)
    local tbl1 = {{
        type = "icon",
        icon = badge.icon
    }}

    if badge.text then
        table.insert(tbl1, { type = "text", text = badge.text })
    end

    return tbl1
end

local function CatalogItemCardSelectedOverlay(tbl1)
    local var1 = useTokens()
    local isVisible, var2, yOffset

    if FFlagAXMarketplaceItemCardIndicatorStack then
        local var3 = useSelectedOverlayButton(tbl1.buttonText ~= nil)
        isVisible = var3.isVisible
        var2 = var3.bottomOffset
        yOffset = var3.height
    else
        local var3 = useLastInput()
        local var4 = useIsSpatial()
        local bool1 = var3 == Responsive.Input.Directional and not var4
        var2 = var1.Gap.XXSmall
        yOffset = var1.Size.Size_700
        isVisible = not bool1
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2
    }
    local tbl3 = {
        CatalogItemCardSelectedOverlayCornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        CatalogItemCardSelectedOverlayStroke = 0,
        CatalogItemCardSelectedOverlayBadge = 0,
        CatalogItemCardSelectedOverlayItemStatusIcon = 0,
        CatalogItemCardSelectedOverlayButton = 0
    }
    local element

    if tbl1.suppressBorder then
        element = nil
    else
        element = React.createElement("UIStroke", {
            Color = var1.Color.Content.Emphasis.Color3,
            Transparency = var1.Color.Content.Emphasis.Transparency,
            Thickness = var1.Stroke.Standard,
            LineJoinMode = Enum.LineJoinMode.Round,
            [React.Tag] = "data-testid=selection-stroke"
        })
    end

    tbl3.CatalogItemCardSelectedOverlayStroke = element
    local element2

    if tbl1.badge then
        element2 = React.createElement(
            View,
            {
                tag = "padding-top-small padding-left-small",
                Size = UDim2.fromScale(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY
            },
            {
                Badge = React.createElement(ItemCardBadge, {
                    content = not (FFlagAXFixBadgeStatusConfigOptions or FFlagAXShowFaeUpsell)
                        and {
                            {
                                type = "icon",
                                icon = tbl1.badge.icon
                            },
                            {
                                type = "text",
                                text = tbl1.badge.text
                            }
                        }
                        or func1(tbl1.badge),
                    displayBorder = true
                })
            }
        )
    else
        element2 = nil
    end

    tbl3.CatalogItemCardSelectedOverlayBadge = element2

    tbl3.CatalogItemCardSelectedOverlayItemStatusIcon = if FFlagAXInventoryDurablesSupport and tbl1.itemStatusIcon and not tbl1.badge then React.createElement(
        View,
        {
            tag = "padding-top-small padding-left-small",
            Size = UDim2.fromScale(0, 0),
            AutomaticSize = Enum.AutomaticSize.XY
        },
        {
            Icon = React.createElement(ItemCardIcon, { icon = tbl1.itemStatusIcon })
        }
    ) else nil
    local element3

    if isVisible and tbl1.buttonText then
        element3 = React.createElement(Button, {
            text = tbl1.buttonText,
            buttonType = ButtonType.PrimarySystem,
            onActivated = tbl1.onActivated,
            isDisabled = false,
            anchorPoint = Vector2.new(0.5, 1),
            position = UDim2.new(0.5, 0, 1, -var2),
            size = UDim2.new(1, -(var1.Gap.XXSmall * 2), 0, yOffset),
            fontStyle = "CaptionHeader"
        })
    else
        element3 = nil
    end

    tbl3.CatalogItemCardSelectedOverlayButton = element3
    return createElement(str1, tbl2, tbl3)
end

return CatalogItemCardSelectedOverlay
