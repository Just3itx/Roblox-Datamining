-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateMeCommandMessageLabel(arg1, originalChannel)
    local _message = arg1.Message
    local extraData = arg1.ExtraData or {}
    local var1 = extraData.Font or Enum.Font.SourceSansItalic
    local var2 = extraData.TextSize or ChatSettings.ChatWindowTextSize
    local white = Color3.new(1, 1, 1)
    local var3 = extraData.ChannelColor or white
    local num1 = 0

    local var4, var5 = Util:CreateBaseMessage("", var1, var2, white)
    local var6

    if originalChannel == arg1.OriginalChannel then
        var6 = nil
    else
        local str1 = string.format("{%s}", arg1.OriginalChannel)
        var6 = Util:AddChannelButtonToBaseMessage(var5, var3, str1, arg1.OriginalChannel)
        num1 = Util:GetNumberOfSpaces(str1, var1, var2) + 1
    end

    local function UpdateTextFunction(arg2)
        if not arg1.IsFiltered then
            local var7 = arg2.MessageLengthUtf8 or arg2.MessageLength
            local var8 = utf8.len(utf8.nfcnormalize(arg2.FromSpeaker)) + var7 - 4
            var5.Text = Util:CreateLeadingSpaces(num1) .. string.rep("_", var8)

            return
        end

        local var7 = var5
        local var8 = Util:CreateLeadingSpaces(num1)
        local var9 = Util
        local fromSpeaker = arg2.FromSpeaker
        local message = arg2.Message
        var7.Text = var8 .. var9:SanitizeForRichText(fromSpeaker .. " " .. string.sub(message, 5))
    end
    UpdateTextFunction(arg1)

    local function GetHeightFunction(arg2)
        return Util:GetMessageHeight(var5, var4, arg2)
    end

    local tbl1 = ({})
    tbl1[var5] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    if var6 then
        tbl1[var6] = {
            TextTransparency = { FadedIn = 0, FadedOut = 1 },
            TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
        }
    end

    local var7, var8, var9 = Util:CreateFadeFunctions(tbl1)

    return {
        [Util.KEY_BASE_FRAME] = var4,
        [Util.KEY_BASE_MESSAGE] = var5,
        [Util.KEY_UPDATE_TEXT_FUNC] = UpdateTextFunction,
        [Util.KEY_GET_HEIGHT] = GetHeightFunction,
        [Util.KEY_FADE_IN] = var7,
        [Util.KEY_FADE_OUT] = var8,
        [Util.KEY_UPDATE_ANIMATION] = var9
    }
end

return {
    [Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeMeCommand,
    [Util.KEY_CREATOR_FUNCTION] = CreateMeCommandMessageLabel
}
