-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local useLocalization = require(AvatarWorkshopParent.Localization).Hooks.useLocalization

local function TopBar(tbl1)
    local var1 = useLocalization({ headerText = tbl1.titleKey })

    return (React.createElement(
        Foundation.View,
        { tag = "row align-y-center gap-medium size-full-1200 padding-x-medium" },
        {
            BackButton = if tbl1.onBack then React.createElement(Foundation.Image, {
                tag = "size-600 radius-small",
                Image = "icons/navigation/pushBack",
                onActivated = tbl1.onBack,
                testId = "avatar-workshop-back-button",
                LayoutOrder = 1
            }) else nil,
            CloseButton = if tbl1.onBack then nil else React.createElement(Foundation.Image, {
                tag = "size-600 radius-small",
                Image = "icons/navigation/close",
                onActivated = tbl1.onClose,
                testId = "avatar-workshop-close-button",
                LayoutOrder = 1
            }),
            HeaderText = React.createElement(Foundation.Text, { tag = "auto-x text-title-large", Text = var1.headerText, LayoutOrder = 2 })
        }
    ))
end

return TopBar
