-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local Players = game:GetService("Players")
local getAppFeaturePolicies = require(AppChatParent.UniversalAppPolicy).getAppFeaturePolicies
local default = require(AppChatParent.LoggingProtocol).default

local KeystrokeEvent = require(AppChat.Analytics.KeystrokeEvent)

local getFIntAppChatBehaviorCollectionEnabledPercentage = require(AppChat.Flags.getFIntAppChatBehaviorCollectionEnabledPercentage)

local tbl1 = { Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter }

local function useKeystrokeCollection(tbl2)
    local var1 = React.useRef(false)
    local var2 = React.useRef({})
    local var3 = React.useRef({})
    local var4 = React.useRef({})

    React.useEffect(function()
        local var5 = getAppFeaturePolicies().getKeystrokeCollectionEnabled()
        local fIntAppChatBehaviorCollectionEnabledPercentage = getFIntAppChatBehaviorCollectionEnabledPercentage()
        if fIntAppChatBehaviorCollectionEnabledPercentage > 0 and Players.LocalPlayer and var5 then
            var1.current = Players.LocalPlayer.UserId % 100 < fIntAppChatBehaviorCollectionEnabledPercentage
        end
    end, {})

    local var5 = React.useCallback(function(chatContext: string)
        if not (#var2.current >= 0) then
            return
        end

        tbl2.eventLoggingFunc(default, KeystrokeEvent, {}, {
            chatContext = chatContext,
            keyPressedData = table.concat(var2.current, ","),
            eventTypeData = table.concat(var3.current, ","),
            timestampData = table.concat(var4.current, ",")
        })
        var2.current = {}
        var3.current = {}
        var4.current = {}
    end, { tbl2.eventLoggingFunc })

    return {
        recordKeystroke = React.useCallback(function(bool1: boolean, arg1)
            if not var1.current then
                return
            end

            if bool1 then
                table.insert(var2.current, arg1.Name)
                table.insert(var3.current, 0)
                table.insert(var4.current, DateTime.now().UnixTimestampMillis)
            elseif Cryo.List.find(tbl1, arg1) == nil or #var2.current ~= 0 then
                table.insert(var2.current, arg1.Name)
                table.insert(var3.current, 1)
                table.insert(var4.current, DateTime.now().UnixTimestampMillis)
            end

            if #var2.current >= (tbl2.maxKeystrokeDataLength or 200) then
                var5("UAMaxLengthReached")
            end
        end, { var5, tbl2.maxKeystrokeDataLength }),
        recordTextChange = React.useCallback(function(str1: string)
            if not var1.current then
                return
            end

            local str2 = string.sub(str1, -1)
            table.insert(var2.current, str2)
            table.insert(var4.current, DateTime.now().UnixTimestampMillis)

            if #var2.current >= (tbl2.maxKeystrokeDataLength or 200) then
                var5("UAMaxLengthReached")
            end
        end, { var5, tbl2.maxKeystrokeDataLength }),
        sendKeystrokeEventOnSend = React.useCallback(function()
            if var1.current then
                var5("UASendPressed")
            end
        end, { var5 })
    }
end

return useKeystrokeCollection
