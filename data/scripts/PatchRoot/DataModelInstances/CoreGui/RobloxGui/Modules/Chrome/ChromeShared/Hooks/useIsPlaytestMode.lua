-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local SignalsReact = require(CorePackages.Packages.SignalsReact)

local GetPlaytestModeStore = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon.GetPlaytestModeStore)

local function useIsPlaytestMode()
    local playtestModeStore = GetPlaytestModeStore(false)

    return SignalsReact.useSignalState(playtestModeStore.getIsPlaytestMode)
end

return useIsPlaytestMode
