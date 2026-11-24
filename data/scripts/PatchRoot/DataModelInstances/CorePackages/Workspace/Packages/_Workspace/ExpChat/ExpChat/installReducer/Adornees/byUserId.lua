-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Actions = ExpChat.Actions
local AdorneeAdded = require(Actions.AdorneeAdded)
local PlayerRemoved = ExpChatShared.Actions.PlayerRemoved
local HumanoidDied = require(Actions.HumanoidDied)

local function findFirstChildByNameAndClass(arg1, name: string, str1: string)
    for _, child in ipairs(arg1:GetChildren()) do
        if child.Name == name and child:IsA(str1) then
            return child
        end
    end

    return nil
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AdorneeAdded.name] = function(tbl2, arg1)
    local firstChildByNameAndClass = findFirstChildByNameAndClass(arg1.character, "Head", "BasePart")
    if arg1.humanoid.Health ~= 0 then
        firstChildByNameAndClass = arg1.character
    end
    return Dictionary.join(tbl2, { [arg1.userId] = firstChildByNameAndClass })
end

tbl1[HumanoidDied.name] = function(tbl2, arg1)
    local var1 = tbl2[arg1.userId]
    local var2 = if var1 then findFirstChildByNameAndClass(var1, "Head", "BasePart") or var1 else nil
    return Dictionary.join(tbl2, { [arg1.userId] = var2 })
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    return Dictionary.removeKey(tbl2, arg1.userId)
end

return createReducer({}, tbl1)
