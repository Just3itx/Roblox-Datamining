-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local SessionService = game:GetService("SessionService")
local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Signals = require(AvatarSwitcherParent.Signals)
local SignalsReact = require(AvatarSwitcherParent.SignalsReact)

local AvatarExperienceAnalytics = require(AvatarSwitcherParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums

local UnifiedLoggingSurface = require(AvatarSwitcherParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local _types = require(AvatarSwitcher.types)

local FFlagAvatarSwitcherUseAvatarInventoryEndpoint = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherUseAvatarInventoryEndpoint
local FFlagAXUnifiedEventStrictPayloads = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads
local FFlagAXBackgroundsInOutfitThumbnails = require(AvatarSwitcherParent.SharedFlags).FFlagAXBackgroundsInOutfitThumbnails

return React.memo(function(tbl1) -- name: OutfitTile
    local var1 = SignalsReact.useSignalState(getAvatarSwitcherStore)
    local ref = React.useRef(nil)
    local var3 = useTokens()

    local id = tbl1.outfitInfo.id

    React.useEffect(function()
        task.delay(0, function()
            addUnifiedEventLogging(ref, {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
                surface = UnifiedLoggingSurface.IN_EXPERIENCE_AVATAR_SWITCHER,
                gridPositionRow = tbl1.gridPosition.row,
                gridPositionColumn = tbl1.gridPosition.column,
                itemId = if FFlagAXUnifiedEventStrictPayloads then if id then tostring(id) else nil else id,
                elementName = "OUTFIT_TILE"
            }, {
                sessionTagName = SessionService:GetSessionTag("level2a")
            })
        end)
    end, { tbl1.gridPosition, id })

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not (id == nil) and var1.getSelectedOutfitId(arg1) == id
        end)
    end, { var1, id })
    local var5 = SignalsReact.useSignalState(var4) and not tbl1.disabled

    local var6 = React.useCallback(function()
        var1.selectOutfit(id)
    end, { var1, id })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "col gap-small auto-y size-full-0",
        GroupTransparency = if tbl1.disabled then 0.5 else nil,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Thumbnail = 0, ThumbnailShimmer = 0, NameLabel = 0, NameLabelShimmer = 0 }
    local var7

    if id then
        local createElement2 = React.createElement
        local image = Foundation.Image
        local tbl4 = {
            tag = {
                [if FFlagAvatarSwitcherUseAvatarInventoryEndpoint then "radius-medium bg-shift-200 padding-small" else "radius-medium bg-shift-200"] = true,
                ["stroke-standard stroke-system-contrast"] = var5
            },
            Size = UDim2.fromScale(1, 1.5),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Image = if FFlagAXBackgroundsInOutfitThumbnails then `rbxthumb://type=Outfit&id={id}&w=150&h=150&includeBackground=true` else `rbxthumb://type=Outfit&id={id}&w=150&h=150`,
            ScaleType = Enum.ScaleType.Crop,
            LayoutOrder = 1,
            onActivated = 0,
            ref = 0
        }
        if tbl1.disabled then
            var6 = nil
        end

        tbl4.onActivated = var6
        tbl4.ref = ref
        var7 = createElement2(image, tbl4, {
            WarningIcon = FFlagAvatarSwitcherUseAvatarInventoryEndpoint
                and tbl1.outfitInfo.hasWarning
                and React.createElement(
                    Foundation.Image,
                    {
                        tag = "size-500",
                        imageStyle = not var5 and { Transparency = 0.5 } or nil,
                        Image = "icons/actions/info"
                    }
                )
        })
    else
        var7 = id
    end

    tbl3.Thumbnail = var7

    tbl3.ThumbnailShimmer = not id
        and React.createElement(
            Foundation.View,
            {
                Size = UDim2.fromScale(1, 1.5),
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                LayoutOrder = 1
            },
            {
                Shimmer = React.createElement(Foundation.Skeleton, { Size = UDim2.fromScale(1, 1) })
            }
        )

    tbl3.NameLabel = tbl1.outfitInfo.name
        and React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-align-x-left text-title-small content-emphasis text-wrap",
            Text = tbl1.outfitInfo.name,
            LayoutOrder = 2
        })

    tbl3.NameLabelShimmer = not tbl1.outfitInfo.name
        and React.createElement(Foundation.Skeleton, { Size = UDim2.new(1, 0, 0, var3.FontSize.FontSize_300), LayoutOrder = 2 })
    return (createElement(view, tbl2, tbl3))
end)
