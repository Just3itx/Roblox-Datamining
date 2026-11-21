-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local React = require(ExpChatIntegrationParent.React)
local SignalsReact = require(ExpChatIntegrationParent.SignalsReact)

local _ChatPlatformContext = require(script.Parent.ChatPlatformContext)
local useChatPlatform = require(script.Parent.useChatPlatform)

local FFlagExpChatAddressFrame0Flash = require(ExpChatIntegrationParent.ChatUIPrimitives).Flags.FFlagExpChatAddressFrame0Flash

local function useInterpolatedClientSettings(arg1)
    local getInterpolators = useChatPlatform().getInterpolators
    local var1 = SignalsReact.useSignalState(getInterpolators)
    local getBackgroundColor = var1.getBackgroundColor
    local getBackgroundTransparency = var1.getBackgroundTransparency

    local var2, var3 = React.useState({
        BackgroundColor3 = if FFlagExpChatAddressFrame0Flash then getBackgroundColor(arg1) else nil,
        BackgroundColor = if FFlagExpChatAddressFrame0Flash then nil else getBackgroundColor(arg1),
        BackgroundTransparency = getBackgroundTransparency(arg1)
    })

    React.useEffect(function()
        var3({ BackgroundColor3 = getBackgroundColor(arg1), BackgroundTransparency = getBackgroundTransparency(arg1) })
    end, { arg1, getBackgroundColor, getBackgroundTransparency })

    return var2
end

return useInterpolatedClientSettings
