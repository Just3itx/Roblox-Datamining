-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local IconButton = Foundation.IconButton
local List = Foundation.List
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization
local useProfileCardWidth = require(EditProfileParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local UserTile = require(EditProfileParent.UserTile)

local EditProfileHeaderBar = require(EditProfile.BaseComponents.EditProfileHeaderBar)
local TextKeys = require(EditProfile.Common.TextKeys)
local FFlagEditProfileAlignBioTranslationKeys = require(EditProfile.Flags.FFlagEditProfileAlignBioTranslationKeys)
local FFlagAXEnableProfileTab = require(EditProfileParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneFullBleedEditProfile = require(EditProfileParent.SharedFlags).FFlagSplitPaneFullBleedEditProfile
local FFlagFixNonTruncatedText = require(EditProfile.Flags.FFlagFixNonTruncatedText)
local EditProfileProfileFramesSection = if require(EditProfileParent.SharedFlags).FFlagEditProfileFramesEnabled then require(EditProfile.Components.EditProfileLanding.EditProfileProfileFramesSection) else nil
local num1 = tonumber(game:DefineFastString("EditProfileLandingTrailingWidthRatio", "0.4")) or 0.4

local tbl1 = {
    isContained = true,
    hasDivider = { hasDivider = true, isInset = false }
}

local function renderRowTrailing(bool1: boolean, text: string, yOffset: number, num2: number?)
    if bool1 then
        return React.createElement(Skeleton, { Size = UDim2.new(0.3, 0, 0, yOffset), radius = Radius.Medium })
    elseif FFlagFixNonTruncatedText and num2 ~= nil then
        return React.createElement(FoundationText, {
            tag = "auto-y text-body-small text-align-x-right text-truncate-end",
            Text = text,
            Size = UDim2.new(0, num2 * num1, 0, 0)
        })
    end

    return React.createElement(FoundationText, { tag = "auto-xy text-body-small text-truncate-end", Text = text })
end

local function EditProfileLandingV2(tbl2)
    local xOffset = useProfileCardWidth()
    local var1 = useTokens()
    local var2 = (FFlagAXEnableProfileTab or FFlagSplitPaneFullBleedEditProfile) and tbl2.fullBleed == true
    local displayNameLabel = if tbl2.isPolicyEnabled then TextKeys.AgedUpDisplayName else TextKeys.DisplayName
    local var4 = useLocalization({
        TopBarTitle = TextKeys.Title,
        UsernameLabel = TextKeys.Username,
        DisplayNameLabel = displayNameLabel,
        BioLabel = if FFlagEditProfileAlignBioTranslationKeys then TextKeys.Bio else TextKeys.About,
        BioPlaceholder = TextKeys.AboutPlaceholder
    })
    local var5 = if tbl2.bioText ~= "" and tbl2.bioText ~= nil then string.gsub(tbl2.bioText, "\n", " ") else var4.BioPlaceholder
    local size400 = var1.Size.Size_400

    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        tag = (FFlagAXEnableProfileTab or FFlagSplitPaneFullBleedEditProfile)
            and {
                ["col items-start bg-surface-0"] = true,
                ["position-top-right anchor-top-right"] = not var2,
                ["size-full-full"] = var2
            }
            or "col items-start position-top-right anchor-top-right bg-surface-0",
        Size = if var2 then nil else UDim2.new(0, xOffset, 1, 0)
    }
    local tbl4 = {
        TopBar = React.createElement(EditProfileHeaderBar, { onClose = tbl2.onClose, headerText = var4.TopBarTitle }),
        EditableComponents = 0
    }
    local createElement2 = React.createElement
    local var7 = View
    local tbl5 = { tag = "col gap-xxlarge size-full-0 auto-y padding-xlarge" }

    local tbl6 = {
        AvatarEditRow = React.createElement(View, { tag = "size-full-2400", LayoutOrder = 1 }, {
            AvatarContainer = React.createElement(View, {
                tag = "position-center-center anchor-center-center size-2400-2400"
            }, {
                AvatarHeadshot = React.createElement(View, { tag = "size-full-full" }, {
                    UserTile = React.createElement(
                        UserTile.UserTile,
                        {
                            userId = tbl2.userId,
                            layoutMode = UserTile.LayoutMode.compact,
                            onActivated = tbl2.settingButtonOnActivated.avatar
                        }
                    )
                }),
                EditAvatarIconButton = React.createElement(
                    View,
                    {
                        tag = "position-bottom-right anchor-bottom-right auto-xy radius-circle bg-over-media-0"
                    },
                    {
                        IconButton = React.createElement(IconButton, {
                            icon = IconName.PhotoCamera,
                            size = IconSize.Small,
                            onActivated = tbl2.settingButtonOnActivated.avatar,
                            isCircular = true,
                            variant = ButtonVariant.Standard
                        })
                    }
                )
            })
        }),
        TextComponentsList = 0,
        ProfileFramesList = 0
    }

    local createElement3 = React.createElement
    local root = List.Root
    local tbl7 = {
        testId = "TextComponentsList",
        LayoutOrder = 2,
        isContained = tbl1.isContained,
        hasDivider = tbl1.hasDivider
    }
    local tbl8 = {
        EditDisplayNameRow = React.createElement(List.Item, {
            testId = "EditDisplayNameRow",
            title = var4.DisplayNameLabel,
            trailing = renderRowTrailing(tbl2.areNamesLoading, tbl2.displayName, size400, if FFlagFixNonTruncatedText then xOffset else nil),
            onActivated = not tbl2.areNamesLoading and {
                onActivated = tbl2.settingButtonOnActivated.displayName
            } or nil,
            LayoutOrder = 1,
            ref = tbl2.firstItemRef
        }),
        UsernameEditRow = React.createElement(List.Item, {
            testId = "UsernameEditRow",
            title = var4.UsernameLabel,
            trailing = renderRowTrailing(tbl2.areNamesLoading, tbl2.username, size400, if FFlagFixNonTruncatedText then xOffset else nil),
            onActivated = not tbl2.areNamesLoading and {
                onActivated = tbl2.settingButtonOnActivated.username
            } or nil,
            LayoutOrder = 2
        }),
        BioEditRow = 0
    }

    local createElement4 = React.createElement
    local item = List.Item
    local tbl9 = {
        testId = "BioEditRow",
        title = var4.BioLabel,
        trailing = 0,
        onActivated = 0,
        LayoutOrder = 3
    }
    local func1 = renderRowTrailing
    local isBioLoading = tbl2.isBioLoading

    if not FFlagFixNonTruncatedText then
        xOffset = nil
    end

    tbl9.trailing = func1(isBioLoading, var5, size400, xOffset)

    tbl9.onActivated = not tbl2.isBioLoading and {
        onActivated = tbl2.settingButtonOnActivated.bio
    } or nil
    tbl8.BioEditRow = createElement4(item, tbl9)
    tbl6.TextComponentsList = createElement3(root, tbl7, tbl8)

    tbl6.ProfileFramesList = if EditProfileProfileFramesSection == nil then nil else React.createElement(
        EditProfileProfileFramesSection,
        {
            userId = tbl2.userId,
            onActivated = tbl2.onProfileFramesActivated,
            layoutOrder = 3
        }
    )
    tbl4.EditableComponents = createElement2(var7, tbl5, tbl6)
    return createElement(var6, tbl3, tbl4)
end

return EditProfileLandingV2
