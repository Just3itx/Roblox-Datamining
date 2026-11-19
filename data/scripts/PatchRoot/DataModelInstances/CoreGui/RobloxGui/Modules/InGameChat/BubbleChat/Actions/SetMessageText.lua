-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator
local t = require(CorePackages.Packages.t)
local maybeAssert = require(script.Parent.Parent.Helpers.maybeAssert)

local var1 = t.tuple(t.string, t.string)

return makeActionCreator(script.Name, function(messageId, newText)
    maybeAssert(var1(messageId, newText))

    ExpChat.Events.LegacyBubbleTextUpdated(messageId, newText)

    return { messageId = messageId, newText = newText }
end)
