-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local SharedFlags = require(SplitPaneParent.SharedFlags)
local AppSplitView = require(SplitPaneParent.AppSplitView)

local SplitPaneSlot = AppSplitView.Enums.SplitPaneSlot

local FFlagSplitPaneExperimentVariants = SharedFlags.FFlagSplitPaneExperimentVariants
local FFlagSplitPaneVariantDefaultCollapsed = SharedFlags.FFlagSplitPaneVariantDefaultCollapsed
local FFlagSplitPaneVariantAvatarOnHomeOnly = SharedFlags.FFlagSplitPaneVariantAvatarOnHomeOnly
local FFlagSplitPaneVariantCollapsedAutoOpen = SharedFlags.FFlagSplitPaneVariantCollapsedAutoOpen
local FFlagSplitPaneAvatarOnlyAlwaysExpanded = SharedFlags.FFlagSplitPaneAvatarOnlyAlwaysExpanded

local tbl1 = {
    name = "DefaultOpen",
    defaultOpen = true,
    autoExpandOnSupportOpen = true,
    avatarOnHome = true,
    supportSlotEligible = true,
    profileSupportSlotEligibleWhenCollapsed = true,
    educationModal = true
}

local tbl2 = {
    name = "DefaultCollapsed",
    defaultOpen = false,
    autoExpandOnSupportOpen = false,
    avatarOnHome = true,
    supportSlotEligible = true,
    profileSupportSlotEligibleWhenCollapsed = false,
    educationModal = true
}

local tbl3 = {
    name = "AvatarOnHomeOnly",
    defaultOpen = true,
    autoExpandOnSupportOpen = true,
    avatarOnHome = true,
    supportSlotEligible = false,
    profileSupportSlotEligibleWhenCollapsed = true,
    educationModal = true
}

local tbl4 = {
    name = "CollapsedAutoOpen",
    defaultOpen = false,
    autoExpandOnSupportOpen = true,
    avatarOnHome = false,
    supportSlotEligible = true,
    profileSupportSlotEligibleWhenCollapsed = true,
    educationModal = false
}

local bool1 = false
local tbl5 = tbl1

local function resolveVariant() -- Luacid: Inlined by compiler; 15 call sites recovered
    local tbl6 = tbl1
    if FFlagSplitPaneVariantCollapsedAutoOpen then
        tbl6 = tbl4
    elseif FFlagSplitPaneVariantAvatarOnHomeOnly then
        tbl6 = tbl3
    elseif FFlagSplitPaneVariantDefaultCollapsed then
        tbl6 = tbl2
    end
    bool1 = true
    tbl5 = tbl6
    return tbl6
end

local function getVariantConfig() -- Luacid: Inlined by compiler; 14 call sites recovered
    if not bool1 then
        resolveVariant()
    end

    return tbl5
end

local function getProfileSplitPaneEligibility(collapsed: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagSplitPaneExperimentVariants then
        local variantConfig = getVariantConfig()

        if not variantConfig.supportSlotEligible then
            return nil
        end

        if collapsed == AppSplitView.Enums.SupportPaneMode.Collapsed and not variantConfig.profileSupportSlotEligibleWhenCollapsed then
            return nil
        end
    end
    return SplitPaneSlot.Support
end

return {
    getVariantConfig = getVariantConfig,
    isPaneCollapsedByDefault = function(): boolean
        return not getVariantConfig().defaultOpen
    end,
    shouldAutoExpandOnSupportOpen = function(): boolean
        return getVariantConfig().autoExpandOnSupportOpen
    end,
    isSupportPaneAlwaysExpanded = function(): boolean
        return not getVariantConfig().supportSlotEligible
    end,
    shouldCollapseOnSupportClose = function(): boolean
        return not getVariantConfig().avatarOnHome
    end,
    shouldShowAvatarOnHome = function(): boolean
        return getVariantConfig().avatarOnHome
    end,
    isEducationModalEnabled = function(): boolean
        return getVariantConfig().educationModal
    end,
    getGameDetailsSplitPaneEligibility = function()
        return if FFlagSplitPaneExperimentVariants and not getVariantConfig().supportSlotEligible then nil else SplitPaneSlot.Support
    end,
    getProfileSplitPaneEligibility = getProfileSplitPaneEligibility,
    getProfileRoutePresentation = function(collapsed: string?)
        if not FFlagSplitPaneExperimentVariants then
            return {
                splitPaneEligibility = if collapsed == nil then nil else SplitPaneSlot.Support,
                rendersOverlay = collapsed == nil,
                rendersAboveSplitPane = false
            }
        end

        local splitPaneEligibility = if collapsed == nil then nil else getProfileSplitPaneEligibility(collapsed)
        local bool2 = splitPaneEligibility ~= nil
        local rendersOverlay = not bool2 and (collapsed == nil or not (getVariantConfig().defaultOpen or getVariantConfig().autoExpandOnSupportOpen))

        return {
            splitPaneEligibility = splitPaneEligibility,
            rendersOverlay = rendersOverlay,
            rendersAboveSplitPane = not (bool2 or rendersOverlay)
        }
    end,
    getExperienceDetailSplitPaneEligibility = function()
        return if FFlagSplitPaneExperimentVariants
            and not FFlagSplitPaneAvatarOnlyAlwaysExpanded
            and not getVariantConfig().supportSlotEligible then nil else SplitPaneSlot.Support
    end,
    getDevStoreSeeAllSplitPaneEligibility = function()
        return if FFlagSplitPaneExperimentVariants and not getVariantConfig().supportSlotEligible then nil else SplitPaneSlot.Support
    end,
    getBadgesSeeAllSplitPaneEligibility = function()
        return if FFlagSplitPaneExperimentVariants and not getVariantConfig().supportSlotEligible then nil else SplitPaneSlot.Support
    end,
    variantConfigs = {
        tbl1,
        tbl2,
        tbl3,
        tbl4
    }
}
