-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent
local ReactUtils = require(CoreScriptsPlayerFeedbackParent.ReactUtils)
local GetFFlagEnablePlayerSupportPrompt = require(CoreScriptsPlayerFeedback.Flags.GetFFlagEnablePlayerSupportPrompt)

local React = require(CoreScriptsPlayerFeedbackParent.React)
local useEventConnection = ReactUtils.useEventConnection

local fFlagEnablePlayerSupportPrompt = GetFFlagEnablePlayerSupportPrompt()

local var1 = React.memo(function(tbl1)
    useEventConnection(tbl1.event, tbl1.handler)
    return nil
end)

return (React.memo(function(tbl1)
    local SocialService = game:GetService("SocialService")

    local var2 = React.useCallback(function()
        tbl1.openFeedbackPrompt()
    end, { tbl1.openFeedbackPrompt })
    local var3 = React.useCallback(function(feedbackType)
        local bool1 = false
        pcall(function()
            bool1 = feedbackType == Enum.FeedbackType.PlayerSupport
        end)
        if not bool1 then
            tbl1.openFeedbackPrompt()
            return
        end

        if tbl1.openPlayerSupportPrompt then
            tbl1.openPlayerSupportPrompt()
        else
            tbl1.openFeedbackPrompt()
        end
    end, { tbl1.openFeedbackPrompt, tbl1.openPlayerSupportPrompt })
    if not fFlagEnablePlayerSupportPrompt then
        var3 = var2
    end

    local var4 = React.useCallback(function(str1: string)
        if tbl1.openUnavailablePrompt then
            tbl1.openUnavailablePrompt(str1)
        end
    end, { tbl1.openUnavailablePrompt })
    local var5 = React.useCallback(function(str1: string, feedbackType)
        local bool1 = false
        pcall(function()
            bool1 = feedbackType == Enum.FeedbackType.PlayerSupport
        end)
        if bool1 then
            if tbl1.openPlayerSupportUnavailablePrompt then
                tbl1.openPlayerSupportUnavailablePrompt(str1)
            end
        elseif tbl1.openUnavailablePrompt then
            tbl1.openUnavailablePrompt(str1)
        end
    end, { tbl1.openUnavailablePrompt, tbl1.openPlayerSupportUnavailablePrompt })
    if fFlagEnablePlayerSupportPrompt then
        var4 = var5
    end

    local var6 = nil
    local var7 = nil
    local result

    if SocialService then
        local success

        success, result = pcall(function(): RBXScriptSignal
            return SocialService.ShowPromptFeedbackSubmission
        end)
        if not success then
            result = var6
        end

        local success2, result2 = pcall(function(): RBXScriptSignal
            return SocialService.ShowPromptFeedbackUnavailable
        end)
        if success2 then
            var7 = result2
        end
    else
        result = var6
    end

    return React.createElement(React.Fragment, {}, {
        Show = if result then React.createElement(var1, { event = result, handler = var3 }) or nil else nil,
        Unavailable = if var7 then React.createElement(var1, { event = var7, handler = var4 }) or nil else nil
    })
end))
