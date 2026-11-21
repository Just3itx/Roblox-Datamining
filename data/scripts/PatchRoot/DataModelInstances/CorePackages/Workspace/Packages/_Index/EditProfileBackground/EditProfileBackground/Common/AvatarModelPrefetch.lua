-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local Promise = require(EditProfileBackgroundParent.Promise)

local Players = game:GetService("Players")

local tbl1 = ({})

local module = {}

function module.prefetch(userId: number)
    if tbl1[userId] then
        return
    end

    tbl1[userId] = Promise.new(function(callback, callback2)
        local success, result = pcall(function(): Model
            return Players:CreateHumanoidModelFromUserIdAsync(userId)
        end)
        if success and result then
            callback(result)
            return
        end
        callback2("CharacterModelCreationFailed")
    end)
end

function module.get(userId: number)
    if not tbl1[userId] then
        module.prefetch(userId)
    end

    return tbl1[userId]
end

function module.clear(userId: number)
    tbl1[userId] = nil
end

return module
