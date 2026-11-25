-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local React = require(SocialCommonParent.React)
local _Foundation = require(SocialCommonParent.Foundation)
local FFlagLuaAppAllowNilHookDepsCleanup = require(SocialCommonParent.SharedFlags).FFlagLuaAppAllowNilHookDepsCleanup

local InputHandlers = require(SocialCommonParent.InputHandlers)
local ReactFocusNavigation = require(SocialCommonParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = require(SocialCommonParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local _SearchFieldView = require(script.Parent.SearchFieldView)

local function useSearchFieldViewModel(tbl1)
    local inputRef = React.useRef(nil)
    local onExit = tbl1.onExit
    local onChanged = tbl1.onChanged

    local var2 = React.useRef(Enum.KeyCode.None)

    local var3 = React.useRef(false)

    local onFocusLost = React.useCallback(function(arg1)
        local var4 = var2
        var4.current = if arg1 then arg1.KeyCode else Enum.KeyCode.None

        var3.current = false
    end, {})

    local var5 = React.useCallback(InputHandlers.onRelease(function(arg1)
        local current = var2.current
        local bool1 = not (current == Enum.KeyCode.None or arg1.eventData == nil) and arg1.eventData.KeyCode == current

        if not bool1 and onExit == nil then
            return
        end

        arg1:cancel()

        if bool1 then
            var2.current = Enum.KeyCode.None
            return
        end

        onExit()
    end), { onExit or false })

    local var6 = React.useRef(nil)
    local containerRef = ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, var5, nil, var6)

    local var8 = React.useCallback(function(): boolean
        local textBox = UserInputService:GetFocusedTextBox()
        local current = var6.current
        if not textBox or not current or textBox:IsDescendantOf(current) then
            return false
        end

        textBox:ReleaseFocus()
        return true
    end, {})

    React.useEffect(function()
        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            local current = var6.current
            local textBox = UserInputService:GetFocusedTextBox()
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch
                or not current
                or not textBox
                or textBox:IsDescendantOf(current)
            then
                return
            end
            local basePlayerGui = current:FindFirstAncestorWhichIsA("BasePlayerGui")
            if not basePlayerGui then
                return
            end
            for _, value in basePlayerGui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y) do
                if not value.Active then
                    continue
                end

                if value:IsDescendantOf(current) and var8() and inputRef.current then
                    inputRef.current.focus()
                end
                return
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var8 })

    local var9 = ReactFocusNavigation.useFocusGuiObject()
    local var10 = React.useContext(ReactFocusNavigation.FocusNavigationContext)

    local useCallback = React.useCallback
    local function func1()
        if var6.current and var10 and var10.focusedGuiObject:getValue() ~= nil then
            var9(var6.current)
        end
    end

    local var11 = if FFlagLuaAppAllowNilHookDepsCleanup then var10 else var10 or false
    local var12 = useCallback(func1, { var9, var11 })

    local var1 = React.useCallback(function(str1: string)
        if str1 == "" then
            var3.current = true
            var12()
            if inputRef.current then
                inputRef.current.focus()
            end
        end
        onChanged(str1)
    end, { onChanged, var12 })

    local onFocusGained = tbl1.onFocusGained
    local var14 = React.useCallback(function()
        if var3.current then
            var3.current = false
            return
        end
        if onFocusGained then
            onFocusGained()
        end
    end, { onFocusGained })

    local shouldAutoFocus = tbl1.shouldAutoFocus or false
    React.useEffect(function()
        if not shouldAutoFocus then
            return
        end

        var12()
        var8()
        if inputRef.current then
            inputRef.current.focus()
        end
    end, { shouldAutoFocus, var12, var8 })

    local tbl2 = {
        text = tbl1.text,
        placeholder = tbl1.placeholder,
        onChanged = var1,
        onFocusGained = 0,
        onFocusLost = 0,
        inputRef = 0,
        containerRef = 0,
        testId = 0,
        LayoutOrder = 0
    }

    if not onFocusGained then
        var14 = nil
    end

    tbl2.onFocusGained = var14
    tbl2.onFocusLost = onFocusLost
    tbl2.inputRef = inputRef

    tbl2.containerRef = containerRef
    tbl2.testId = tbl1.testId
    tbl2.LayoutOrder = tbl1.LayoutOrder
    return tbl2
end

return useSearchFieldViewModel
