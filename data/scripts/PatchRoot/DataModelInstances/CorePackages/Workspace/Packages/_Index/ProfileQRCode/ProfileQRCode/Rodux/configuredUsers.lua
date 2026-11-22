-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCodeParent = script:FindFirstAncestor("ProfileQRCode").Parent
local convertActions = require(ProfileQRCodeParent.SocialReducerAdaptors).convertActions
local usersActionAdaptor = require(ProfileQRCodeParent.SocialReducerAdaptors).usersActionAdaptor
local RoduxUsers = require(script.Parent.RoduxUsers)

local tbl1 = {
    byUserId = {},
    byUsername = {}
}

local var1 = RoduxUsers.installReducer()

return function()
    return convertActions(var1, usersActionAdaptor(RoduxUsers), tbl1)
end
