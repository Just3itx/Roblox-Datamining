-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local PlayButtonStates = require(VirtualEvents.Parent.GamePlayButton).PlayButtonStates

local function getEventCtaButtonState(arg1)
    return {
        isJoinEventDisabled = not (arg1.playButtonState == PlayButtonStates.Playable or arg1.playButtonState == PlayButtonStates.PlayableWithParty),
        isRsvpDisabled = not (arg1.playabilityStatus and arg1.playabilityStatus.isPlayable)
    }
end

return getEventCtaButtonState
