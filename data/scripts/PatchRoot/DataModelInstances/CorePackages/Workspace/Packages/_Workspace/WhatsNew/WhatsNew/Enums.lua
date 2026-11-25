-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local _Types = require(script.Parent.Types)

local WhatsNewParent = script:FindFirstAncestor("WhatsNew").Parent
local Foundation = require(WhatsNewParent.Foundation)

local TourType = { WhatsNew = "whatsNew", Onboarding = "onboarding" }

return {
    TourType = TourType,
    TourTypeList = { TourType.Onboarding, TourType.WhatsNew },
    WhatsNewSurface = { Idle = "idle", TourTip = "tourTip", WaitingForAnchor = "waitingForAnchor" },
    PopoverSide = Foundation.Enums.PopoverSide,
    PopoverAlign = Foundation.Enums.PopoverAlign
}
