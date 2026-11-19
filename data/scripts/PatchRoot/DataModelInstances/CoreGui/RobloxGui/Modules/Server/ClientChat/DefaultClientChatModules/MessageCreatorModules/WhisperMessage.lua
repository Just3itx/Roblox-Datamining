-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

local str1 = utf8.char(57344)

local ChatLocalization = nil

pcall(function()
    ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

function IsPlayerVerified(speakerUserId: number | User)
    local player = Players:GetPlayerByUserId(speakerUserId)

    if not player then
        return false
    end

    local success, result = pcall(function(): boolean
        return player.HasVerifiedBadge
    end)

    return if success then result else false
end

function AppendVerifiedBadge(arg1)
    return arg1 .. str1
end

function CreateMessageLabel(arg1, originalChannel)
    local fromSpeaker = arg1.FromSpeaker
    local var1 = if ChatSettings.PlayerDisplayNamesEnabled and arg1.SpeakerDisplayName then arg1.SpeakerDisplayName else fromSpeaker
    local speakerUserId = arg1.SpeakerUserId
    if IsPlayerVerified(speakerUserId) then
        var1 = AppendVerifiedBadge(var1)
    end

    local _message = arg1.Message

    local extraData = arg1.ExtraData or {}
    local var2 = extraData.Font or ChatSettings.DefaultFont
    local var3 = extraData.TextSize or ChatSettings.ChatWindowTextSize
    local var4 = extraData.NameColor or ChatSettings.DefaultNameColor
    local var5 = extraData.ChatColor or ChatSettings.DefaultMessageColor
    local var6 = extraData.ChannelColor or var5

    local str2 = string.format("[%s]:", var1)
    local _stringTextBounds = Util:GetStringTextBounds(str2, var2, var3)
    local var7 = Util:GetNumberOfSpaces(str2, var2, var3) + 1

    local var8, var9 = Util:CreateBaseMessage("", var2, var3, var5)
    local var10 = Util:AddNameButtonToBaseMessage(var9, var4, str2, fromSpeaker)
    local var11

    if originalChannel == arg1.OriginalChannel then
        var11 = nil
    else
        local originalChannel2 = arg1.OriginalChannel
        if arg1.FromSpeaker ~= LocalPlayer.Name then
            originalChannel2 = string.format("From %s", arg1.FromSpeaker)
        end

        if ChatLocalization.tryLocalize then
            originalChannel2 = ChatLocalization:tryLocalize(originalChannel2)
        end

        local str3 = string.format("{%s}", originalChannel2)
        var11 = Util:AddChannelButtonToBaseMessage(var9, var6, str3, arg1.OriginalChannel)
        var10.Position = UDim2.new(0, var11.Size.X.Offset + Util:GetStringTextBounds(" ", var2, var3).X, 0, 0)
        var7 = var7 + Util:GetNumberOfSpaces(str3, var2, var3) + 1
    end

    local function UpdateTextFunction(arg2)
        if arg1.IsFiltered then
            var9.Text = Util:CreateLeadingSpaces(var7) .. Util:SanitizeForRichText(arg2.Message)
            return
        end
        local var12 = arg2.MessageLengthUtf8 or arg2.MessageLength
        var9.Text = Util:CreateLeadingSpaces(var7) .. string.rep("_", var12)
    end

    UpdateTextFunction(arg1)

    local function GetHeightFunction(arg2)
        return Util:GetMessageHeight(var9, var8, arg2)
    end

    local tbl1 = ({})
    tbl1[var10] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    tbl1[var9] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    if var11 then
        tbl1[var11] = {
            TextTransparency = { FadedIn = 0, FadedOut = 1 },
            TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
        }
    end

    local var12, var13, var14 = Util:CreateFadeFunctions(tbl1)

    return {
        [Util.KEY_BASE_FRAME] = var8,
        [Util.KEY_BASE_MESSAGE] = var9,
        [Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction,
        [Util.KEY_GET_HEIGHT] = GetHeightFunction,
        [Util.KEY_FADE_IN] = var12,
        [Util.KEY_FADE_OUT] = var13,
        [Util.KEY_UPDATE_ANIMATION] = var14
    }
end

return {
    [Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeWhisper,
    [Util.KEY_CREATOR_FUNCTION] = CreateMessageLabel
}
