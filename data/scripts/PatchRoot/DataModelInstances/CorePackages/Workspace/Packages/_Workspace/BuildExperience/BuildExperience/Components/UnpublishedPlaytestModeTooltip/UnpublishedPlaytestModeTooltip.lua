-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local BuildAppStorage = require(BuildExperience.Storage.BuildAppStorage)
local BuildModeLaunch = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.BuildModeLaunch)

local EducationalTooltip = Foundation.EducationalTooltip
local OverlayProvider = Foundation.OverlayProvider
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local FIntUnpublishedPlaytestModeTooltipDisplayLimit = SharedFlags.FIntUnpublishedPlaytestModeTooltipDisplayLimit

local function getCanShow(anchorRef) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1

    if FIntUnpublishedPlaytestModeTooltipDisplayLimit > 0 then
        bool1 = BuildModeLaunch:hasBuildMode()

        if bool1 then
            if BuildAppStorage.getUnpublishedPlaytestModeTooltipDisplayCount() < FIntUnpublishedPlaytestModeTooltipDisplayLimit
                and anchorRef ~= nil
            then
                bool1 = anchorRef.current ~= nil
            else
                bool1 = false
            end
        end
    else
        bool1 = false
    end

    return bool1
end

return React.memo(function(tbl1) -- name: UnpublishedPlaytestModeTooltip
    local var1 = useLocalization({
        description = LocalizationStrings.UNPUBLISHED_PLAYTEST_MODE_TOOLTIP_DESCRIPTION,
        title = LocalizationStrings.UNPUBLISHED_PLAYTEST_MODE_TOOLTIP_TITLE
    })
    local isOpen, var3 = React.useState((getCanShow(tbl1.anchorRef)))
    local var4 = React.useRef(false)

    local var5 = React.useCallback(function()
        var3(false)
    end, {})

    React.useEffect(function()
        var3((getCanShow(tbl1.anchorRef)))
    end, { tbl1.anchorRef })

    React.useEffect(function()
        if isOpen and not var4.current then
            var4.current = true
            BuildAppStorage.incrementUnpublishedPlaytestModeTooltipDisplayCount()
        end
    end, { isOpen })

    if not isOpen then
        return nil
    end

    return React.createElement(OverlayProvider, nil, {
        Tooltip = React.createElement(EducationalTooltip, {
            anchorRef = tbl1.anchorRef,
            title = var1.title,
            text = var1.description,
            side = PopoverSide.Bottom,
            align = PopoverAlign.Start,
            isOpen = isOpen,
            onClose = var5,
            onPressedOutside = var5,
            testId = "unpublished-playtest-mode-tooltip",
            Visible = tbl1.isVisible
        })
    })
end)
