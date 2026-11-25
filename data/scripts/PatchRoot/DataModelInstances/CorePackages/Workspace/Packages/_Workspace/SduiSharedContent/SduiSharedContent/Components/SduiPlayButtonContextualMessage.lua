-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent
local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local GamePlayButton = require(SduiSharedContentParent.GamePlayButton)
local RoactServiceTags = require(SduiSharedContentParent.RoactServiceTags)
local SduiFeedContext = require(SduiSharedContent.Components.SduiFeedContext)
local useTokens = Foundation.Hooks.useTokens
local useRoactService = require(SduiSharedContentParent.RobloxAppHooks).useRoactService

local usePlayButtonContextualMessage = GamePlayButton.usePlayButtonContextualMessage
local usePlayButtonState = GamePlayButton.usePlayButtonState

local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local FoundationText = Foundation.Text
local View = Foundation.View

return React.memo(function(tbl1) -- name: SduiPlayButtonContextualMessage
    local var1 = useRoactService(RoactServiceTags.RoactNetworking)
    local var2 = useTokens()
    local var3 = React.useContext(SduiFeedContext)
    local var4 = React.useRef(nil)

    local var5 = usePlayButtonState(var1, tbl1.universeId, tbl1.fetchDelayInSeconds)
    local contextualMessage = usePlayButtonContextualMessage(tbl1.universeId, var5.playButtonState, var5.playabilityStatus)

    if contextualMessage == nil or contextualMessage == "" then
        return nil
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-xy",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Text = React.createElement(FoundationText, {
            tag = "auto-xy text-body-medium text-wrap text-align-x-left",
            textStyle = var2.Color.Content.Emphasis,
            Text = contextualMessage,
            ref = var4
        }),
        ImpressionsDetector = React.createElement(GamePlayButton.PlayButtonContextualMessageImpressionsDetector, {
            containerRef = var4,
            universeId = tbl1.universeId,
            playabilityStatus = var5.playabilityStatus,
            contextualMessage = contextualMessage,
            pageContext = tbl1.sduiContext and tbl1.sduiContext.appPage or "",
            scrollViewPositionChangedSignal = var3 and var3.scrollViewPositionChangedSignal
        })
    })
end)
