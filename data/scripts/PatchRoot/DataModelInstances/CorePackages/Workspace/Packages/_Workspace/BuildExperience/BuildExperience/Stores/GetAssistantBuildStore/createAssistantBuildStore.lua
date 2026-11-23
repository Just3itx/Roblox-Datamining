-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local FFlagBuildExperienceInGameShell = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceInGameShell
local Display = if FFlagBuildExperienceInGameShell then nil else require(BuildExperienceParent.Display)
local Signals = require(BuildExperienceParent.Signals)

local function createAssistantBuildStore()
    local getIsDisabled = if FFlagBuildExperienceInGameShell then Signals.createSignal(false) else Signals.createComputed(function(arg1): boolean
        local displayStore = Display.GetDisplayStore(arg1)
        local displaySize = displayStore.getDisplaySize(arg1)
        local viewportSize = displayStore.getViewportSize(arg1)

        return displaySize == Enum.DisplaySize.Small and viewportSize.X > viewportSize.Y
    end)

    local getIsDisabledTooltipOpen, setIsDisabledTooltipOpen = Signals.createSignal(false)
    local getIsOverlayVisible, setIsOverlayVisible = Signals.createSignal(true)
    return {
        getIsDisabled = getIsDisabled,
        getIsDisabledTooltipOpen = getIsDisabledTooltipOpen,
        getIsOverlayVisible = getIsOverlayVisible,
        activate = function()
            if getIsDisabled(false) then
                setIsDisabledTooltipOpen(not getIsDisabledTooltipOpen(false))
                return
            end
            setIsDisabledTooltipOpen(false)
            setIsOverlayVisible(not getIsOverlayVisible(false))
        end,
        setIsDisabledTooltipOpen = setIsDisabledTooltipOpen,
        setIsOverlayVisible = setIsOverlayVisible
    }
end

return createAssistantBuildStore
