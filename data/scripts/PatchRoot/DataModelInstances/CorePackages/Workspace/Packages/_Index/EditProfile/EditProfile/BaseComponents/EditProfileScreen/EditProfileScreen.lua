-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)

local View = require(EditProfileParent.Foundation).View
local EditProfileHeaderBar = require(EditProfile.BaseComponents.EditProfileHeaderBar)
local useProfileCardWidth = require(EditProfileParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local FFlagAXEnableProfileTab = require(EditProfileParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneFullBleedEditProfile = require(EditProfileParent.SharedFlags).FFlagSplitPaneFullBleedEditProfile

return function(tbl1)
    local xOffset = useProfileCardWidth()
    local var1 = useLocalization({ title = tbl1.titleKey })

    local var2 = (FFlagAXEnableProfileTab or FFlagSplitPaneFullBleedEditProfile) and tbl1.fullBleed == true
    return React.createElement(View, {
        tag = (FFlagAXEnableProfileTab or FFlagSplitPaneFullBleedEditProfile)
            and {
                ["col items-start bg-surface-0"] = true,
                ["position-top-right anchor-top-right"] = not var2,
                ["size-full-full"] = var2
            }
            or "col bg-surface-0 anchor-top-right position-top-right items-start",
        Size = if var2 then nil else UDim2.new(0, xOffset, 1, 0)
    }, {
        TopBar = React.createElement(EditProfileHeaderBar, {
            onClose = tbl1.onClose,
            headerText = var1.title,
            onSave = tbl1.onSave,
            isLoading = tbl1.isLoading,
            isDisabled = tbl1.isDisabled
        }),
        Content = React.createElement(View, { tag = "col padding-xlarge gap-xxlarge size-full-0 auto-y" }, tbl1.component)
    })
end
