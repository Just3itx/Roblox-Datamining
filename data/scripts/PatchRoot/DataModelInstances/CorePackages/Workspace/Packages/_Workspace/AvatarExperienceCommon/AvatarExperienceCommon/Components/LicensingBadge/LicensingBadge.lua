-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization
local useEarlyIsFocused = require(AvatarExperienceCommonParent.Navigation).useEarlyIsFocused

local AXTooltip = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).AXTooltipComponents.AXTooltip

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXMarketplaceLicensingItemDetails = AvatarExperienceFlags.FFlagAXMarketplaceLicensingItemDetails
local FFlagAXMarketplaceLicensingItemCards = AvatarExperienceFlags.FFlagAXMarketplaceLicensingItemCards

local ItemLicenseType = require(AvatarExperienceCommonParent.AvatarExperienceModel).Enums.ItemLicenseType

local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeSize = Foundation.Enums.BadgeSize
local BadgeShape = Foundation.Enums.BadgeShape

local tbl1 = {
    [ItemLicenseType.FirstParty] = {
        label = "Feature.Catalog.Label.LicensingOfficial",
        info = "Feature.Catalog.Label.LicensingOfficialInfo",
        passiveVariant = BadgeVariant.Contrast
    },
    [ItemLicenseType.ThirdParty] = {
        label = "Feature.Catalog.Label.LicensingLicensed",
        info = "Feature.Catalog.Label.LicensingLicensedInfo",
        passiveVariant = BadgeVariant.OverMedia
    }
}

local function PassiveLicensingBadge(arg1)
    local var1 = useLocalization({ label = arg1.config.label })

    return React.createElement(Foundation.Badge, {
        text = var1.label,
        variant = arg1.config.passiveVariant,
        size = arg1.passiveSize or BadgeSize.Small,
        LayoutOrder = arg1.LayoutOrder,
        onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
        testId = "LicensingBadge"
    })
end

local function InteractiveLicensingBadge(arg1)
    local var1 = useTokens()
    local isOpen, var3 = React.useState(false)

    local var4 = useLocalization({ label = arg1.config.label, info = arg1.config.info })

    local onActivated = React.useCallback(function()
        var3(function(arg2): boolean
            return not arg2
        end)
    end, {})

    local onTooltipActivated = React.useCallback(function()
        var3(false)
    end, {})

    React.useImperativeHandle(arg1.dismissTooltipRef, function()
        return onTooltipActivated
    end, { onTooltipActivated })

    if FFlagAXMarketplaceLicensingItemDetails then
        local var7 = useEarlyIsFocused()

        React.useEffect(function()
            if not var7 then
                onTooltipActivated()
            end
        end, { var7, onTooltipActivated })
    end

    return React.createElement(Foundation.View, {
        tag = "auto-xy",
        LayoutOrder = arg1.LayoutOrder,
        onActivated = onActivated,
        onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged,
        testId = "LicensingBadge"
    }, {
        Badge = React.createElement(
            Foundation.Badge,
            {
                text = var4.label,
                variant = BadgeVariant.Standard,
                size = BadgeSize.Small,
                shape = BadgeShape.Box
            }
        ),
        Tooltip = React.createElement(AXTooltip, {
            isOpen = isOpen,
            popoverSide = arg1.popoverSide or "Bottom",
            tooltipText = var4.info,
            maxWidth = var1.Size.Size_1200 * 3,
            onTooltipActivated = onTooltipActivated
        })
    })
end

return React.memo(function(tbl2) -- name: LicensingBadge
    local var1 = table.clone(tbl2)
    var1.config = tbl1[tbl2.itemLicensingInfo.licenseType]

    if FFlagAXMarketplaceLicensingItemCards and tbl2.isInteractive == false then
        return (React.createElement(PassiveLicensingBadge, var1))
    end

    return (React.createElement(InteractiveLicensingBadge, var1))
end)
