-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local _ReactionAnimation = require(scriptParent.ReactionAnimation)

local tbl1 = {
    crying = {
        name = "sob",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    fire = {
        name = "fire",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    heart = {
        name = "love",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    ["laugh-joy"] = {
        name = "joy",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 0,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    skull = {
        name = "skull",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    ["thumbs-up"] = {
        name = "like",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    },
    wow = {
        name = "wow",
        frameCount = 91,
        frameSize = 48,
        internalPadding = 2,
        padding = 24,
        stride = 72,
        columns = 14,
        rows = 7,
        sheetWidth = 984,
        sheetHeight = 480,
        fps = 45
    }
}

local function getAnimationData(str1: string)
    return tbl1[str1]
end

return getAnimationData
