-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local React = require(SquadsParent.React)
local Foundation = require(SquadsParent.Foundation)

local Constants = require(Squads.Common.Constants)

local Dialog = Foundation.Dialog
local AvatarSize = Foundation.Enums.AvatarSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local function SquadLobbyJoinDialogView(tbl1)
    local tbl2 = {
        text = tbl1.joinText,
        variant = ButtonVariant.Emphasis,
        onActivated = tbl1.onJoin
    }

    local createElement = React.createElement
    local overlayProvider = Foundation.OverlayProvider
    local tbl3 = {
        DisplayOrder = Constants.SQUAD_LOBBY_MODAL_DISPLAY_ORDER
    }
    local tbl4 = { Dialog = 0 }
    local createElement2 = React.createElement
    local root = Dialog.Root
    local tbl5 = {
        ref = tbl1.dialogRef,
        size = DialogSize.Small,
        disablePortal = not (tbl1.disablePortal == nil) and tbl1.disablePortal,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        onClose = tbl1.onClose,
        testId = tbl1.testId
    }
    local tbl6 = {
        HeroMedia = if tbl1.gameImage then React.createElement(Dialog.HeroMedia, { media = tbl1.gameImage, aspectRatio = 16 / 9, scaleType = Enum.ScaleType.Crop }) else nil,
        Content = 0,
        Actions = 0
    }

    local createElement3 = React.createElement
    local content = Dialog.Content
    local tbl7 = { LayoutOrder = 2 }

    local tbl8 = { Details = 0 }
    local createElement4 = React.createElement
    local view = Foundation.View
    local tbl9 = { tag = "col gap-medium size-full-0 auto-y" }

    local tbl10 = { PlayerRow = 0, Rating = 0 }
    local createElement5 = React.createElement
    local view2 = Foundation.View
    local tbl11 = { tag = "row align-y-center gap-medium size-full-0 auto-y", LayoutOrder = 1 }

    local tbl12 = {
        Avatar = React.createElement(
            Foundation.Avatar,
            {
                userId = tbl1.userId,
                size = AvatarSize.Medium,
                LayoutOrder = 1,
                testId = `{tbl1.testId}--avatar`
            }
        ),
        TextColumn = React.createElement(
            Foundation.View,
            { tag = "col shrink gap-xxsmall size-full-0 auto-y", LayoutOrder = 2 },
            {
                PlayerName = if tbl1.playerName then React.createElement(Foundation.Text, {
                    tag = "size-full-0 auto-y text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis",
                    Text = tbl1.playerName,
                    LayoutOrder = 1,
                    testId = `{tbl1.testId}--player-name`
                }) else nil,
                PlayingRow = React.createElement(
                    Foundation.View,
                    { tag = "row align-y-center gap-xsmall size-full-0 auto-y", LayoutOrder = 2 },
                    {
                        IsPlaying = React.createElement(
                            Foundation.Text,
                            {
                                tag = "auto-xy text-body-medium text-no-wrap content-default",
                                Text = tbl1.isPlayingText,
                                LayoutOrder = 1
                            }
                        ),
                        ExperienceName = React.createElement(Foundation.Text, {
                            tag = "shrink auto-xy text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis",
                            Text = tbl1.experienceName,
                            LayoutOrder = 2,
                            testId = `{tbl1.testId}--experience-name`
                        })
                    }
                )
            }
        )
    }
    tbl10.PlayerRow = createElement5(view2, tbl11, tbl12)

    tbl10.Rating = if tbl1.rating then React.createElement(
        Foundation.View,
        {
            tag = "auto-xy",
            LayoutOrder = 2,
            testId = `{tbl1.testId}--rating`
        },
        tbl1.rating
    ) else nil
    tbl8.Details = createElement4(view, tbl9, tbl10)
    tbl6.Content = createElement3(content, tbl7, tbl8)

    tbl6.Actions = React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        orientation = EnumsOrientation.Vertical,
        actions = tbl1.viewProfileText
            and tbl1.onViewProfile
            and {
                tbl2,
                {
                    text = tbl1.viewProfileText,
                    variant = ButtonVariant.Standard,
                    onActivated = tbl1.onViewProfile
                }
            }
            or { tbl2 }
    })
    tbl4.Dialog = createElement2(root, tbl5, tbl6)
    return createElement(overlayProvider, tbl3, tbl4)
end

return SquadLobbyJoinDialogView
