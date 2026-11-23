-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local UserModel = require(AppChatParent.UserLib).Models.UserModel
local MockUser = require(AppChatParent.UserLib).Models.MockUser
local MockUserData = require(AppChat.Users.MockUserData)

local mockUser = MockUser.new()
local _1 = MockUserData.USERS["1"]
mockUser.name = _1.displayName
mockUser.id = _1.id
mockUser.presence = UserModel.PresenceType.ONLINE
mockUser.lastLocation = _1.lastLocation
mockUser.isFriend = true

local mockUser2 = MockUser.new()
local _2 = MockUserData.USERS["2"]
mockUser2.name = _2.displayName
mockUser2.id = _2.id
mockUser2.presence = UserModel.PresenceType.IN_GAME
mockUser2.lastLocation = _2.lastLocation
mockUser2.isFriend = true

local mockUser3 = MockUser.new()
local _3 = MockUserData.USERS["3"]
mockUser3.name = _3.displayName
mockUser3.id = _3.id
mockUser3.isFriend = true

return {
    Users = { mockUser, mockUser2, mockUser3 },
    ChatAppReducer = {
        Presence = {
            byUserId = MockUserData.createMockPresenceData()
        }
    }
}
