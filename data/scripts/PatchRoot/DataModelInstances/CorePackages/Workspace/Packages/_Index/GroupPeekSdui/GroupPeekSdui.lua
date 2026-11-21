-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GroupPeekSduiConstants = require(script.GroupPeekSduiConstants)

return {
    ["jest.config"] = script["jest.config"],
    fetchGroupPeekPage = require(script.fetchGroupPeekPage),
    registerGroupAnnouncementActions = require(script.registerGroupAnnouncementActions),
    AppPage = GroupPeekSduiConstants.AppPage,
    Identifiers = GroupPeekSduiConstants.Identifiers,
    getConfigKey = GroupPeekSduiConstants.getConfigKey
}
