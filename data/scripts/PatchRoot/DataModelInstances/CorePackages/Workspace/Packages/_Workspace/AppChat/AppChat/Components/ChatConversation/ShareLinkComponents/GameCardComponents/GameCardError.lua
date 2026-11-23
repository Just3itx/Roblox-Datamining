-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local Image, _ = require(AppChat.Utils.loadFoundationCloudAsset)("pictograms/alert")

function GameCardError()
    local var2 = useTokens()
    local var3 = useLocalization({ contentLoadingFailed = "Feature.Chat.Label.ContentLoadingFailed" })

    return React.createElement(
        Foundation.View,
        { tag = "size-full-0 auto-xy bg-action-subtle align-x-center col padding-xxlarge" },
        {
            LoadingFailedImage = React.createElement(
                Foundation.Image,
                {
                    Image = Image,
                    imageStyle = var2.Color.System.Contrast,
                    tag = "size-1600",
                    ScaleType = Enum.ScaleType.Fit
                }
            ),
            LoadingFailedText = React.createElement(Foundation.Text, {
                tag = "auto-xy text-wrap",
                Text = var3.contentLoadingFailed,
                textStyle = var2.Color.System.Contrast,
                fontStyle = var2.Typography.BodyLarge,
                LayoutOrder = 2
            })
        }
    )
end

return React.memo(GameCardError)
