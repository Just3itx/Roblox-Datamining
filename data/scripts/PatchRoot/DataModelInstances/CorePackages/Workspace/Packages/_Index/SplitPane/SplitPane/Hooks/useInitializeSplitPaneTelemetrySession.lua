-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent
local React = require(SplitPaneParent.React)
local Signals = require(SplitPaneParent.Signals)
local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)
local SplitPaneTelemetry = require(script.Parent.Parent.Telemetry.SplitPaneTelemetry)
local getTelemetrySnapshot = require(script.Parent.Parent.Telemetry.getTelemetrySnapshot)

local function useInitializeSplitPaneTelemetrySession(bool1: boolean)
    React.useEffect(function()
        if not bool1 then
            return nil
        end
        local store = SplitPaneStore.getStore()
        return Signals.createEffect(function(arg1)
            if store.getIsTelemetrySessionInitialized(arg1) then
                return
            end
            local telemetrySnapshot = getTelemetrySnapshot(store, arg1)
            if SplitPaneTelemetry.logAppLaunchViewport(telemetrySnapshot) then
                store.setIsTelemetrySessionInitialized(true)
                SplitPaneTelemetry.logSplitPaneViewChange(telemetrySnapshot, SplitPaneTelemetry.Action.Launch)
                SplitPaneTelemetry.logStateChanged(
                    SplitPaneTelemetry.getTelemetryStateFromMode(store.getSupportPaneModeIfActive(false)),
                    SplitPaneTelemetry.Action.Launch
                )
            end
        end)
    end, { bool1 })
end

return useInitializeSplitPaneTelemetrySession
