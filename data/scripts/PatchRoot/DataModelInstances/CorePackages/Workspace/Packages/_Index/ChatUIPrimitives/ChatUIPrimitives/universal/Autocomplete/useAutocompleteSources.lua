-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)

local _AutocompleteTypes = require(script.Parent.AutocompleteTypes)
local assertUniqueSourceIds = require(script.Parent.assertUniqueSourceIds)
local textBoxRange = require(script.Parent.textBoxRange)
local useAutocompleteKeyboardNavigation = require(script.Parent.useAutocompleteKeyboardNavigation)
local FFlagExpChatAutocompleteRematchOnCursorMove = require(ChatUIPrimitives.Flags.FFlagExpChatAutocompleteRematchOnCursorMove)

local tbl1 = {
    activated = false,
    sections = {},
    rows = {},
    selectedIndex = 0,
    keyboardIndex = 0
}

local function nextIndex(keyCode, selectedIndex: number, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if keyCode == Enum.KeyCode.Up then
        return if selectedIndex <= 0 then 1 elseif selectedIndex == 1 then num1 else selectedIndex - 1
    end

    if keyCode ~= Enum.KeyCode.Down then
        return nil
    end

    local num2 = selectedIndex + 1
    return if num1 < num2 then 1 else num2
end

local function indexSources(current) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    if current == nil then
        return result
    end
    assertUniqueSourceIds(current.sources)
    for _, value in current.sources do
        result[value.id] = value
    end
    return result
end

local function capResults(tbl2, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if #tbl2 <= num1 then
        return tbl2
    end
    local result = ({})
    for i = 1, num1 do
        result[i] = tbl2[i]
    end
    return result
end

local function useAutocompleteSources(tbl2, current, arg1)
    local var1, var2 = React.useState(tbl1)
    local var3 = React.useRef(var1)
    var3.current = var1

    local var4 = React.useRef(nil)
    local var5 = React.useRef({})
    local var6 = React.useRef(current)
    local var7 = React.useRef(0)
    local var8 = React.useRef("")
    local var9 = React.useRef(false)
    local var10 = React.useRef(0)
    local var11 = React.useRef(0)

    local function readCursor() -- Luacid: Inlined by compiler; 5 call sites recovered
        local current2 = tbl2.current
        if current2 ~= nil then
            local var12 = textBoxRange.readCursor(current2)
            if var12 ~= nil then
                return var12
            end
        end
        return var7.current
    end

    local function restoreFocus(num1: number?) -- Luacid: Inlined by compiler; 8 call sites recovered
        task.defer(function()
            var9.current = false
            if FFlagExpChatAutocompleteRematchOnCursorMove then
                var10.current = 0
            end
            local current2 = tbl2.current
            if current2 == nil then
                return
            end
            current2:CaptureFocus()

            if num1 ~= nil then
                textBoxRange.placeCursor(current2, num1)
            end
        end)
    end

    local function commitRow(num1: number): boolean
        local current2 = var3.current
        local row = current2.rows[num1]
        local current3 = tbl2.current
        if row == nil or current3 == nil then
            var9.current = true
            restoreFocus(nil)

            return false
        end
        local section = current2.sections[row.sectionIndex]
        local var12 = var5.current[row.sourceId]
        if section == nil or var12 == nil then
            var9.current = true
            restoreFocus(nil)

            return false
        end

        local var13 = var12.select(row.item)

        if var13 == nil then
            restoreFocus((readCursor()))
            return true
        end

        if var13.kind == "insert" then
            var9.current = true

            local var14, var15 = textBoxRange.splice(current3, section.replaceStart, section.replaceFinish, var13.text)
            if var14 then
                var2(tbl1)
            end

            restoreFocus(var15)
            return var14 == true
        end

        if var13.kind ~= "sendDraft" then
            restoreFocus((readCursor()))
            return true
        end

        local current4 = var4.current
        local onAction = if current4 == nil then nil else current4.onAction

        if onAction == nil or not onAction(var13) then
            restoreFocus((readCursor()))
        else
            var9.current = true
            current3.Text = ""
            var2(tbl1)
            restoreFocus(1)
        end
        return true
    end

    local var12 = React.useCallback(function(str1: string)
        if var9.current then
            return
        end
        local current2 = var4.current
        if current2 == nil then
            return
        end

        if utf8.len(str1) == nil then
            if var3.current.activated then
                var2(tbl1)
            end

            return
        end

        local var12 = readCursor()
        local current3 = tbl2.current
        if current3 ~= nil then
            for _, value in current2.sources do
                if value.matchCompletion == nil then
                    continue
                end

                local var13 = value.matchCompletion(str1, var12)
                if var13 == nil then
                    continue
                end

                var9.current = true
                local var14, var15 = textBoxRange.splice(current3, var13.replaceStart, var13.replaceFinish, var13.replacement)

                if var14 then
                    if var3.current.activated then
                        var2(tbl1)
                    end

                    restoreFocus(var15)
                    return
                end
                var9.current = false
            end
        end

        local sections = {}
        local rows = {}
        for _, value in current2.sources do
            local var13 = value.matchTrigger(str1, var12)
            if var13 == nil then
                continue
            end

            local var14 = if value.maxResults == nil then 20 else value.maxResults
            local results = capResults(value.search(var13.query), var14)
            if not (#results > 0) then
                continue
            end

            table.insert(
                sections,
                {
                    sourceId = value.id,
                    results = results,
                    replaceStart = var13.replaceStart,
                    replaceFinish = var13.replaceFinish
                }
            )
            local sectionsLen = #sections
            for rowIndex, value3 in results do
                table.insert(rows, { sourceId = value.id, item = value3, sectionIndex = sectionsLen, rowIndex = rowIndex })
            end
        end

        if not (#rows > 0) then
            if var3.current.activated then
                var2(tbl1)
            end

            return
        end

        var2({ activated = true, sections = sections, rows = rows, selectedIndex = 0, keyboardIndex = 0 })
    end, {})

    React.useEffect(function()
        local current2 = tbl2.current
        if current2 == nil or current == nil then
            return
        end

        local connection = current2:GetPropertyChangedSignal("CursorPosition"):Connect(function()
            local var13 = textBoxRange.readCursor(current2)
            if var13 == nil then
                return
            end

            var7.current = var13

            if not FFlagExpChatAutocompleteRematchOnCursorMove or not (os.clock() <= var10.current) then
                return
            end

            var10.current = 0

            if current2:IsFocused() and current2.Text == var8.current and var13 ~= var11.current then
                var12(current2.Text)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { tbl2.current, current })

    local var13 = React.useCallback(function(keyCode)
        local current2 = var3.current
        if not current2.activated or #current2.rows == 0 then
            return
        end

        if keyCode == Enum.KeyCode.Escape then
            var2(tbl1)
            if FFlagExpChatAutocompleteRematchOnCursorMove then
                var10.current = 0
            end
            local current3 = tbl2.current
            local current4 = var7.current
            task.defer(function()
                if current3 then
                    current3:CaptureFocus()
                    textBoxRange.placeCursor(current3, current4)
                end
            end)

            return
        end

        if nextIndex(keyCode, current2.selectedIndex, #current2.rows) == nil then
            return
        end

        var2(function(tbl3)
            local var13 = nextIndex(keyCode, tbl3.selectedIndex, #tbl3.rows)

            if var13 == nil then
                return tbl3
            end

            return {
                activated = tbl3.activated,
                sections = tbl3.sections,
                rows = tbl3.rows,
                selectedIndex = var13,
                keyboardIndex = var13
            }
        end)
    end, {})

    local var14 = useAutocompleteKeyboardNavigation
    local var15 = var1.activated and #var1.rows > 0
    if current == nil then
        var13 = nil
    end

    var14(var15, var13, arg1)

    React.useEffect(function()
        local current2 = var4.current
        if current2 == nil then
            return
        end

        local bool1 = false
        local tbl3 = {}
        for _, value in current2.sources do
            if value.subscribe == nil then
                continue
            end

            table.insert(tbl3, (value.subscribe(function()
                if bool1 then
                    return
                end
                var12(var8.current)
            end)))
        end
        local current3 = tbl2.current
        local var16 = if current3 ~= nil then current3.Text else var8.current
        var8.current = var16
        var12(var16)
        return function()
            bool1 = true
            for _, value in tbl3 do
                value()
            end
            var2(tbl1)
        end
    end, { current, var12 })

    local onTextChanged = React.useCallback(function(current2: string)
        var8.current = current2
        if FFlagExpChatAutocompleteRematchOnCursorMove and not var9.current then
            var10.current = os.clock() + 0.5
            var11.current = readCursor()
        end
        var12(current2)
    end, { var12 })

    local commitSelection = React.useCallback(function(num1: number)
        commitRow(num1)
    end, {})

    local interceptSend = React.useCallback(function(_, bool1: boolean)
        if not bool1 then
            return false
        end
        local current2 = var3.current
        if not current2.activated or #current2.rows == 0 or current2.selectedIndex < 1 then
            return false
        end
        return (commitRow(current2.selectedIndex))
    end, {})

    local dismiss = React.useCallback(function()
        var2(tbl1)
    end, {})

    local setSelectedIndex = React.useCallback(function(num1: number)
        var2(function(tbl3)
            return {
                activated = tbl3.activated,
                sections = tbl3.sections,
                rows = tbl3.rows,
                selectedIndex = math.clamp(num1, 1, math.max(1, #tbl3.rows)),
                keyboardIndex = tbl3.keyboardIndex
            }
        end)
    end, {})

    local renderEntry = React.useCallback(function(tbl3, bool1: boolean)
        local var21 = var5.current[tbl3.sourceId]
        if var21 == nil then
            return nil
        end
        return var21.renderEntry(tbl3.item, bool1)
    end, {})

    local tbl3 = indexSources(current)

    if var6.current ~= current then
        var6.current = current
        if var1.activated then
            var2(tbl1)
        end
    end
    var4.current = current
    var5.current = tbl3

    return {
        isOpen = var1.activated and #var1.rows > 0,
        results = var1.rows,
        selectedIndex = var1.selectedIndex,
        keyboardIndex = var1.keyboardIndex,
        renderEntry = renderEntry,
        onTextChanged = onTextChanged,
        setSelectedIndex = setSelectedIndex,
        commitSelection = commitSelection,
        interceptSend = interceptSend,
        dismiss = dismiss
    }
end

return useAutocompleteSources
