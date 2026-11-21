-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent
local React = require(FlyoutSidePanelParent.React)
local BuilderIcons = require(FlyoutSidePanelParent.BuilderIcons)
local Foundation = require(FlyoutSidePanelParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local LoadableImage = require(FlyoutSidePanelParent.UIBlox).App.Loading.LoadableImage
local useSelector = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useSelector
local getStandardSizeAvatarHeadShotRbxthumb = require(FlyoutSidePanelParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local FFlagFlyoutAlternateEntryPointUseProfileFrameThumbnail = require(FlyoutSidePanel.Flags.FFlagFlyoutAlternateEntryPointUseProfileFrameThumbnail)

local function FlyoutAlternateEntryPoint()
    local var1 = useTokens()
    local var2 = useSelector(function(arg1)
        return arg1.Users[arg1.LocalUserId]
    end)
    local image = React.useMemo(function()
        if var2 and var2.id then
            return getStandardSizeAvatarHeadShotRbxthumb(var2.id, FFlagFlyoutAlternateEntryPointUseProfileFrameThumbnail)
        end

        return nil
    end, { var2 })

    return React.createElement(Foundation.Icon, {
        tag = "position-center-center anchor-center-center content-emphasis align-y-center",
        name = BuilderIcons.Icon.ThreeHorizontalBarsWrappingRight,
        size = var1.Size.Size_800
    }, {
        UserAvatar = React.createElement(LoadableImage, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, var1.Size.Size_50, 0.5, 0),
            Size = UDim2.new(0, var1.Size.Size_400, 0, var1.Size.Size_400),
            BackgroundColor3 = var1.Color.Common.Shimmer.Color3,
            BackgroundTransparency = var1.Color.Common.Shimmer.Transparency,
            Image = image,
            useShimmerAnimationWhileLoading = true,
            cornerRadius = UDim.new(0.5, 0),
            shouldHandleReloads = true
        })
    })
end

return FlyoutAlternateEntryPoint
