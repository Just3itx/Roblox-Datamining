-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent
local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Sheet = Foundation.Sheet
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText

local uDim2 = UDim2.fromScale(0.375, 5 / 9)
local uDim2_2 = UDim2.fromScale(0.671875, 4 / 9)

local function PictogramCard(tbl1)
    return React.createElement(Foundation.View, {
        tag = "align-x-center align-y-center anchor-center-center size-2500-2500 stroke-emphasis radius-medium bg-surface-100",
        Position = tbl1.position,
        Rotation = tbl1.rotation,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId
    }, {
        Icon = React.createElement(Foundation.Text, {
            Text = getIconRichText(tbl1.icon),
            tag = "position-center-center anchor-center-center size-1800-1800 text-display-medium text-align-x-center content-emphasis",
            RichText = true
        })
    })
end

return React.memo(function(tbl1) -- name: GiftAgeCheckView
    return React.createElement(Sheet.Root, {
        isOpen = tbl1.isOpen,
        preferCenterSheet = true,
        size = DialogSize.Medium,
        snapPoints = { tbl1.mobileSnapPoint },
        onClose = tbl1.onClose,
        testId = "GiftAgeCheckView"
    }, {
        Content = React.createElement(Sheet.Content, {
            testId = "gift-age-check-content",
            LayoutOrder = 1
        }, {
            Body = React.createElement(Foundation.View, {
                tag = "col align-x-center gap-small size-full-0 auto-y"
            }, {
                Pictogram = React.createElement(Foundation.View, {
                    Size = tbl1.pictogramSize,
                    LayoutOrder = 1
                }, {
                    ShieldCard = React.createElement(
                        PictogramCard,
                        {
                            icon = IconName.ShieldCheck,
                            rotation = -15,
                            position = uDim2,
                            zIndex = 1,
                            testId = "gift-age-check-shield"
                        }
                    ),
                    GiftCard = React.createElement(
                        PictogramCard,
                        {
                            icon = IconName.GiftBox,
                            rotation = 15,
                            position = uDim2_2,
                            zIndex = 2,
                            testId = "gift-age-check-gift"
                        }
                    )
                }),
                Title = React.createElement(Foundation.Text, {
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
                    Text = tbl1.titleText,
                    testId = "gift-age-check-title",
                    LayoutOrder = 2
                }),
                Description = React.createElement(Foundation.Text, {
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                    Text = tbl1.descriptionText,
                    testId = "gift-age-check-description",
                    LayoutOrder = 3
                })
            })
        }),
        Actions = React.createElement(Sheet.Actions, { LayoutOrder = 2 }, {
            ContinueButton = React.createElement(Foundation.Button, {
                text = tbl1.continueLabel,
                variant = ButtonVariant.Emphasis,
                fillBehavior = FillBehavior.Fill,
                onActivated = tbl1.onContinue,
                testId = "gift-age-check-continue"
            })
        })
    })
end)
