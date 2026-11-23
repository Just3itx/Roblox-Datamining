-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local FFlagBuildExperienceInGameShell = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceInGameShell
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local GetAssistantBuildStore = require(BuildExperience.Stores.GetAssistantBuildStore)
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)

local EducationalTooltip = Foundation.EducationalTooltip
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local View = Foundation.View

return React.memo(function(tbl1) -- name: AssistantBuild
    local var1 = useLocalization({
        disabledTitle = LocalizationStrings.CHAT_ASSISTANT_DISABLED,
        portraitRequired = LocalizationStrings.CHAT_PORTRAIT_REQUIRED
    })
    local assistantBuildStore = GetAssistantBuildStore()
    local playButtonStore = GetPlayButtonStore()
    local isDisabled = SignalsReact.useSignalState(assistantBuildStore.getIsDisabled)
    local isOpen = SignalsReact.useSignalState(assistantBuildStore.getIsDisabledTooltipOpen)
    local var4 = if FFlagBuildExperienceInGameShell then SignalsReact.useSignalState(assistantBuildStore.getIsOverlayVisible) else nil

    local var5 = React.useCallback(function()
        if isDisabled then
            assistantBuildStore.setIsDisabledTooltipOpen(not isOpen)
            return
        end
        assistantBuildStore.setIsDisabledTooltipOpen(false)
        playButtonStore.setIsActive(true)
    end, {
        assistantBuildStore,
        isDisabled,
        isOpen,
        playButtonStore
    })

    local onPressedOutside = React.useCallback(function()
        assistantBuildStore.setIsDisabledTooltipOpen(false)
    end, { assistantBuildStore })

    React.useEffect(function()
        if isDisabled then
            playButtonStore.setIsActive(false)
            return
        end
        assistantBuildStore.setIsDisabledTooltipOpen(false)
    end, { assistantBuildStore, isDisabled, playButtonStore })

    local element = React.createElement(IconButton, {
        icon = if FFlagBuildExperienceInGameShell then if var4 then IconName.TwoArrowsFromCenter else IconName.TwoArrowsToCenter else IconName.Nebula,
        variant = tbl1.variant,
        size = InputSize.Medium,
        isCircular = true,
        isDisabled = isDisabled,
        onActivated = if FFlagBuildExperienceInGameShell then assistantBuildStore.activate else var5,
        testId = "build-header-play-button"
    })

    local createElement = React.createElement
    local var7 = View
    local tbl2 = { onActivated = 0, tag = "auto-xy", testId = "build-header-play-button-disabled" }
    if FFlagBuildExperienceInGameShell then
        var5 = assistantBuildStore.activate
    end

    tbl2.onActivated = var5
    local button = createElement(var7, tbl2, { Button = element })

    local createElement2 = React.createElement
    local var8 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "auto-xy",
        testId = tbl1.testId or "assistant-build"
    }
    local tbl4 = {
        Tooltip = if isDisabled then React.createElement(EducationalTooltip, {
            align = PopoverAlign.Start,
            isOpen = isOpen,
            onPressedOutside = onPressedOutside,
            side = PopoverSide.Bottom,
            text = var1.portraitRequired,
            testId = "build-assistant-disabled-tooltip",
            title = var1.disabledTitle
        }, { Button = button }) else nil,
        Button = 0
    }

    if isDisabled then
        element = nil
    end

    tbl4.Button = element
    return createElement2(var8, tbl3, tbl4)
end)
