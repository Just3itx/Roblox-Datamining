-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)

local FFlagExpChatComposerInputBarFigmaParity = require(ExpChat.Flags.FFlagExpChatComposerInputBarFigmaParity)

local Localization = require(ExpChat.Localization)

local _useDictationInputBar = require(script.Parent.useDictationInputBar)

local function lerp(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return num1 + (num2 - num1) * num3
end

local function useDictationTextArea(arg1, tbl1)
    local var1 = Localization.useLocalization({ transcribingText = "CoreScripts.TextChat.ChatWindow.Transcribing" })

    local currentText = if not var1.transcribingText or var1.transcribingText == "" then "Transcribing..." else var1.transcribingText
    local isAudioActive = if arg1 then arg1.dictation.bindings.isAudioActive else nil
    local chatInputBarSettings = if arg1 then arg1.chatInputBarSettings else nil
    local state = if arg1 then arg1.state else nil
    local isTranscribing = if arg1 then arg1.isTranscribing else false
    local num1 = if tbl1.showPlaceholderText and not FFlagExpChatComposerInputBarFigmaParity then 0.5 else 0

    local textTransparency = React.useMemo(function()
        if isAudioActive == nil then
            return tbl1.transparencyValue:map(function(num2: number): number
                return lerp(num1, 1, num2)
            end)
        end
        return React.joinBindings({ fade = tbl1.transparencyValue, hide = isAudioActive }):map(function(arg2): number
            return lerp(if arg2.hide then 1 else num1, 1, arg2.fade)
        end)
    end, { tbl1.transparencyValue, isAudioActive, num1 })

    local var4 = if chatInputBarSettings then chatInputBarSettings.TextStrokeTransparency else 0
    local textStrokeTransparency = React.useMemo(function()
        if isAudioActive == nil then
            return tbl1.transparencyValue:map(function(num2: number): number
                return lerp(var4, 1, num2)
            end)
        end
        return React.joinBindings({ fade = tbl1.transparencyValue, hide = isAudioActive }):map(function(arg2): number
            return lerp(if arg2.hide then 1 else var4, 1, arg2.fade)
        end)
    end, { tbl1.transparencyValue, isAudioActive, var4 })

    local customTextBoxRef = if arg1 then arg1.customTextBoxRef else nil
    local textBoxRef = if arg1 then arg1.textBoxRef else nil
    local placeholderColor3 = if chatInputBarSettings then chatInputBarSettings.PlaceholderColor3 else nil
    local textColor3 = if chatInputBarSettings then chatInputBarSettings.TextColor3 else nil

    React.useEffect(function()
        if customTextBoxRef == nil or textBoxRef == nil then
            return
        end

        local current = if customTextBoxRef.current then customTextBoxRef.current else textBoxRef.current

        if current == nil then
            return
        end

        if isTranscribing then
            current.Text = currentText
            current.TextEditable = false
            current.TextColor3 = placeholderColor3
        else
            current.TextEditable = true
            current.TextColor3 = textColor3

            if current.Text == currentText then
                current.Text = ""
            end
        end
    end, {
        state,
        isTranscribing,
        currentText,
        customTextBoxRef,
        textBoxRef,
        placeholderColor3,
        textColor3
    })

    return { textTransparency = textTransparency, textStrokeTransparency = textStrokeTransparency }
end

return useDictationTextArea
