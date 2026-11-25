-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Constants)

local _GetIcon = require(script.Utils.GetIcon)

return {
    AgeVerificationOverlay = require(script.AgeVerificationOverlay),
    Constants = Constants,
    OptInStatus = require(script.OptInStatus),
    Flags = require(script.Flags),
    GetInformedOfBan = require(script.Requests.GetInformedOfBan),
    GetUserSettings = require(script.Requests.GetUserSettings),
    PostInformedOfBan = require(script.Requests.PostInformedOfBan),
    PostSeenAvatarVideoModal = require(script.Requests.PostSeenAvatarVideoModal),
    PostUserOptIn = require(script.Requests.PostUserOptIn),
    Utils = require(script.Utils),
    GlobalVoiceManager = require(script.GlobalVoiceManager),
    ["jest.config"] = script["jest.config"]
}
