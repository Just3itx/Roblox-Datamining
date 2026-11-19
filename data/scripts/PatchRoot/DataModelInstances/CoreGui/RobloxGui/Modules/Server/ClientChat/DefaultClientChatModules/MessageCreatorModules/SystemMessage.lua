-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))
local ChatLocalization = nil

pcall(function()
    ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

function CreateSystemMessageLabel(arg1, originalChannel)
    local message = arg1.Message
    if ChatLocalization and ChatLocalization.LocalizeFormattedMessage then
        message = ChatLocalization:LocalizeFormattedMessage(message)
    end
    local extraData = arg1.ExtraData or {}
    local var1 = extraData.Font or ChatSettings.DefaultFont
    local var2 = extraData.TextSize or ChatSettings.ChatWindowTextSize
    local var3 = extraData.ChatColor or ChatSettings.DefaultMessageColor
    local var4 = extraData.ChannelColor or var3

    local var5, var6 = Util:CreateBaseMessage(message, var1, var2, var3)
    var6.AutoLocalize = true
    local var7

    if originalChannel == arg1.OriginalChannel then
        var7 = nil
    else
        local var8

        if ChatLocalization and arg1.OriginalChannel == "System" then
            local var9 = ChatLocalization:Get("InGame.Chat.Label.SystemMessagePrefix", "System")
            var8 = string.format("{%s}", var9)
        elseif ChatLocalization and arg1.OriginalChannel == "Team" then
            local var9 = ChatLocalization:Get("InGame.Chat.Label.TeamMessagePrefix", "System")
            var8 = string.format("{%s}", var9)
        else
            var8 = string.format("{%s}", arg1.OriginalChannel)
        end
        var7 = Util:AddChannelButtonToBaseMessage(var6, var4, var8, arg1.OriginalChannel)
        local var9 = Util:GetNumberOfSpaces(var8, var1, var2) + 1
        var6.Text = Util:CreateLeadingSpaces(var9) .. Util:SanitizeForRichText(message)
    end

    local function GetHeightFunction(arg2)
        return Util:GetMessageHeight(var6, var5, arg2)
    end

    local tbl1 = ({})
    tbl1[var6] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    if var7 then
        tbl1[var7] = {
            TextTransparency = { FadedIn = 0, FadedOut = 1 },
            TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
        }
    end

    local var8, var9, var10 = Util:CreateFadeFunctions(tbl1)

    return {
        [Util.KEY_BASE_FRAME] = var5,
        [Util.KEY_BASE_MESSAGE] = var6,
        [Util.KEY_UPDATE_TEXT_FUNC] = nil,
        [Util.KEY_GET_HEIGHT] = GetHeightFunction,
        [Util.KEY_FADE_IN] = var8,
        [Util.KEY_FADE_OUT] = var9,
        [Util.KEY_UPDATE_ANIMATION] = var10
    }
end

return {
    [Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeSystem,
    [Util.KEY_CREATOR_FUNCTION] = CreateSystemMessageLabel
}
