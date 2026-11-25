-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local _SoundEffects = require(script.Parent.SoundEffects)
local _SoundGroups = require(script.Parent.SoundGroups)

local Volume = math.clamp(game:DefineFastInt("AppHover1VolumePercentage", 7), 0, 100) / 100
local num1 = math.clamp(game:DefineFastInt("AppNotificationHighVolumePercentage", 15), 0, 100) / 100

return {
    AppSelect = {
        Name = "AppSelect",
        SoundId = "rbxassetid://17208396156",
        DefaultPlaybackProperties = {
            Volume = math.clamp(game:DefineFastInt("AppSelectVolumePercentage", 12), 0, 100) / 100
        }
    },
    AppHover1 = {
        Name = "AppHover1",
        SoundId = "rbxassetid://17208348006",
        DefaultPlaybackProperties = { Volume = Volume }
    },
    CallAccept = { Name = "CallAccept", SoundId = "rbxassetid://14891715516" },
    CallDecline = { Name = "CallDecline", SoundId = "rbxassetid://14891713083" },
    HangUp = { Name = "HangUp", SoundId = "rbxassetid://14891706508" },
    Hover = { Name = "Hover", SoundId = "rbxassetid://14891703967" },
    NotificationHigh = {
        Name = "NotificationHigh",
        SoundId = "rbxassetid://17208361335",
        DefaultPlaybackProperties = { Volume = num1 }
    },
    Purchase = {
        Name = "Purchase",
        SoundId = "rbxassetid://17208380755",
        DefaultPlaybackProperties = {
            Volume = math.clamp(game:DefineFastInt("PurchaseVolumePercentage", 15), 0, 100) / 100
        }
    },
    Ringtone = { Name = "Ringtone", SoundId = "rbxassetid://14891720242" },
    Select = { Name = "Select", SoundId = "rbxassetid://14891717694" },
    Swipe = { Name = "Swipe", SoundId = "rbxassetid://14951578106" },
    PartyToast = { Name = "PartyToast", SoundId = "rbxassetid://99437156604053" },
    VolumeTest = { Name = "VolumeTest", SoundId = "rbxasset://sounds/uuhhh.mp3" },
    VRAppLobbySound = {
        Name = "VRAppLobbySound",
        SoundId = "rbxassetid://15227666815",
        DefaultPlaybackProperties = { FadeOutTime = 3 }
    }
}
