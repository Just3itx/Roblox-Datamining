-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var1 = success and result

local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

local str1 = utf8.char(57344)

function IsPlayerVerified(speakerUserId: number | User)
    local player = Players:GetPlayerByUserId(speakerUserId)

    if not player then
        return false
    end

    local success2, result2 = pcall(function(): boolean
        return player.HasVerifiedBadge
    end)

    return if success2 then result2 else false
end

function AppendVerifiedBadge(arg1)
    return arg1 .. str1
end

function CreateMessageLabel(arg1, originalChannel, callback)
    local fromSpeaker = arg1.FromSpeaker
    local var2 = if ChatSettings.PlayerDisplayNamesEnabled and arg1.SpeakerDisplayName then arg1.SpeakerDisplayName else fromSpeaker
    local speakerUserId = arg1.SpeakerUserId
    if IsPlayerVerified(speakerUserId) then
        var2 = AppendVerifiedBadge(var2)
    end

    local _message = arg1.Message

    local extraData = arg1.ExtraData or {}
    local var3 = extraData.Font or ChatSettings.DefaultFont
    local var4 = extraData.TextSize or ChatSettings.ChatWindowTextSize
    local var5 = extraData.NameColor or ChatSettings.DefaultNameColor
    local var6 = extraData.ChatColor or ChatSettings.DefaultMessageColor
    local var7 = extraData.ChannelColor or var6
    local var8 = extraData.Tags or {}

    local str2 = string.format("[%s]:", var2)
    local _stringTextBounds = Util:GetStringTextBounds(str2, var3, var4)
    local var9 = Util:GetNumberOfSpaces(str2, var3, var4) + 1

    local var10, var11 = Util:CreateBaseMessage("", var3, var4, var6)
    local var12 = Util:AddNameButtonToBaseMessage(var11, var5, str2, fromSpeaker)
    local var13 = nil

    local uDim2 = UDim2.new(0, 0, 0, 0)

    if originalChannel ~= arg1.OriginalChannel then
        local str3 = string.format("{%s}", arg1.OriginalChannel)
        var13 = Util:AddChannelButtonToBaseMessage(var11, var7, str3, arg1.OriginalChannel)
        uDim2 = UDim2.new(0, var13.Size.X.Offset + Util:GetStringTextBounds(" ", var3, var4).X, 0, 0)
        local numberOfSpaces = Util:GetNumberOfSpaces(str3, var3, var4)
        var9 = var9 + numberOfSpaces + 1
    end

    local tbl1 = {}
    for _, value in pairs(var8) do
        local var14 = value.TagColor or Color3.fromRGB(255, 0, 255)
        local tagText = value.TagText or "???"
        local str3 = string.format("[%s] ", tagText)
        local var15 = Util:AddTagLabelToBaseMessage(var11, var14, str3)
        var15.Position = uDim2

        var9 += Util:GetNumberOfSpaces(str3, var3, var4)
        uDim2 += UDim2.new(0, var15.Size.X.Offset, 0, 0)

        table.insert(tbl1, var15)
    end

    var12.Position = uDim2

    local bool1 = false
    local var14 = nil
    if var1 then
        pcall(function()
            var14 = Util:AddTranslationButtonToBaseMessage(var11)
            uDim2 += UDim2.new(0, var12.Size.X.Offset + 2, 0, 0)
            var14.Position = uDim2
        end)
    end

    local function useOriginalText(arg2)
        bool1 = false
        if arg1.IsFiltered then
            var11.Text = Util:CreateLeadingSpaces(var9) .. Util:SanitizeForRichText(arg2.Message)
            return
        end
        local var15 = arg2.MessageLengthUtf8 or arg2.MessageLength
        var11.Text = Util:CreateLeadingSpaces(var9) .. string.rep("_", var15)
    end

    local function useTranslatedText(arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
        if var14 == nil then
            return
        end

        if var14.Visible == false then
            var9 += 6
        end

        var14.Visible = true
        bool1 = true

        if arg2.TranslatedMessage == "" then
            useOriginalText(arg2)
            return
        end

        var11.Text = Util:CreateLeadingSpaces(var9) .. Util:SanitizeForRichText(arg2.TranslatedMessage)
    end

    local function UpdateTextFunction_Chat(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        arg1.TranslatedMessage = arg2.TranslatedMessage
        if arg2.TranslatedMessage then
            useTranslatedText(arg2)
            return
        end

        useOriginalText(arg2)
    end

    local function UpdateTextFunction(arg2)
        if var1 then
            UpdateTextFunction_Chat(arg2)
        elseif arg1.IsFiltered then
            var11.Text = Util:CreateLeadingSpaces(var9) .. Util:SanitizeForRichText(arg2.Message)
        else
            local var15 = arg2.MessageLengthUtf8 or arg2.MessageLength
            var11.Text = Util:CreateLeadingSpaces(var9) .. string.rep("_", var15)
        end
    end

    local function toggleTranslation() -- Luacid: Inlined by compiler; 1 call site recovered
        if not bool1 and arg1.TranslatedMessage then
            useTranslatedText(arg1)
        else
            useOriginalText(arg1)
        end
        if callback then
            callback()
        end
    end

    if var1 and var14 ~= nil then
        local connection = var14.MouseButton1Click:connect(function()
            toggleTranslation()
        end)

        local connection2 = nil
        connection2 = var14.Changed:connect(function(arg2)
            if arg2 == "Parent" then
                connection:Disconnect()
                connection2:Disconnect()
            end
        end)
    end

    UpdateTextFunction(arg1)

    local function GetHeightFunction(arg2)
        return Util:GetMessageHeight(var11, var10, arg2)
    end

    local tbl2 = ({})
    tbl2[var12] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    if var1 and var14 ~= nil then
        tbl2[var14] = {
            ImageTransparency = { FadedIn = 0, FadedOut = 1 }
        }
    end

    tbl2[var11] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    for k, value in pairs(tbl1) do
        string.format("Tag%d", k)
        tbl2[value] = {
            TextTransparency = { FadedIn = 0, FadedOut = 1 },
            TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
        }
    end

    if var13 then
        tbl2[var13] = {
            TextTransparency = { FadedIn = 0, FadedOut = 1 },
            TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
        }
    end

    local var15, var16, var17 = Util:CreateFadeFunctions(tbl2)

    return {
        [Util.KEY_BASE_FRAME] = var10,
        [Util.KEY_BASE_MESSAGE] = var11,
        [Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction,
        [Util.KEY_GET_HEIGHT] = GetHeightFunction,
        [Util.KEY_FADE_IN] = var15,
        [Util.KEY_FADE_OUT] = var16,
        [Util.KEY_UPDATE_ANIMATION] = var17
    }
end

return {
    [Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeDefault,
    [Util.KEY_CREATOR_FUNCTION] = CreateMessageLabel
}
