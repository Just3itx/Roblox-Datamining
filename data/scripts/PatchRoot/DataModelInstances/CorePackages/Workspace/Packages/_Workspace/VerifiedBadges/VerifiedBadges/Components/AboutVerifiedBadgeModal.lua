-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local VerifiedBadgesParent = VerifiedBadges.Parent

local React = require(VerifiedBadgesParent.React)
local UIBlox = require(VerifiedBadgesParent.UIBlox)
local useSelector = require(VerifiedBadgesParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(VerifiedBadgesParent.Localization).Hooks.useLocalization

local constants = require(VerifiedBadges.constants)

local uDim = UDim.new(0, 24)
local uDim2 = UDim.new(0, 12)

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function AboutVerifiedBadgeModal(tbl1)
    local var1 = UIBlox.Core.Style.useStyle()
    local screenSize = useSelector(selectScreenSize)

    local var3 = useLocalization({
        titleText = "Feature.ProfileBadges.VerifiedBadgeInfoTitle",
        bodyText = "Feature.ProfileBadges.VerifiedBadgeInfo",
        learnMoreText = "Feature.ProfileBadges.VerifiedBadgeInfoLink"
    })

    local onCloseClicked = React.useCallback(function()
        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1 })

    local onActivated = React.useCallback(function()
        if tbl1.onConfirm then
            tbl1.onConfirm()
        end
    end, { tbl1 })

    return React.createElement(UIBlox.App.Dialog.Modal.PartialPageModal, {
        title = var3.titleText,
        screenSize = screenSize,
        buttonStackProps = {
            buttons = {{
                buttonType = UIBlox.App.Button.Enum.ButtonType.PrimarySystem,
                props = {
                    onActivated = onActivated,
                    text = var3.learnMoreText
                }
            }}
        },
        contentPadding = uDim,
        onCloseClicked = onCloseClicked
    }, {
        Wrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = uDim2
                    }
                ),
                Padding = React.createElement("UIPadding", { PaddingTop = uDim2, PaddingBottom = uDim2 }),
                Icon = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                    layoutOrder = 1,
                    text = constants.VERIFIED_EMOJI,
                    fontStyle = var1.Font.Title,
                    colorStyle = var1.Theme.TextEmphasis,
                    automaticSize = Enum.AutomaticSize.XY,
                    fluidSizing = false
                }),
                Body = React.createElement(UIBlox.App.Text.StyledTextLabel, {
                    layoutOrder = 2,
                    text = var3.bodyText,
                    fontStyle = var1.Font.Body,
                    colorStyle = var1.Theme.TextMuted,
                    size = UDim2.fromScale(1, 0),
                    automaticSize = Enum.AutomaticSize.Y,
                    fluidSizing = false
                })
            }
        )
    })
end

return AboutVerifiedBadgeModal
