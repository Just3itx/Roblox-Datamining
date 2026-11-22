-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local ArgCheck = require(NavigationRoduxParent.ArgCheck)
local NavigateDown = require(NavigationRodux.Thunks.NavigateDown)
local AppPage = require(NavigationRoduxParent.RobloxAppEnums).AppPage

return function(detail, onClose)
    ArgCheck.isInTypes(detail, { "string", "number" }, "userId")
    ArgCheck.isTypeOrNil(onClose, "function", "onClose")

    return NavigateDown({ name = AppPage.ViewUserProfile, detail = detail, extraProps = { onClose = onClose } })
end
