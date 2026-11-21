-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local useDictationInputBar = require(ChatUIPrimitivesParent.DictationCore.useDictationInputBar)
local Constants = require(ChatUIPrimitivesParent.DictationCore.Constants)
local getDictationInputMode = require(script.Parent.getDictationInputMode)

local DictationState = Constants.DictationState

local function useChatInputBarDictation(tbl1, tbl2, onSubmit: (...any) -> (...any), bool1: boolean, bool2: boolean)
    local bool3 = tbl1 ~= nil

    local hasText, var2 = React.useBinding(not bool1)
    React.useEffect(function()
        var2(not bool1)
    end, { bool1 })

    local getText = React.useCallback(function()
        local current = tbl2.current
        return if current then current.Text else nil
    end, { tbl2 })
    local setText = React.useCallback(function(currentText: string)
        local current = tbl2.current
        if current then
            current.Text = currentText
        end
    end, { tbl2 })

    local var5 = useDictationInputBar({
        getText = getText,
        setText = setText,
        onSubmit = onSubmit,
        hasText = hasText,
        inputMode = getDictationInputMode(if tbl1 then tbl1.handsFreeEnabled else nil),
        onError = if tbl1 then tbl1.onError else nil,
        containerName = if tbl1 then tbl1.surfaceName else nil,
        logger = if tbl1 then tbl1.logger else nil
    })

    local getDictationState = var5.dictation.getDictationState
    local cancel = var5.dictation.cancel
    React.useEffect(function()
        if not (bool2 and bool3) and getDictationState(false) ~= DictationState.Idle then
            cancel()
        end
    end, {
        bool2,
        bool3,
        getDictationState,
        cancel
    })

    local var6 = SignalsReact.useSignalState(getDictationState)
    return bool3, var5, bool3 and (var6 == DictationState.Recording or var6 == DictationState.Transcribing)
end

return useChatInputBarDictation
