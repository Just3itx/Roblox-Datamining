-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    Groups = {{
        GroupId = 1200769,
        ChatColor = Color3.new(1, 43 / 51, 0)
    }},
    Players = {{}}
}

local function MakeIsInGroup(groupId: number, rank) -- Luacid: Inlined by compiler; 1 call site recovered
    assert(type(rank) == "nil" or type(rank) == "number", "requiredRank must be a number or nil")

    return function(player): boolean
        if not (player and player.UserId) then
            return false
        end

        local _userId = player.UserId

        local bool1 = false
        local success, result = pcall(function()
            if rank then
                local rankInGroup = player:GetRankInGroup(groupId)
                bool1 = rank < rankInGroup
                return
            end
            bool1 = player:IsInGroup(groupId)
        end)

        if not success and result then
            print("Error checking in group: " .. result)
        end

        return bool1
    end
end

local function ConstructIsInGroups()
    if not tbl1.Groups then
        return
    end

    for _, group in pairs(tbl1.Groups) do
        group.IsInGroup = MakeIsInGroup(group.GroupId, group.Rank)
    end
end

ConstructIsInGroups()

local Players = game:GetService("Players")

local function GetSpecialChatColor(name: string)
    if tbl1.Players then
        local var1 = Players:FindFirstChild(name)
        if var1 then
            for _, player in pairs(tbl1.Players) do
                if var1.UserId == player.UserId then
                    return player.ChatColor
                end
            end
        end
    end
    if not tbl1.Groups then
        return
    end

    for _, group in pairs(tbl1.Groups) do
        if group.IsInGroup(Players:FindFirstChild(name)) then
            return group.ChatColor
        end
    end
end

local function Run(arg1)
    local tbl2 = {
        Color3.new(253 / 255, 41 / 255, 67 / 255),
        Color3.new(1 / 255, 54 / 85, 1),
        Color3.new(2 / 255, 184 / 255, 29 / 85),
        BrickColor.new("Bright violet").Color,
        BrickColor.new("Bright orange").Color,
        BrickColor.new("Bright yellow").Color,
        BrickColor.new("Light reddish violet").Color,
        BrickColor.new("Brick yellow").Color
    }

    local function GetNameValue(name)
        local num1 = 0
        for i = 1, #name do
            local var1 = string.byte(string.sub(name, i, i))
            local num2 = #name - i + 1
            if #name % 2 == 1 then
                num2 -= 1
            end
            if num2 % 4 >= 2 then
                var1 = -var1
            end
            num1 += var1
        end
        return num1
    end

    local function ComputeNameColor(name) -- Luacid: Inlined by compiler; 3 call sites recovered
        return tbl2[(GetNameValue(name) + 0) % #tbl2 + 1]
    end

    local function GetNameColor(speaker) -- Luacid: Inlined by compiler; 2 call sites recovered
        local player = speaker:GetPlayer()
        if player and player.Team ~= nil then
            return player.TeamColor.Color
        end

        return (ComputeNameColor(speaker.Name))
    end

    local function onNewSpeaker(arg2)
        local speaker = arg1:GetSpeaker(arg2)
        if not speaker:GetExtraData("NameColor") then
            speaker:SetExtraData("NameColor", (GetNameColor(speaker)))
        end
        if not speaker:GetExtraData("ChatColor") then
            local specialChatColor = GetSpecialChatColor(arg2)
            if specialChatColor then
                speaker:SetExtraData("ChatColor", specialChatColor)
            end
        end
        if not speaker:GetExtraData("Tags") then
            speaker:SetExtraData("Tags", {})
        end
    end

    arg1.SpeakerAdded:connect(onNewSpeaker)

    for _, value in pairs(arg1:GetSpeakerList()) do
        onNewSpeaker(value)
    end

    local tbl3 = ({})
    Players.PlayerAdded:connect(function(player: Player)
        tbl3[player] = player.Changed:connect(function(property: string)
            local speaker = arg1:GetSpeaker(player.Name)
            if speaker and (property == "TeamColor" or property == "Neutral" or property == "Team") then
                speaker:SetExtraData("NameColor", (GetNameColor(speaker)))
            end
        end)
    end)

    Players.PlayerRemoving:connect(function(player: Player)
        local var1 = tbl3[player]
        if var1 then
            var1:Disconnect()
        end
        tbl3[player] = nil
    end)
end

return Run
