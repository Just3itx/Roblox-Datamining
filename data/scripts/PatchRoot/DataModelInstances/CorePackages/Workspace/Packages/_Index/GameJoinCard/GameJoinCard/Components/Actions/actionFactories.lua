-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local JoinExperienceAction = require(script.Parent.JoinExperienceAction)
local PlayExperienceAction = require(script.Parent.PlayExperienceAction)
local ChatAction = require(script.Parent.ChatAction)
local ViewProfileAction = require(script.Parent.ViewProfileAction)
local UnlockExperienceAction = require(script.Parent.UnlockExperienceAction)

local _Types = require(script.Parent.Types)

local tbl1 = ({})

for _, value in {
    JoinExperienceAction,
    PlayExperienceAction,
    ChatAction,
    ViewProfileAction,
    UnlockExperienceAction
} do
    for value2, value3 in value do
        assert(tbl1[value2] == nil, "Duplicate GameJoinCard action key: " .. tostring(value2))
        tbl1[value2] = value3
    end
end

return tbl1
