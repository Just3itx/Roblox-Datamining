-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Constants = require(script.Constants)
local ReactionType = require(script.Enums.ReactionType)
local ReactionSize = require(script.Enums.ReactionSize)
local ReactionTrigger = require(script.Enums.ReactionTrigger)
local Reaction = require(script.Components.Reaction)
local ReactionButton = require(script.Components.ReactionButton)
local ReactionChip = require(script.Components.ReactionChip)
local ReactionPicker = require(script.Components.ReactionPicker)
local ReactionPickerPopover = require(script.Components.ReactionPickerPopover)
local ReactionPill = require(script.Components.ReactionPill)
local ReactionExplosion = require(script.Components.ReactionExplosion)
return {
    Constants = Constants,
    Enums = {
        ReactionType = ReactionType,
        ReactionSize = ReactionSize,
        ReactionTrigger = ReactionTrigger
    },
    Utils = {
        applyReactionTrigger = require(script.Utils.applyReactionTrigger),
        abbreviateReactionCount = require(script.Utils.abbreviateReactionCount),
        getTopReactions = require(script.Utils.getTopReactions),
        reactionTypeFromEmojiName = require(script.Utils.reactionTypeFromEmojiName)
    },
    Reaction = Reaction,
    ReactionButton = ReactionButton,
    ReactionChip = ReactionChip,
    ReactionPicker = ReactionPicker,
    ReactionPickerPopover = ReactionPickerPopover,
    ReactionPill = ReactionPill,
    ReactionExplosion = ReactionExplosion,
    ["jest.config"] = script["jest.config"]
}
