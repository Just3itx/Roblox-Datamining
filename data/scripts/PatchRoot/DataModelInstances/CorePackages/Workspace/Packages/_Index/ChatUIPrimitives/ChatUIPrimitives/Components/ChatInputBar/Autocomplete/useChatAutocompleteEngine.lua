-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Cryo = require(ChatUIPrimitivesParent.Cryo)
local React = require(ChatUIPrimitivesParent.React)

local internalProviders = require(script.Parent.internalProviders)

local FFlagExpChatAutocompleteOptimization = require(ChatUIPrimitivesParent.SharedFlags).FFlagExpChatAutocompleteOptimization

local FFlagExpChatAutocompleteLazyBuild = require(ChatUIPrimitives.Flags.FFlagExpChatAutocompleteLazyBuild)
local FFlagExpChatMemoizeAutocompleteCallback = require(ChatUIPrimitives.Flags.FFlagExpChatMemoizeAutocompleteCallback)

local tbl1 = {
    activated = false,
    results = {},
    selectedIndex = 0,
    keyboardIndex = 0,
    currentMatch = nil
}

local function spliceInto(current, replaceStart: number, replaceFinish: number, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local currentText = current.Text
    current.Text = string.sub(currentText, 1, replaceStart - 1) .. str1 .. string.sub(currentText, replaceFinish + 1)
    current.CursorPosition = replaceStart + #str1
end

local function useChatAutocompleteEngine(tbl2, tbl3)
    local commands = if tbl3 then tbl3.commands else nil
    local current = if tbl3 then not not tbl3.emojis else false

    local var1 = React.useMemo(function()
        if not (commands or current) then
            return nil
        end
        if not FFlagExpChatAutocompleteOptimization then
            return internalProviders.buildTrie(commands, current)
        end

        return {
            emoji = if current and not FFlagExpChatAutocompleteLazyBuild then internalProviders.getEmojiStructure() else nil,
            command = if commands then internalProviders.buildCommandTrie(commands) else nil
        }
    end, { commands or false, current })

    local var2, var3 = React.useState(tbl1)
    local var4 = React.useRef(0)
    local var5 = React.useRef(false)
    local var6 = React.useRef(var2)
    var6.current = var2
    local var7 = React.useRef(var1)
    var7.current = var1
    local var8 = React.useRef(current)
    var8.current = current

    local actionName = "ChatAutocompleteSink_" .. tostring(tbl2)

    React.useEffect(function()
        local current = tbl2.current
        if not current or not tbl3 then
            return
        end

        local connection = current:GetPropertyChangedSignal("CursorPosition"):Connect(function()
            local cursorPosition = current.CursorPosition
            if cursorPosition >= 0 then
                var4.current = cursorPosition
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl2.current, tbl3 })

    local function spliceResultImpl(num1: number)
        local current = var6.current
        local result = current.results[num1]
        local current2 = tbl2.current
        local currentMatch = current.currentMatch
        if not (result and current2 and currentMatch) then
            return
        end

        spliceInto(
            current2,
            currentMatch.replaceStart,
            currentMatch.replaceFinish,
            (internalProviders.formatReplacement(result))
        )
        var3(tbl1)
    end

    if FFlagExpChatMemoizeAutocompleteCallback then
        spliceResultImpl = React.useCallback(spliceResultImpl, { tbl2 })
    end

    local function commitSelectionImpl(num1: number)
        var5.current = true
        spliceResultImpl(num1)
        task.defer(function()
            var5.current = false
            local current = tbl2.current
            if current then
                current:CaptureFocus()
            end
        end)
    end

    if FFlagExpChatMemoizeAutocompleteCallback then
        commitSelectionImpl = React.useCallback(commitSelectionImpl, { spliceResultImpl, tbl2 })
    end

    React.useEffect(function()
        if not tbl3 then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            local current = var6.current
            if not current.activated or #current.results == 0 then
                return
            end

            if input.KeyCode == Enum.KeyCode.Up then
                var3(function(arg1)
                    local var9 = if arg1.selectedIndex <= 0 then 1 else arg1.selectedIndex == 1 and #arg1.results or arg1.selectedIndex - 1

                    return {
                        activated = arg1.activated,
                        results = arg1.results,
                        selectedIndex = var9,
                        keyboardIndex = var9,
                        currentMatch = arg1.currentMatch
                    }
                end)

                return
            end

            if input.KeyCode == Enum.KeyCode.Down then
                var3(function(arg1)
                    local var9 = arg1.selectedIndex + 1
                    local var10 = if #arg1.results < var9 then 1 else var9

                    return {
                        activated = arg1.activated,
                        results = arg1.results,
                        selectedIndex = var10,
                        keyboardIndex = var10,
                        currentMatch = arg1.currentMatch
                    }
                end)
            elseif input.KeyCode == Enum.KeyCode.Escape then
                var3(tbl1)
                local current2 = tbl2.current
                task.defer(function()
                    if current2 then
                        current2:CaptureFocus()
                        current2.CursorPosition = var4.current
                    end
                end)
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl3 })

    React.useEffect(function()
        if not var2.activated or #var2.results == 0 then
            return
        end

        ContextActionService:BindCoreAction(actionName, function(): Enum.ContextActionResult
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Escape)
        return function()
            ContextActionService:UnbindCoreAction(actionName)
        end
    end, { var2.activated, #var2.results })

    local onTextChanged = React.useCallback(function(str1: string)
        if var5.current then
            return
        end
        local current = var7.current
        if not current then
            return
        end
        local current2 = tbl2.current
        local var9 = if current2 and current2.CursorPosition >= 0 then current2.CursorPosition else var4.current

        if var8.current and current2 then
            local var10 = internalProviders.matchColonCompletion(str1, var9)
            if var10 then
                var5.current = true
                spliceInto(current2, var10.replaceStart, var10.replaceFinish, var10.replacement)
                task.defer(function()
                    var5.current = false
                    local current3 = tbl2.current
                    if current3 then
                        current3:CaptureFocus()
                    end
                end)
                if var6.current.activated then
                    var3(tbl1)
                end
                return
            end
        end

        local currentMatch = internalProviders.matchTrigger(str1, var9)
        if not currentMatch then
            if var6.current.activated then
                var3(tbl1)
            end
            return
        end

        if FFlagExpChatAutocompleteOptimization
            and FFlagExpChatAutocompleteLazyBuild
            and var8.current
            and not current.emoji
            and string.sub(currentMatch.query, 1, 1) == ":"
        then
            current.emoji = internalProviders.getEmojiStructure()
        end

        local var11 = if FFlagExpChatAutocompleteOptimization then internalProviders.searchStructures(current, currentMatch.query) else internalProviders.search(current, currentMatch.query)

        if #var11 > 20 then
            var11 = Cryo.List.getRange(var11, 1, 20)
        end
        var3({ activated = #var11 > 0, results = var11, selectedIndex = 0, keyboardIndex = 0, currentMatch = currentMatch })
    end, {})

    local interceptSend = React.useCallback(function(arg1, bool2: boolean): boolean
        if not bool2 then
            return false
        end
        local current = var6.current
        if not current.activated or #current.results == 0 then
            return false
        end
        if current.selectedIndex < 1 then
            return false
        end
        var5.current = true
        spliceResultImpl(current.selectedIndex)
        task.defer(function()
            var5.current = false
            if arg1 then
                arg1:CaptureFocus()
            end
        end)
        return true
    end, { if FFlagExpChatMemoizeAutocompleteCallback then spliceResultImpl else nil })

    local dismiss = React.useCallback(function()
        var3(tbl1)
    end, {})

    local setSelectedIndex = React.useCallback(function(num1: number)
        var3(function(arg1)
            return {
                activated = arg1.activated,
                results = arg1.results,
                selectedIndex = math.clamp(num1, 1, math.max(1, #arg1.results)),
                keyboardIndex = arg1.keyboardIndex,
                currentMatch = arg1.currentMatch
            }
        end)
    end, {})

    return {
        isOpen = var2.activated and #var2.results > 0,
        results = var2.results,
        selectedIndex = var2.selectedIndex,
        keyboardIndex = var2.keyboardIndex,
        renderEntry = internalProviders.renderEntry,
        onTextChanged = onTextChanged,
        setSelectedIndex = setSelectedIndex,
        commitSelection = commitSelectionImpl,
        interceptSend = interceptSend,
        dismiss = dismiss
    }
end

return useChatAutocompleteEngine
