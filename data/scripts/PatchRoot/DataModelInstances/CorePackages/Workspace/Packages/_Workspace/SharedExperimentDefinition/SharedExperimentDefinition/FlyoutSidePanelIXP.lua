-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent

local ExperimentCacheManager = require(scriptParentParent.ExperimentCacheManager).ExperimentCacheManager

local num1 = game:DefineFastInt("FlyoutTestVariantRollout12", -1)
local bool1 = game:DefineFastFlag("EnableFlyoutIxp11", false)

local str1 = game:DefineFastString("FlyoutIxpLayer", "Universality.MorePage")
local str2 = game:DefineFastString("FlyoutIxpVariantKey", "flyout_side_panel_type")

local num2 = game:DefineFastInt("IxpFlyoutControl", 0)
local num3 = game:DefineFastInt("IxpFlyoutVariantAlternateEntry", 1)
local num4 = game:DefineFastInt("IxpFlyoutVariantHamburger", 2)
local num5 = game:DefineFastInt("IxpFlyoutVariantNoSubTabs", 3)
local num6 = game:DefineFastInt("IxpFlyoutVariantRemovalRobuxIcon", 4)
local bool2 = game:DefineFastFlag("FlyoutShowFriendsSortForCurrentVariant", false)
local bool3 = game:DefineFastFlag("EnableFlyoutExposure", false)
local bool4 = game:DefineFastFlag("FlyoutHamburgerEnableProfileEntry", false)
local bool5 = game:DefineFastFlag("FlyoutFacepileEnableProfileEntry", false)

local bool6 = game:DefineFastFlag("FlyoutDisallowAlternativeEntryOnProfileEntryEnabled", false)
local FFlagSubTabRemoveFlyoutDependency = require(scriptParentParent.SharedFlags).FFlagSubTabRemoveFlyoutDependency

local FFlagHiddenFriendsSortHeaderRemoveFlyoutDependency = require(scriptParentParent.SharedFlags).FFlagHiddenFriendsSortHeaderRemoveFlyoutDependency

local bool7 = game:DefineFastFlag("HiddenFriendsSortHeaderAddSubTabDependency", false)
local FFlagAppIaHomeSubTab = require(scriptParentParent.SharedFlags).FFlagAppIaHomeSubTab
local FFlagEnableSubTabOverride = require(scriptParentParent.SharedFlags).FFlagEnableSubTabOverride
local FFlagSubTabHideChartsForNonArgo = require(scriptParentParent.SharedFlags).FFlagSubTabHideChartsForNonArgo
local FFlagEnableChartsInFlyout = require(scriptParentParent.SharedFlags).FFlagEnableChartsInFlyout

local num7 = game:DefineFastInt("FlyoutAmpGatedVariant", 2)
local UniversalAppPolicy = require(scriptParentParent.UniversalAppPolicy)

local var1 = nil
local var2 = nil

local function getIXPVariant()
    if num1 ~= -1 then
        return num1
    elseif not bool1 then
        return num2
    else
        if var1 == nil then
            local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)
            if bool3 and layerVariables ~= nil then
                ExperimentCacheManager.default:logLayerExposure(str1)
            end
            var1 = layerVariables or {}
        end
        local var3 = var1[str2]
        if var3 == nil then
            return num2
        end
        return tonumber(var3)
    end
end

local function getVariant() -- Luacid: Inlined by compiler; 13 call sites recovered
    if var2 ~= nil then
        return var2
    end

    if UniversalAppPolicy.getAppFeaturePolicies().getFlyoutSidePanelEnabled() then
        var2 = num7
    else
        var2 = getIXPVariant()
    end

    return var2
end

local function isProfileEntryRemoved(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local variant = getVariant()
    return not (bool4 and variant == num4) and not (bool5 and (variant == num3 or variant == num5)) and variant ~= num2
end

local function isChartsInFlyoutEnabled() -- Luacid: Inlined by compiler; 3 call sites recovered
    return FFlagEnableChartsInFlyout and getVariant() ~= num2
end

return {
    isFlyoutSidePanelEnabled = function(): boolean
        return getVariant() ~= num2
    end,
    isRobloxLogoEnabled = function(): boolean
        return getVariant() ~= num2
    end,
    isProfileEntryRemoved = isProfileEntryRemoved,
    isFriendsSortHeaderHiddenInFlyoutIxp = function()
        if not FFlagHiddenFriendsSortHeaderRemoveFlyoutDependency then
            return getVariant() ~= num2 and not bool2
        end

        if FFlagEnableSubTabOverride then
            return not bool2
        end

        if isChartsInFlyoutEnabled() then
            return false
        end

        if bool7 then
            return FFlagAppIaHomeSubTab and not bool2
        end

        return not bool2
    end,
    isAlternateEntryPointEnabled = function()
        local variant = getVariant()

        if bool6 then
            return isProfileEntryRemoved() and (variant == num3 or variant == num5)
        end

        return variant == num3 or variant == num5
    end,
    isRobuxIconRemoved = function(): boolean
        return getVariant() == num6
    end,
    isScrollAwayEnabled = function(): boolean
        return getVariant() ~= num2
    end,
    isHomeSubTabEnabled = function(): boolean
        if FFlagEnableSubTabOverride then
            return true
        end

        if isChartsInFlyoutEnabled() then
            return false
        end
        if FFlagSubTabRemoveFlyoutDependency then
            return true
        end

        local variant = getVariant()
        return variant == num3 or variant == num4
    end,
    isChartsInSubTab = function(): boolean
        return not (FFlagSubTabHideChartsForNonArgo or isChartsInFlyoutEnabled())
    end,
    isChartsInFlyoutEnabled = isChartsInFlyoutEnabled
}
