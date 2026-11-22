-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local formatNumber = require(scriptParentParent.Utility.formatNumber)
local logger = require(scriptParentParent.Utility.logger)

local React = require(scriptParentParentParent.React)

local UIBlox = require(scriptParentParentParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Foundation = require(scriptParentParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View

local VirtualItemBadgeType = require(scriptParentParent.Enums.VirtualItemBadgeType)

local ModelViewport = require(scriptParentParent.Generic.ModelViewport)
local YellowBadge = require(scriptParentParent.Generic.YellowBadge)

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization

local default = require(scriptParentParentParent.LoggingProtocol).default
local VirtualItemBadgeShownCounter = require(scriptParentParent.Generic.Events.VirtualItemBadgeCounter).VirtualItemBadgeShownCounter

local iconsStatusImageunavailable = Images["icons/status/imageunavailable"]

local function withMaxLength(itemName: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if #itemName > 50 then itemName:sub(1, 50) .. "..." else itemName
end

return function(tbl1)
    local var1 = useLocalization({ Popular = "IAPExperience.RobuxUpsell.Text.PopularItem" })

    local var2 = useTokens()
    local num1 = if tbl1.isPortrait then 128 else 80

    local xOffset, var3 = React.useState(0)
    local function updateComponentWidth(arg1)
        if not arg1 then
            return
        end
        local var4 = arg1.AbsoluteSize.X - num1 - 6
        if var4 ~= xOffset then
            var3(var4)
        end
    end

    local element

    if tbl1.model ~= nil then
        element = React.createElement(
            ModelViewport,
            {
                model = tbl1.model,
                Position = UDim2.fromOffset(5, 5),
                Size = UDim2.fromOffset(num1, num1)
            }
        )
    else
        element = React.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0, 5),
            Size = UDim2.new(0, num1, 0, num1),
            ScaleType = Enum.ScaleType.Stretch,
            Image = if tbl1.itemIcon then tbl1.itemIcon else iconsStatusImageunavailable,
            ImageColor3 = if tbl1.itemIcon then nil else var2.Color.Content.Default.Color3,
            ImageTransparency = if tbl1.itemIcon then nil else var2.Color.Content.Default.Transparency
        })
    end

    local itemBadge = if tbl1.badgeType and tbl1.badgeType == VirtualItemBadgeType.Popular then React.createElement(YellowBadge, { LayoutOrder = 2, Text = var1.Popular, Icon = "icons/menu/fire_fill" }) else nil

    React.useEffect(function()
        if not itemBadge then
            return
        end
        logger.debug({ message = "Virtual Item Badge Shown", badgeType = tbl1.badgeType })

        default:logRobloxTelemetryCounter(VirtualItemBadgeShownCounter, 1, { badgeType = tbl1.badgeType })
    end, {})

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        tag = "auto-y row gap-small align-y-center align-x-left"
    }
    local tbl3 = { ItemIcon = element, ItemDetailsFrame = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        LayoutOrder = 2,
        onAbsoluteSizeChanged = updateComponentWidth,
        Size = UDim2.new(1, 0, 0, 0),
        tag = "col auto-y gap-small"
    }
    local tbl5 = {
        ItemName = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Size = UDim2.new(0, xOffset, 0, 0),
            Text = withMaxLength(tbl1.itemName),
            tag = "auto-y text-align-x-left text-wrap text-title-medium content-emphasis"
        }),
        ItemDetails = React.createElement(View, {
            LayoutOrder = 2,
            tag = if tbl1.isPortrait then "auto-xy col gap-small align-y-center" else "auto-xy row gap-small align-y-center"
        }, {
            ItemCost = if tbl1.itemRobuxCost then React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.itemRobuxCost),
                tag = "auto-xy text-align-x-left text-wrap text-title-medium content-emphasis"
            }) else nil,
            ItemBadge = itemBadge
        })
    }
    tbl3.ItemDetailsFrame = createElement2(var5, tbl4, tbl5)
    return createElement(var4, tbl2, tbl3)
end
