-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local RoactUtils = require(UserListParent.RoactUtils)
local Foundation = require(UserListParent.Foundation)

local useTopBarHeight = require(UserListParent.RobloxAppHooks).useTopBarHeight
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local View = Foundation.View
local IconButton = Foundation.IconButton

return function(arg1)
    local yOffset = useSelector(function(arg2)
        return arg2.TopBar.statusBarHeight
    end)
    local yOffset2 = useTopBarHeight()

    local onActivated = React.useCallback(function()
        arg1.navigateBack()
    end, { arg1.navigateBack })

    return React.createElement(View, {
        tag = "bg-surface-100",
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 0, 0, yOffset2),
        Active = true,
        BorderSizePixel = 0
    }, {
        LeftNavigationButton = React.createElement(IconButton, {
            Position = UDim2.new(0, 15, 0, yOffset),
            BackgroundTransparency = 1,
            onActivated = onActivated,
            icon = "icons/navigation/close"
        })
    })
end
