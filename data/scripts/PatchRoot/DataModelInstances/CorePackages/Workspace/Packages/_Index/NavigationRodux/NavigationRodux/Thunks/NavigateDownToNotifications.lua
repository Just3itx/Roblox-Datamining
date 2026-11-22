-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local ArgCheck = require(NavigationRoduxParent.ArgCheck)
local NavigateDown = require(NavigationRodux.Thunks.NavigateDown)
local AppPage = require(NavigationRoduxParent.RobloxAppEnums).AppPage

return function(onClose)
    ArgCheck.isTypeOrNil(onClose, "function", "onClose")

    return NavigateDown({ name = AppPage.Notifications, extraProps = { onClose = onClose } })
end
