-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local _editProfileImageHelpers = require(AvatarExperienceProfilePictureEditor.Utils.editProfileImageHelpers)

local function EditProfileImageFooter(tbl1)
    local tbl2

    if tbl1.footerCta == "purchaseEmote" then
        local selectedEmoteId = tbl1.selectedEmoteId
        tbl2 = {
            Purchase = tbl1.renderRecommendedEmotePurchaseFooter(selectedEmoteId)
        }
    else
        tbl2 = tbl1.footerCta == "subscribePlus"
            and {
                Subscribe = React.createElement(Button, {
                    text = tbl1.localizedSubscribeLabel,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    fillBehavior = FillBehavior.Fill,
                    onActivated = function()
                        tbl1.onOpenProfileFramesSubscriptionUpsell("footer")
                    end,
                    LayoutOrder = 1
                })
            }
            or {
                Save = React.createElement(Button, {
                    text = tbl1.localizedSaveLabel,
                    variant = ButtonVariant.Emphasis,
                    size = InputSize.Medium,
                    fillBehavior = FillBehavior.Fill,
                    isLoading = tbl1.isSaving,
                    isDisabled = tbl1.isSaving,
                    onActivated = tbl1.onSave,
                    LayoutOrder = 1
                })
            }
    end

    return React.createElement(View, {
        tag = "row gap-small size-full-0 auto-y padding-x-xlarge padding-bottom-medium padding-top-medium",
        LayoutOrder = tbl1.layoutOrder
    }, tbl2)
end

return EditProfileImageFooter
