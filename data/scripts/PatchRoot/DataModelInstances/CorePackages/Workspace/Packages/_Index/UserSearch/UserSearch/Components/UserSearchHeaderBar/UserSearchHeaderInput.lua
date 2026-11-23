-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local React = require(UserSearchParent.React)
local UserSearchBar = require(UserSearchParent.SocialCommon).Components.UserSearchBar.UserSearchBar

local function UserSearchHeaderInput(tbl1)
    local initialInputText = tbl1.initialInputText
    local searchPlaceholderText = tbl1.searchPlaceholderText
    local cancelText = tbl1.cancelText
    local onCancel = tbl1.onCancel
    local onSubmit = tbl1.onSubmit
    local captureFocusOnMount = tbl1.captureFocusOnMount

    local var1 = React.useRef("")
    local var2 = React.useRef("")

    local textChangedCallback = React.useCallback(function(current: string)
        var2.current = var1.current
        var1.current = current
    end, {})

    local var4 = React.useCallback(function()
        if var1.current ~= var2.current then
            var2.current = var1.current
            onSubmit(var1.current)
        end
    end, { onSubmit })

    local focusChangedCallback = React.useCallback(function(arg1, arg2)
        if arg1 == false and arg2 then
            var4()
        end
    end, { var4 })

    local returnPressedFromOnScreenKeyboardCallback = React.useCallback(function()
        var4()
    end, { var4 })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        maxSize = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(400, math.huge) }),
        userSearchBar = React.createElement(UserSearchBar, {
            initialInputText = initialInputText,
            cancelText = cancelText,
            searchPlaceholderText = searchPlaceholderText,
            captureFocusOnMount = captureFocusOnMount,
            cancelCallback = onCancel,
            textChangedCallback = textChangedCallback,
            focusChangedCallback = focusChangedCallback,
            returnPressedFromOnScreenKeyboardCallback = returnPressedFromOnScreenKeyboardCallback
        })
    })
end

return UserSearchHeaderInput
