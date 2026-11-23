-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization
local useIsSpatial = require(AvatarExperienceCommonParent.Responsive).useIsSpatial
local useEarlyIsFocused = require(AvatarExperienceCommonParent.Navigation).useEarlyIsFocused
local SignalsReact = require(AvatarExperienceCommonParent.SignalsReact)
local AXTooltipStore = require(AvatarExperienceCommon.Stores.AXTooltipStore)

local num1 = game:DefineFastInt("AXTooltipTimeToDismiss", 5)

local _AvatarExperienceUIKit = require(AvatarExperienceCommonParent.AvatarExperienceUIKit)

local function useAXTooltipViewModel(tbl1)
    local var1 = AXTooltipStore(false)

    local var2 = useLocalization({ tooltipText = tbl1.tooltipLocalizationKey })
    local tooltipText = tbl1.localizedText or var2.tooltipText

    local var4 = useIsSpatial()
    local var5 = useEarlyIsFocused()

    local var6 = SignalsReact.useSignalState(var1.getIsTooltipAllowedToBeShown(tbl1.tooltipStorageKey))

    local isOpen = tbl1.showTooltip and var6 and var5 and not var4

    local var8 = React.useCallback(function()
        var1.dismissTooltip(tbl1.tooltipStorageKey)
    end, { tbl1.tooltipStorageKey })

    if tbl1.dismissTooltipRef and tbl1.showTooltip then
        tbl1.dismissTooltipRef.current = var8
    end

    React.useEffect(function()
        if isOpen then
            task.spawn(function()
                task.wait(num1)
                var1.dismissTooltip(tbl1.tooltipStorageKey, true)
            end)
        end
    end, { isOpen })

    return {
        isOpen = isOpen,
        popoverSide = tbl1.popoverSide,
        tooltipText = tooltipText,
        onTooltipActivated = var8
    }
end

return useAXTooltipViewModel
