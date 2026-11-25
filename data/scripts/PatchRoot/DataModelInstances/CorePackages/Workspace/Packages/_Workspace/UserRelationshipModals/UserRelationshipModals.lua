-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptFriendRequestModalContainer = require(script.Components.PromptFriendRequestModalContainer)
local launchUserRelationshipModal = require(script.InExperience.launchUserRelationshipModal)

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.launchPromptFriendRequestModal(userId: number)
    launchUserRelationshipModal(PromptFriendRequestModalContainer, { userId = userId })
end

return module
