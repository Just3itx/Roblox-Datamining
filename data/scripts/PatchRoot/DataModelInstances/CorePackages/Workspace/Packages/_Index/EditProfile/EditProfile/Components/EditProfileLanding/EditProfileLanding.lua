-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconButton = Foundation.IconButton
local View = Foundation.View

local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local useProfileCardWidth = require(EditProfileParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local UserTile = require(EditProfileParent.UserTile)

local EditComponentRow = require(EditProfile.BaseComponents.EditComponentRow)
local EditProfileHeaderBar = require(EditProfile.BaseComponents.EditProfileHeaderBar)
local TextKeys = require(EditProfile.Common.TextKeys)
local FFlagEditProfileAlignBioTranslationKeys = require(EditProfile.Flags.FFlagEditProfileAlignBioTranslationKeys)
local FFlagAXEnableProfileTab = require(EditProfileParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneFullBleedEditProfile = require(EditProfileParent.SharedFlags).FFlagSplitPaneFullBleedEditProfile

local function EditProfileLanding(tbl1)
    local xOffset = useProfileCardWidth()
    local var1 = (FFlagAXEnableProfileTab or FFlagSplitPaneFullBleedEditProfile) and tbl1.fullBleed == true
    local displayNameLabel = if tbl1.isPolicyEnabled then TextKeys.AgedUpDisplayName else TextKeys.DisplayName
    local var3 = useLocalization({
        TopBarTitle = TextKeys.Title,
        UsernameLabel = TextKeys.Username,
        DisplayNameLabel = displayNameLabel,
        BioLabel = if FFlagEditProfileAlignBioTranslationKeys then TextKeys.Bio else TextKeys.About,
        BioPlaceholder = TextKeys.AboutPlaceholder
    })

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = FFlagAXEnableProfileTab
            and {
                ["col items-start bg-surface-0"] = true,
                ["position-top-right anchor-top-right"] = not var1,
                ["size-full-full"] = var1
            }
            or FFlagSplitPaneFullBleedEditProfile
                and {
                    ["col items-start bg-surface-0"] = true,
                    ["position-top-right anchor-top-right"] = not var1,
                    ["size-full-full"] = var1
                }
            or "col items-start position-top-right anchor-top-right bg-surface-0",
        Size = if var1 then nil else UDim2.new(0, xOffset, 1, 0)
    }
    local tbl3 = {
        TopBar = React.createElement(EditProfileHeaderBar, { onClose = tbl1.onClose, headerText = var3.TopBarTitle }),
        EditableComponents = 0
    }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = { tag = "col padding-xlarge gap-xxlarge size-full-0 auto-y" }

    local tbl5 = {
        AvatarEditRow = React.createElement(View, { tag = "size-full-2400", LayoutOrder = 1 }, {
            AvatarContainer = React.createElement(View, {
                tag = "size-2400-2400 position-center-center anchor-center-center"
            }, {
                AvatarHeadshot = React.createElement(View, { tag = "size-full-full" }, {
                    UserTile = React.createElement(
                        UserTile.UserTile,
                        {
                            userId = tbl1.userId,
                            layoutMode = UserTile.LayoutMode.compact,
                            onActivated = tbl1.settingButtonOnActivated.avatar
                        }
                    )
                }),
                EditAvatarIconButton = React.createElement(
                    View,
                    {
                        tag = "position-bottom-right anchor-bottom-right auto-xy bg-over-media-0 radius-circle"
                    },
                    {
                        IconButton = React.createElement(IconButton, {
                            icon = IconName.PhotoCamera,
                            size = IconSize.Small,
                            onActivated = tbl1.settingButtonOnActivated.avatar,
                            isCircular = true,
                            variant = ButtonVariant.Standard
                        })
                    }
                )
            })
        }),
        TextComponentsList = 0
    }

    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = { tag = "col size-full-0 auto-y bg-surface-100 radius-medium", LayoutOrder = 2 }

    local tbl7 = {
        EditDisplayNameRow = React.createElement(EditComponentRow, {
            label = var3.DisplayNameLabel,
            currentValue = tbl1.displayName,
            onActivated = tbl1.areNamesLoading and function() end or tbl1.settingButtonOnActivated.displayName,
            layoutOrder = 1,
            shouldShimmer = tbl1.areNamesLoading,
            forwardRef = tbl1.firstItemRef
        }),
        UsernameEditRow = React.createElement(EditComponentRow, {
            label = var3.UsernameLabel,
            currentValue = tbl1.username,
            onActivated = tbl1.settingButtonOnActivated.username,
            layoutOrder = 2,
            shouldShimmer = tbl1.areNamesLoading
        }),
        BioEditRow = React.createElement(EditComponentRow, {
            label = var3.BioLabel,
            currentValue = if tbl1.bioText ~= "" and tbl1.bioText ~= nil then tbl1.bioText else var3.BioPlaceholder,
            onActivated = tbl1.settingButtonOnActivated.bio,
            layoutOrder = 3,
            shouldShimmer = tbl1.isBioLoading
        })
    }
    tbl5.TextComponentsList = createElement3(var6, tbl6, tbl7)
    tbl3.EditableComponents = createElement2(var5, tbl4, tbl5)
    return createElement(var4, tbl2, tbl3)
end

return EditProfileLanding
