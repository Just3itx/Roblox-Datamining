-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local React = require(GamePlayButtonParent.React)
local Impressions = require(GamePlayButtonParent.Impressions)
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local useImpressionsTagger = Impressions.useImpressionsTagger
local _AppCommonLib = require(GamePlayButtonParent.AppCommonLib)
local DiscoveryAnalytics = require(GamePlayButtonParent.DiscoveryAnalytics)
local _PlayabilityRodux = require(GamePlayButtonParent.PlayabilityRodux)

local sendPlayButtonContextualMessageImpressionEvent = DiscoveryAnalytics.Events.sendPlayButtonContextualMessageImpressionEvent

local function PlayButtonContextualMessageImpressionsDetector(tbl1)
    local playabilityStatus = tbl1.playabilityStatus and tbl1.playabilityStatus.playabilityStatus
    local impressionsTag = `PLAY_BUTTON_CONTEXTUAL_MESSAGE_{tbl1.universeId}_{playabilityStatus}`

    useImpressionsTagger(tbl1.containerRef, impressionsTag, 1)

    local sendImpressions = React.useCallback(function(tbl2)
        if #tbl2 == 0 then
            return
        end
        sendPlayButtonContextualMessageImpressionEvent(
            {
                universeId = tbl1.universeId,
                playabilityStatus = playabilityStatus,
                contextualMessage = tbl1.contextualMessage
            },
            tbl1.pageContext
        )
    end, {
        tbl1.universeId,
        tbl1.pageContext,
        playabilityStatus,
        tbl1.contextualMessage
    })

    if not tbl1.contextualMessage or tbl1.contextualMessage == "" then
        return nil
    end

    return React.createElement(ScreenSizeImpressionsTracker, {
        pageContext = tbl1.pageContext,
        impressionsTag = impressionsTag,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        sendImpressions = sendImpressions,
        ignoreBottomInset = true
    })
end

return PlayButtonContextualMessageImpressionsDetector
