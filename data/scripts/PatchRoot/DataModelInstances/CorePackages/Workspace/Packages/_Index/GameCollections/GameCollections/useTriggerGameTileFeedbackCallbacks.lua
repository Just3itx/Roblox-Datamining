-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)

local useTriggerFeedback = require(GameCollectionsParent.InteractionFeedback).useTriggerFeedback
local _InteractionFeedback = require(GameCollectionsParent.InteractionFeedback)
local DiscoveryEventErrorLogger = require(GameCollectionsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppSduiGameTileInteractionFeedback = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSduiGameTileInteractionFeedback

local function useTriggerGameTileFeedbackCallbacks(func1: ((...any) -> (...any))?)
    if not FFlagLuaAppSduiGameTileInteractionFeedback then
        func1 = useTriggerFeedback()
    end

    local var1 = React.useRef(nil)
    return React.useCallback(function(arg1)
        local guiState = arg1.GuiState

        if FFlagLuaAppSduiGameTileInteractionFeedback and not func1 then
            DiscoveryEventErrorLogger.reportError(
                "GameTileMissingTriggerFeedback",
                "useTriggerGameTileFeedbackCallbacks called without triggerFeedbackFn; interaction feedback is disabled"
            )
            return
        end
        if var1.current == Enum.GuiState.Press then
            func1("Default", "Release")
        end
        if guiState == Enum.GuiState.Hover then
            func1("Default", "Hover")
        end
        if guiState == Enum.GuiState.Press then
            func1("Default", "Press")
        end
        var1.current = guiState
    end, { func1, var1 }), (React.useCallback(function()
        if FFlagLuaAppSduiGameTileInteractionFeedback and not func1 then
            DiscoveryEventErrorLogger.reportError(
                "GameTileMissingTriggerFeedback",
                "useTriggerGameTileFeedbackCallbacks called without triggerFeedbackFn; interaction feedback is disabled"
            )
            return
        end
        if var1.current == Enum.GuiState.Press then
            func1("Default", "Release")
        end
        var1.current = Enum.GuiState.Idle
    end, { func1, var1 }))
end

return useTriggerGameTileFeedbackCallbacks
