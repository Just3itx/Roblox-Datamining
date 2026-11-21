-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _PlayButtonTypes = require(script.PlayButtonTypes)

local _usePlayButtonState = require(script.usePlayButtonState)

local FFlagEnablePlayWithRewardComponent = require(script.Parent.SharedFlags).FFlagEnablePlayWithRewardComponent

return {
    Flags = require(script.Flags),
    FetchGamePlayButtonData = require(script.FetchGamePlayButtonData),
    delayedAmpWizardCompletionCallbackOverride = require(script.PlayButtonLaunchChecks.delayedAmpWizardCompletionCallbackOverride),
    LegacyPlayButtonContainer = require(script.LegacyPlayButtonContainer),
    PlayButton = require(script.PlayButton),
    PlusEarlyAccessUpsellBanner = require(script.PlusEarlyAccessUpsellBanner),
    useEarlyAccessCaption = require(script.EarlyAccess.useEarlyAccessCaption),
    PlayButtonView = require(script.PlayButtonView),
    PlayButtonReferralSource = require(script.PlayButtonReferralSource),
    PlayButtonStates = require(script.PlayButtonStates),
    PlayButtonUpsellDialog = require(script.PlayButtonUpsellDialog),
    useOnPlayButtonCallback = require(script.useOnPlayButtonCallback),
    useOnPlaySquadButtonCallback = require(script.useOnPlaySquadButtonCallback),
    usePlayButtonState = require(script.usePlayButtonState),
    usePlayButtonContextualMessage = require(script.usePlayButtonContextualMessage),
    PlayButtonContextualMessageImpressionsDetector = require(script.PlayButtonContextualMessageImpressionsDetector),
    usePlayButtonLaunchGame = if FFlagEnablePlayWithRewardComponent then require(script.PlayButtonLaunchChecks.usePlayButtonLaunchGame) else nil,
    LaunchUnlessNotPlayable = require(script.LaunchUnlessNotPlayable),
    ["jest.config"] = script["jest.config"]
}
