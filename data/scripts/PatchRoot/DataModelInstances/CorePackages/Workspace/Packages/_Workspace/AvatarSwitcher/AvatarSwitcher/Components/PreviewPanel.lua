-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")

local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local SignalsReact = require(AvatarSwitcherParent.SignalsReact)
local InventoryItemAvailability = require(AvatarSwitcherParent.AvatarExperienceSlotBasedEditor).Enums.InventoryItemAvailability

local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local SwitchAvatarButton = require(AvatarSwitcher.Components.SwitchAvatarButton)
local AvatarPreview = require(AvatarSwitcher.Components.AvatarPreview)
local AvatarCompatibilityWarning = require(AvatarSwitcher.Components.AvatarCompatibilityWarning)
local OutfitViewportUtils = require(AvatarSwitcher.Components.OutfitViewport.OutfitViewportUtils)
local ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)

local FFlagAvatarSwitcherAccurateAvatarWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherAccurateAvatarWarning
local FFlagAvatarSwitcherWarningLayoutFix = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherWarningLayoutFix

local FFlagAvatarSwitcherExpiredItemsWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherExpiredItemsWarning

local function PreviewPanel(tbl1)
    local var1 = SignalsReact.useSignalState(getAvatarSwitcherStore)
    local outfitId = SignalsReact.useSignalState(var1.getSelectedOutfitId)
    local var3 = SignalsReact.useSignalState(var1.getSelectedOutfitDetails)
    local var4 = SignalsReact.useSignalState(var1.getExperienceAvatarSupportType)
    local var5 = SignalsReact.useSignalState(var1.getExperienceAvatarType)
    local var6 = useTokens()

    local onActivated = React.useCallback(function()
        var1.toggleRespawnPrompt(true)
    end, {})

    local var8 = nil
    local var9 = nil
    local var10

    if FFlagAvatarSwitcherAccurateAvatarWarning then
        local var11
        var8, var11 = React.useState(false)
        var9 = var11
        var10 = React.useCallback(function(arg1, arg2)
            local var12 = not (var3 and var3.assetIds) and {} or var3.assetIds

            local var13 = OutfitViewportUtils.hasMissingAssetsInDescription(arg2, var12)

            local var14 = OutfitViewportUtils.hasMissingAccessoriesInHumanoid(arg1, arg2)
            var9(var13 or var14)
        end, { var3 })
        React.useEffect(function()
            var9(false)
        end, { outfitId })
    else
        var10 = nil
    end

    local rigType = if var5 == Enum.HumanoidRigType.R6 then Enum.HumanoidRigType.R6 elseif var3 then var3.rigType else nil
    local var12 = not (var3 == nil) and (var3.rigType ~= rigType or FFlagAvatarSwitcherAccurateAvatarWarning and var8)
    local var13

    if FFlagAvatarSwitcherExpiredItemsWarning then
        local var14 = var3 and var3.availabilityStatus == InventoryItemAvailability.PartiallyAvailableWithExpiredSubitems
        var13 = if var12 then "Feature.AvatarSwitcher.Message.PartiallyUnsupported" elseif var14 then "Feature.AvatarSwitcher.Message.ExpiredItems" else nil
    else
        var13 = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = if FFlagAvatarSwitcherWarningLayoutFix then "size-full-full padding-x-xlarge padding-y-medium col gap-small" else "size-full-full padding-x-xlarge padding-y-medium col"
    }

    local tbl3 = { Content = 0, AvatarCompatibilityWarning = 0, BottomButtonContainer = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "size-full-0 fill", LayoutOrder = 1 }

    local tbl5 = { AvatarPreview = 0, FloatingButtonContainer = 0, FloatingBottomContainer = 0 }
    local createElement3 = React.createElement
    local var14 = AvatarPreview
    local tbl6 = {
        outfitId = outfitId,
        rigType = rigType,
        imageScaleType = if tbl1.compactLayout then Enum.ScaleType.Fit else Enum.ScaleType.Crop,
        showAvatarSupportWarning = var4 == ExperienceAvatarSupportType.UnknownSupport,
        showAvatarTypeCompatibilityWarning = if FFlagAvatarSwitcherWarningLayoutFix then nil else var12,
        messageBottomPadding = if tbl1.compactLayout then var6.Size.Size_800 + var6.Gap.Medium else var6.Gap.Medium,
        onAvatarPreviewLoaded = 0
    }

    if not FFlagAvatarSwitcherAccurateAvatarWarning then
        var10 = nil
    end

    tbl6.onAvatarPreviewLoaded = var10
    tbl5.AvatarPreview = createElement3(var14, tbl6)

    tbl5.FloatingButtonContainer = not FFlagAvatarSwitcherWarningLayoutFix
        and tbl1.compactLayout
        and React.createElement(
            Foundation.View,
            { tag = "auto-xy position-bottom-right anchor-bottom-right", LayoutOrder = 2 },
            {
                SizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(100, 0) }),
                SwitchButton = React.createElement(SwitchAvatarButton, { onActivated = onActivated })
            }
        )

    local compactLayout = FFlagAvatarSwitcherWarningLayoutFix and tbl1.compactLayout

    if compactLayout then
        local createElement4 = React.createElement
        local view3 = Foundation.View
        local tbl7 = {
            tag = "size-full-0 auto-y position-bottom-left anchor-bottom-left row gap-small align-x-right align-y-bottom"
        }
        local tbl8 = { AvatarCompatibilityWarningContainer = 0, FloatingButtonContainer = 0 }
        local var15 = if FFlagAvatarSwitcherExpiredItemsWarning then var13 else var12

        if var15 then
            local createElement5 = React.createElement
            local view4 = Foundation.View
            local tbl9 = { tag = "grow auto-y", LayoutOrder = 1 }

            local tbl10 = {
                AvatarCompatibilityWarning = React.createElement(
                    AvatarCompatibilityWarning,
                    {
                        message = if FFlagAvatarSwitcherExpiredItemsWarning then var13 else nil
                    }
                )
            }
            var15 = createElement5(view4, tbl9, tbl10)
        end

        tbl8.AvatarCompatibilityWarningContainer = var15

        tbl8.FloatingButtonContainer = React.createElement(
            Foundation.View,
            { tag = "auto-xy position-bottom-right anchor-bottom-right", LayoutOrder = 2 },
            {
                SizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(100, 0) }),
                SwitchButton = React.createElement(SwitchAvatarButton, { onActivated = onActivated })
            }
        )
        compactLayout = createElement4(view3, tbl7, tbl8)
    end

    tbl5.FloatingBottomContainer = compactLayout
    tbl3.Content = createElement2(view2, tbl4, tbl5)

    local var15 = FFlagAvatarSwitcherWarningLayoutFix and not tbl1.compactLayout

    if var15 then
        if FFlagAvatarSwitcherExpiredItemsWarning then
            var12 = var13
        end
        if var12 then
            local createElement4 = React.createElement
            local var16 = AvatarCompatibilityWarning
            local tbl7 = { LayoutOrder = 2, message = 0 }

            if not FFlagAvatarSwitcherExpiredItemsWarning then
                var13 = nil
            end

            tbl7.message = var13
            var12 = createElement4(var16, tbl7)
        end
    else
        var12 = var15
    end

    tbl3.AvatarCompatibilityWarning = var12

    tbl3.BottomButtonContainer = not tbl1.compactLayout
        and React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y",
                LayoutOrder = if FFlagAvatarSwitcherWarningLayoutFix then 3 else 2
            },
            {
                SwitchButton = React.createElement(SwitchAvatarButton, { onActivated = onActivated })
            }
        )
    return (createElement(view, tbl2, tbl3))
end

return PreviewPanel
