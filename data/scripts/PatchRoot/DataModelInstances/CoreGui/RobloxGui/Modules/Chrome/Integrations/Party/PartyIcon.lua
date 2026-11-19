-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local Flags = require(Chrome.ChromeShared.Flags)
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal
local usePartyIcon = require(Chrome.Integrations.Party.usePartyIcon)

local MappedSignal = ChromeUtils.MappedSignal
local useTokens = Foundation.Hooks.useTokens
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local SubMenuContext = require(Chrome.ChromeShared.Unibar.SubMenuContext)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)

local FFlagTokenizeUnibarConstantsWithStyleProvider = Flags.FFlagTokenizeUnibarConstantsWithStyleProvider

local function PartyIcon()
    local var1 = useTokens()
    local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants.ICON_SIZE

    local mappedSignal = MappedSignal.new(InExperienceAppChatModal.default.visibilitySignal.Event, function(_)
        return InExperienceAppChatModal:getVisible()
    end)

    local var2 = useMappedSignal(mappedSignal)
    local var3 = usePartyIcon(iconSize, 24, if var2 then "icons/menu/2-person-with-bubble-on" else "icons/menu/2-person-with-bubble")

    local var4 = React.useContext(SubMenuContext)
    local function getTransparency(num1: number) -- Luacid: Inlined by compiler; 4 call sites recovered
        if var4 then
            return (var4:map(function(arg1): number
                return num1 + (1 - num1) * (1 - arg1)
            end))
        end

        return num1
    end

    return React.createElement(Foundation.View, {
        Size = UDim2.new(0, iconSize, 0, iconSize)
    }, {
        Icon = React.createElement(Foundation.Image, {
            Size = var3.size:map(function(num1: number): UDim2
                return UDim2.fromOffset(num1, num1)
            end),
            backgroundStyle = var3.image.backgroundColor and {
                Color3 = var3.image.backgroundColor,
                Transparency = getTransparency(0)
            }
                or var1.Color.None,
            Image = var3.image.thumbnail,
            imageStyle = {
                Color3 = var1.Color.Content.Emphasis.Color3,
                Transparency = getTransparency(var1.Color.Content.Emphasis.Transparency)
            },
            tag = "anchor-center-center position-center-center radius-circle"
        }),
        Badge = React.createElement(Foundation.View, {
            Position = UDim2.new(1, -var1.Stroke.Thicker, 0, var1.Stroke.Thicker),
            backgroundStyle = {
                Color3 = var1.Color.System.Success.Color3,
                Transparency = getTransparency(var1.Color.System.Success.Transparency)
            },
            stroke = {
                Color = var1.Color.Surface.Surface_0.Color3,
                Transparency = getTransparency(var1.Color.Surface.Surface_0.Transparency),
                Thickness = var1.Stroke.Thicker
            },
            tag = "anchor-top-right radius-circle size-200 stroke-thicker",
            ZIndex = 2
        })
    })
end

return PartyIcon
