-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)
local useAboutSectionHeight = require(ProfilePlatform.Hooks.useAboutSectionHeight)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)

local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local Foundation = require(ProfilePlatformParent.Foundation)
local GetTextSize = require(ProfilePlatformParent.Style).GetTextSize
local Localization = require(ProfilePlatformParent.Localization)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local Responsive = require(ProfilePlatformParent.Responsive)

local useScreenSize = RobloxAppHooks.useScreenSize
local useIsSpatial = Responsive.useIsSpatial
local usePreferredInput = Responsive.usePreferredInput
local useLocalization = Localization.Hooks.useLocalization
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local ExpandableTextArea = UIBlox.App.Text.ExpandableTextArea
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View

local function Description(tbl1)
    local var1 = useTokens()
    local var2 = useScreenSize()
    local offset, var3 = useDynamicSizeMargin()
    local var4 = useProfileWrapperContext()
    local bodyMedium = var1.Typography.BodyMedium
    local var5, var6 = React.useState(var2.X)
    local profileType = var4.profileType

    local var7 = useLocalization({ moreText = TextKeys.More, noBioYet = TextKeys.NoBioYet })
    local description = tbl1.description

    local var8 = useIsSpatial()
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var9 = var8 or bool1

    local var10, var11 = useAboutSectionHeight(description, var5, offset)

    local y = if FFlagProfilePlatformNewProfileHeader then var11 else React.useMemo(function()
        local var12 = string.gsub(description or "", "[\r\n]+", " ")
        return GetTextSize(
            var12,
            bodyMedium.FontSize,
            bodyMedium.Font,
            Vector2.new(math.huge, math.huge),
            { addTemporaryPadding = false }
        ).Y * (if var9 then 2.6 else 2)
    end, {
        description,
        bodyMedium.FontSize,
        bodyMedium.Font,
        var9
    })

    local bool2 = if FFlagProfilePlatformNewProfileHeader then var11 < var10 else nil

    local uiSizeConstraint = React.useMemo(function()
        local x = var5 - offset * 2
        return (React.createElement("UISizeConstraint", { MaxSize = Vector2.new(x, y) }))
    end, { y, var5, offset })

    if description == nil or description == "" then
        if FFlagProfilePlatformNewProfileHeader then
            return nil
        end
        description = var7.noBioYet
    end

    if profileType ~= Enums.ProfileTypes.User and profileType ~= Enums.ProfileTypes.Contact then
        return React.createElement(
            HorizontalPageMargin,
            {
                layoutOrder = tbl1.layoutOrder,
                backgroundTransparency = 1,
                size = UDim2.new(1, 0, 0, 0),
                useAutomaticSizing = true
            },
            {
                Description = React.createElement(
                    ExpandableTextArea,
                    {
                        Text = tbl1.description,
                        compactNumberOfLines = 3,
                        padding = Vector2.new(0, 0)
                    }
                )
            }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }

    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var3(arg1)
        var6(arg1.AbsoluteSize.X)
    end
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset), PaddingRight = UDim.new(0, offset) }),
        DescriptionContainer = 0
    }
    local createElement2 = React.createElement
    local var13 = View
    local tbl4 = { tag = "size-full col gap-xsmall" }

    local tbl5 = {
        Description = React.createElement(FoundationText, {
            Text = description,
            LayoutOrder = 1,
            fontStyle = bodyMedium,
            tag = "auto-xy text-wrap text-align-x-left text-align-y-top text-truncate-split"
        }, { UISizeConstraint = uiSizeConstraint }),
        MoreButton = 0
    }
    local element

    if not FFlagProfilePlatformNewProfileHeader or bool2 then
        element = React.createElement(FoundationText, {
            Text = `<u>{var7.moreText}</u>`,
            LayoutOrder = 2,
            fontStyle = var1.Typography.TitleMedium,
            RichText = true,
            tag = "auto-xy text-wrap text-align-x-left text-align-y-top text-truncate-split",
            onActivated = tbl1.onActivateMoreButton
        })
    else
        element = nil
    end

    tbl5.MoreButton = element
    tbl3.DescriptionContainer = createElement2(var13, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return Description
