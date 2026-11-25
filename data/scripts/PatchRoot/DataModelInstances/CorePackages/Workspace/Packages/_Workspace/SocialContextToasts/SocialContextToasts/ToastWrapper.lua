-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToasts = script:FindFirstAncestor("SocialContextToasts")
local SocialContextToastsParent = SocialContextToasts.Parent
local React = require(SocialContextToastsParent.React)
local UIBlox = require(SocialContextToastsParent.UIBlox)
local Toast = UIBlox.App.Dialog.Toast
local useStyle = UIBlox.Core.Style.useStyle
local Colors = UIBlox.App.Style.Colors
local Cryo = require(SocialContextToastsParent.Cryo)
local CoPlayFooter = UIBlox.App.Tile.ExperienceTileMetadata.CoPlayFooter
local getLocalizedStrings = require(SocialContextToastsParent.NotificationsCommon).LocalizationHelper.getLocalizedStrings
local SocialContextToastAnalyticsActionTypes = require(SocialContextToasts.Enums.SocialContextToastAnalyticsActionTypes)
local SocialContextToastEvents = require(SocialContextToasts.SocialContextToastEvents)

local vector2 = Vector2.new(48, 48)
local vector2_2 = Vector2.new(36, 36)

local function makeCoPlayFooter(users, arg1, showEmphasisBorder) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        local offset = arg2.Size.X.Offset

        if #users ~= 1 then
            offset = (offset - -9) / 2
        end

        return React.createElement(CoPlayFooter, {
            users = users,
            size = arg2.Size,
            faceGroupCount = 1,
            showEmphasisBorder = showEmphasisBorder,
            styleProps = {
                faceWidth = offset,
                faceHeight = offset,
                faceGroupGap = -9,
                badgeHeight = offset,
                badgeBorderColor = arg1.Theme.SystemPrimaryContent,
                faceBorderColor = arg1.Theme.SystemPrimaryContent,
                faceBackgroundColor = {
                    Colors.Smoke,
                    Transparency = 0
                },
                showEmphasisBorder = showEmphasisBorder
            }
        })
    end
end

local tbl1 = { areUsersActive = true }

local function ToastWrapper(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local analyticsProps = var1.analyticsProps
    local var2 = React.useCallback(function()
        local friendId = if var1.userIdList then table.concat(var1.userIdList) else nil
        SocialContextToastEvents(analyticsProps.eventIngest, {
            toastType = analyticsProps.toastType,
            friendId = friendId,
            universeId = analyticsProps.gameId,
            placeId = analyticsProps.placeId,
            actionType = SocialContextToastAnalyticsActionTypes.ForceDismissed
        })
    end)

    if var1.onActivated == nil then
        var1.onActivated = var2
    end

    local var3 = useStyle()
    local localizedStrings = getLocalizedStrings(var1.toastStrings)

    local userIdList = var1.userIdList
    return React.createElement(Toast, {
        duration = 6,
        toastContent = {
            iconImage = if userIdList then makeCoPlayFooter(userIdList, var3, var1.areUsersActive) or nil else nil,
            toastTitle = localizedStrings.label,
            iconSize = if userIdList and #userIdList > 1 then vector2 else vector2_2,
            onActivated = var1.onActivated,
            buttonText = localizedStrings.button,
            buttonType = var1.buttonType,
            onTouchSwipeUp = var2
        }
    })
end

return ToastWrapper
