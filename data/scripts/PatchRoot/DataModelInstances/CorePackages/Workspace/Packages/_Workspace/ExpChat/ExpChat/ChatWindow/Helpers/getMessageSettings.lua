-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local Config = require(ExpChat.Config)
local memoize = require(ExpChat.memoize)

local FFlagEnableInExpChatRewrite = require(ExpChat.Flags.FFlagEnableInExpChatRewrite)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local formatGlobalChatPrefix = require(ExpChat.formatGlobalChatPrefix)

local function func1(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1 == nil or arg1 == ""
end

return (memoize(function(arg1, arg2, arg3)
    local tbl1 = {
        text = arg1.text or "",
        prefixText = if FFlagExpChatGlobalTabDefault then formatGlobalChatPrefix(arg1.prefixText or "", arg1, arg3) else arg1.prefixText or "",
        translation = arg1.translation or "",
        useTranslation = arg1.useTranslation,
        bodyTextProperties = {},
        prefixTextProperties = {},
        wasRewritten = if FFlagEnableInExpChatRewrite then arg1.wasRewritten or false else nil,
        originalText = if FFlagEnableInExpChatRewrite then arg1.originalText or "" else nil
    }

    if arg2 then
        for k, _ in pairs(Config.DefaultChatWindowMessagePropertiesInstanceSettings) do
            tbl1.bodyTextProperties[k] = arg2[k]
            tbl1.prefixTextProperties[k] = arg2[k]
        end
    end

    if arg1.chatWindowMessageProperties then
        local chatWindowMessageProperties = arg1.chatWindowMessageProperties

        tbl1.text = if func1(chatWindowMessageProperties.Text) then tbl1.text else chatWindowMessageProperties.Text

        tbl1.prefixText = if func1(chatWindowMessageProperties.PrefixText) then tbl1.prefixText else chatWindowMessageProperties.PrefixText

        tbl1.translation = if func1(chatWindowMessageProperties.Translation) then tbl1.translation else chatWindowMessageProperties.Translation

        for k, _ in pairs(Config.DefaultChatWindowMessagePropertiesInstanceSettings) do
            tbl1.bodyTextProperties[k] = chatWindowMessageProperties[k]
            tbl1.prefixTextProperties[k] = chatWindowMessageProperties[k]
        end

        if chatWindowMessageProperties.PrefixTextProperties then
            local prefixTextProperties = chatWindowMessageProperties.PrefixTextProperties

            tbl1.prefixText = if func1(prefixTextProperties.PrefixText) then tbl1.prefixText else prefixTextProperties.PrefixText

            for k, _ in pairs(Config.DefaultChatWindowMessagePropertiesInstanceSettings) do
                tbl1.prefixTextProperties[k] = prefixTextProperties[k]
            end

            local uiGradient = prefixTextProperties:FindFirstChildOfClass("UIGradient")
            if uiGradient then
                local tbl2 = ({})
                for k, _ in pairs(Config.DefaultChatWindowChildrenCustomizationProperties.UIGradient) do
                    tbl2[k] = uiGradient[k]
                end
                tbl1.prefixTextProperties.UIGradient = tbl2
            end
        end
    end

    return tbl1
end))
