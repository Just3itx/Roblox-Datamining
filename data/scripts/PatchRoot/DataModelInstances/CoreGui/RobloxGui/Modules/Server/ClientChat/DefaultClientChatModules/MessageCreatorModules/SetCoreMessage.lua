-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ChatSettings = require(scriptParentParent:WaitForChild("ChatSettings"))
local ChatConstants = require(scriptParentParent:WaitForChild("ChatConstants"))
local Util = require(script.Parent:WaitForChild("Util"))

function CreateSetCoreMessageLabel(arg1, _)
    local message = arg1.Message
    local extraData = arg1.ExtraData or {}
    local var1 = extraData.Font or ChatSettings.DefaultFont
    local var2 = extraData.TextSize or ChatSettings.ChatWindowTextSize
    local var3 = extraData.Color or ChatSettings.DefaultMessageColor

    local var4, var5 = Util:CreateBaseMessage(message, var1, var2, var3)

    local function GetHeightFunction(arg2)
        return Util:GetMessageHeight(var5, var4, arg2)
    end

    local tbl1 = ({})
    tbl1[var5] = {
        TextTransparency = { FadedIn = 0, FadedOut = 1 },
        TextStrokeTransparency = { FadedIn = 0.75, FadedOut = 1 }
    }

    local var6, var7, var8 = Util:CreateFadeFunctions(tbl1)

    return {
        [Util.KEY_BASE_FRAME] = var4,
        [Util.KEY_BASE_MESSAGE] = var5,
        [Util.KEY_UPDATE_TEXT_FUNC] = nil,
        [Util.KEY_GET_HEIGHT] = GetHeightFunction,
        [Util.KEY_FADE_IN] = var6,
        [Util.KEY_FADE_OUT] = var7,
        [Util.KEY_UPDATE_ANIMATION] = var8
    }
end

return {
    [Util.KEY_MESSAGE_TYPE] = ChatConstants.MessageTypeSetCore,
    [Util.KEY_CREATOR_FUNCTION] = CreateSetCoreMessageLabel
}
