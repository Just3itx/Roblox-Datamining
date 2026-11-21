-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local React = require(EditProfileBackgroundParent.React)
local Foundation = require(EditProfileBackgroundParent.Foundation)
local HeaderBar = require(EditProfileBackgroundParent.UIBlox).App.Bar.HeaderBar
local makeBackButton = require(EditProfileBackgroundParent.AppHeaderBar).makeBackButton
local useLocalization = require(EditProfileBackgroundParent.Localization).Hooks.useLocalization
local useLastInputMode = require(EditProfileBackgroundParent.FocusNavigationUtils).useLastInputMode

local View = Foundation.View

local function EditProfileBackgroundTopBar(tbl1)
    local bool1 = useLastInputMode() == "Focus"
    local var1 = useLocalization({ EditBackground = "Feature.Profile.Label.EditBackground" })

    local backButton = makeBackButton(tbl1.onClose)

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = "size-full-1200",
        LayoutOrder = tbl1.layoutOrder,
        ZIndex = 2
    }
    local tbl3 = { headerBar = 0 }
    local createElement2 = React.createElement
    local var3 = HeaderBar
    local tbl4 = {
        isSecondary = true,
        title = var1.EditBackground,
        backgroundTransparency = 1,
        barHeight = 48,
        renderLeft = 0
    }

    if bool1 then
        backButton = nil
    end

    tbl4.renderLeft = backButton
    tbl3.headerBar = createElement2(var3, tbl4)
    return createElement(var2, tbl2, tbl3)
end

return EditProfileBackgroundTopBar
