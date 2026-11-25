-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle
local useLastInputMode = FocusNavigationUtils.useLastInputMode
local Constants = require(ProfilePlatform.Common.Constants)
local useProfileScrollContext = require(ProfilePlatform.Contexts.ProfileScrollContext.useProfileScrollContext)
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local Divider = Foundation.Divider

local iconsNavigationClose = Images["icons/navigation/close"]

local var1 = Constants.USER_PROFILE_HEADER_HEIGHT + Constants.CTA_BUTTON_HEIGHT + Constants.PAGE_PADDING

return function(tbl1)
    local bool1 = useLastInputMode() == "Focus"
    local var2 = useStyle()

    local var3 = useProfileScrollContext()
    local var4 = if var3 then var3.scrollY else 0

    local onActivated = React.useCallback(function()
        tbl1.navigateBack()
    end, { tbl1.navigateBack })

    local var6 = if FFlagProfilePlatformNewProfileHeader then nil else 10

    local var7 = React.useMemo(function()
        if tbl1.backgroundTransparency ~= nil then
            return tbl1.backgroundTransparency
        end

        local var7 = var1 - 50

        if var4 < var7 then
            return 1
        end

        if var1 <= var4 then
            return 0
        end

        return 1 - (var4 - var7) / 50
    end, { tbl1.backgroundTransparency, var4 })
    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        tag = "bg-surface-0 position-top-left size-full-full",
        backgroundStyle = { Transparency = var7 },
        ZIndex = 100
    }

    local tbl3 = { LeftNavigationButton = 0, BottomDivider = 0 }
    local var9

    if bool1 or tbl1.hideNavigationButton then
        var9 = nil
    else
        local createElement2 = React.createElement
        local var10 = View
        local tbl4 = {
            tag = "bg-over-media-0 radius-circle",
            AnchorPoint = if FFlagProfilePlatformNewProfileHeader then Vector2.new(0, 0.5) else nil,
            Position = if FFlagProfilePlatformNewProfileHeader then UDim2.new(0, 10, 0.5, 0) else UDim2.new(0, 10, 0, var6),
            Size = UDim2.new(0, 36, 0, 36),
            onActivated = onActivated,
            backgroundStyle = {
                Transparency = 1 - var7
            }
        }
        local tbl5 = {
            InnerButton = React.createElement(
                "ImageButton",
                {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    [React.Event.Activated] = onActivated
                },
                {
                    CloseButtonImage = React.createElement(ImageSetLabel, {
                        Size = UDim2.new(0, 24, 0, 24),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = iconsNavigationClose,
                        ImageColor3 = var2.Theme.IconEmphasis.Color,
                        ImageTransparency = var2.Theme.IconEmphasis.Transparency,
                        BackgroundTransparency = 1
                    })
                }
            )
        }
        var9 = createElement2(var10, tbl4, tbl5)
    end

    tbl3.LeftNavigationButton = var9

    tbl3.BottomDivider = React.createElement(Divider, { Position = UDim2.new(0, 0, 1, -1), Size = UDim2.new(1, 0, 0, 1), Visible = var7 < 1 })
    return (createElement(var8, tbl2, tbl3))
end
