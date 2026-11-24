-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)

local _DictationMode = require(script.Parent.DictationMode)
local DictationAnalytics = require(script.Parent.DictationAnalytics)

local function classifyEditType(current: string, text: string)
    if #text == 0 then
        return DictationAnalytics.EditTypes.FullClear
    end
    if #text > #current and string.sub(text, 1, #current) == current then
        return DictationAnalytics.EditTypes.Addition
    end
    if #text < #current and string.sub(current, 1, #text) == text then
        return DictationAnalytics.EditTypes.Deletion
    end
    return DictationAnalytics.EditTypes.Mixed
end

local function useSendTelemetry(tbl1)
    local enabled = tbl1.enabled
    local textBoxRef = tbl1.textBoxRef
    local customTextBoxRef = tbl1.customTextBoxRef

    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)

    local var3 = React.useRef(false)

    local stageTranscription = React.useCallback(function(str1: string, mode)
        if not enabled then
            return
        end
        var2.current = str1
        var1.current = {
            mode = mode,
            outcome = DictationAnalytics.Outcomes.Full,
            textStt = str1
        }
    end, { enabled })

    local consumeOnSend = React.useCallback(function(textSent: string)
        if not enabled then
            return nil
        end
        local current = var1.current
        var1.current = nil
        if current == nil then
            return nil
        end
        var3.current = true
        current.textSent = textSent
        return current
    end, { enabled })

    React.useEffect(function()
        if not enabled then
            return
        end
        local current = customTextBoxRef.current or textBoxRef.current
        if current == nil then
            return
        end
        local connection = current:GetPropertyChangedSignal("Text"):Connect(function()
            local current2 = var2.current
            if current2 == nil then
                return
            end

            if var3.current then
                var3.current = false
                var2.current = nil
                return
            end

            local currentText = current.Text
            if currentText == current2 then
                return
            end
            if var1.current then
                var1.current.outcome = DictationAnalytics.Outcomes.Partial
            end
            DictationAnalytics.fire(DictationAnalytics.Events.TextEdit, {
                [DictationAnalytics.Properties.SttMode] = DictationAnalytics.Modes.Standard,
                [DictationAnalytics.Properties.EditType] = classifyEditType(current2, currentText)
            })
        end)
        return function()
            connection:Disconnect()
        end
    end, { enabled, textBoxRef, customTextBoxRef })

    return { stageTranscription = stageTranscription, consumeOnSend = consumeOnSend }
end

return useSendTelemetry
