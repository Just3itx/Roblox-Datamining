-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent
local useCountdownText = require(GamePlayButton.EarlyAccess.useCountdownText)
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization

local function useEarlyAccessCaption(arg1)
    local unlockTimestamp = if arg1 then arg1.unlockTimestamp else nil
    local time = useCountdownText(unlockTimestamp)
    local var2 = useLocalization({ joinIn = { "Feature.RobloxSubscription.Action.JoinIn", time = time } })

    return if time == "" then nil else var2.joinIn
end

return useEarlyAccessCaption
