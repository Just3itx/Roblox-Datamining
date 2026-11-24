-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local func1

if require(ExpChatParent.ExpChatShared).Flags.GetFFlagTextChatEnableUniverseChatTabs() then
    func1 = require(ExpChatParent.ChatUIPrimitives).Utils.computeNameColor
else
    local tbl1 = {
        Color3.new(253 / 255, 41 / 255, 67 / 255),
        Color3.new(1 / 255, 54 / 85, 1),
        Color3.new(2 / 255, 184 / 255, 29 / 85),
        BrickColor.new("Alder").Color,
        BrickColor.new("Bright orange").Color,
        BrickColor.new("Bright yellow").Color,
        BrickColor.new("Light reddish violet").Color,
        BrickColor.new("Brick yellow").Color
    }

    local function GetNameValue(str1: string)
        local num1 = 0
        for i = 1, #str1 do
            local var1 = string.byte(string.sub(str1, i, i))
            local num2 = #str1 - i + 1
            if #str1 % 2 == 1 then
                num2 -= 1
            end
            if num2 % 4 >= 2 then
                var1 = -var1
            end
            num1 += var1
        end
        return num1
    end

    func1 = function(str1: string)
        return tbl1[(GetNameValue(str1) + 0) % #tbl1 + 1]
    end
end

local function GetNameColor(userId: number)
    local player = Players:GetPlayerByUserId(userId)
    if player then
        if player.Team ~= nil then
            return player.TeamColor.Color
        end

        return func1(player.Name)
    end

    return Color3.fromRGB(255, 255, 255)
end

return GetNameColor
