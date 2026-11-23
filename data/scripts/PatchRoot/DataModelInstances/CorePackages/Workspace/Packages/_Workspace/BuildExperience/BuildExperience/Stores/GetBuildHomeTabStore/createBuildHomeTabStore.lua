-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local BUILD_HOME_TAB = { Games = "Games", Previews = "Previews" }

return {
    BUILD_HOME_TAB = BUILD_HOME_TAB,
    createBuildHomeTabStore = function()
        local getTab, setTab = Signals.createSignal(BUILD_HOME_TAB.Games)

        return {
            getTab = getTab,
            useTab = function()
                return SignalsReact.useSignalState(getTab)
            end,
            setTab = setTab
        }
    end
}
