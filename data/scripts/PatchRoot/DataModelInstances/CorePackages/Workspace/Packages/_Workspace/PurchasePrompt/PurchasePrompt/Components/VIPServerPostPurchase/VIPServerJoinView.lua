-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local React = require(PurchasePromptParent.React)
local Foundation = require(PurchasePromptParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Button = Foundation.Button
local Sheet = Foundation.Sheet
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior

local function VIPServerJoinView(tbl1)
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        onClose = tbl1.onClose,
        preferCenterSheet = true,
        ref = tbl1.focusRootRef,
        testId = "VIPServerJoinView"
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = tbl1.locales.title,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-default"
                }
            )
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var1 = nil
    local tbl4 = {
        Body = React.createElement(View, { tag = "col gap-large size-full-0 auto-y" }, {
            Server = React.createElement(View, {
                tag = "row align-y-center gap-medium size-full-0 auto-y",
                LayoutOrder = 1
            }, {
                Thumbnail = React.createElement(Image, {
                    testId = "--purchase-prompt-image-game-thumbnail",
                    Image = tbl1.thumbnailUrl,
                    ScaleType = Enum.ScaleType.Crop,
                    tag = "size-2400-2400 radius-medium clip bg-surface-200",
                    LayoutOrder = 1
                }),
                Names = React.createElement(View, {
                    tag = "col fill gap-xsmall auto-y",
                    LayoutOrder = 2
                }, {
                    ServerName = React.createElement(FoundationText, {
                        testId = "--purchase-prompt-text-server-name",
                        Text = tbl1.serverName,
                        tag = "size-full-0 auto-y text-title-large text-align-x-left text-truncate-end content-emphasis",
                        LayoutOrder = 1
                    }),
                    GameName = React.createElement(FoundationText, {
                        testId = "--purchase-prompt-text-game-name",
                        Text = tbl1.gameName,
                        tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end content-muted",
                        LayoutOrder = 2
                    })
                })
            }),
            Error = if tbl1.hasError then React.createElement(FoundationText, {
                testId = "--purchase-prompt-text-error",
                Text = tbl1.locales.somethingWentWrong,
                tag = "auto-xy text-body-medium content-system-alert",
                LayoutOrder = 2
            }) else nil
        })
    }
    tbl3.Content = createElement2(content, var1, tbl4)

    tbl3.Actions = React.createElement(Sheet.Actions, nil, {
        Join = React.createElement(Button, {
            testId = "--purchase-prompt-button-join",
            text = tbl1.locales.join,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl1.onJoin,
            isLoading = tbl1.isJoining,
            ref = tbl1.joinButtonRef
        })
    })
    return createElement(root, tbl2, tbl3)
end

return VIPServerJoinView
