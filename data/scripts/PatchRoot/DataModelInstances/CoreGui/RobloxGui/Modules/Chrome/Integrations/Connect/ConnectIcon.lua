-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal

local MappedSignal = ChromeUtils.MappedSignal
local useTokens = Foundation.Hooks.useTokens
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local SubMenuContext = require(Chrome.ChromeShared.Unibar.SubMenuContext)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)

local getAppChatNavbarItemConfig = require(CorePackages.Workspace.Packages.AppChat.getAppChatNavbarItemConfig)

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local FFlagEnableChatIconUnibarDropdownFixEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableChatIconUnibarDropdownFixEnabled

local appChatNavbarItemConfig = getAppChatNavbarItemConfig()

local tbl1 = { integrationId = "", shouldShowCustomBadge = true, isSquadIndicatorEnabled = false }

local function ConnectIcon(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useTokens()
    local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants.ICON_SIZE
    local var3, var4 = React.useState(InExperienceAppChatModal.default.unreadCount)

    if var1.shouldShowCustomBadge then
        React.useEffect(function()
            local connection = InExperienceAppChatModal.default.unreadCountSignal.Event:Connect(function(arg1)
                var4(arg1)
            end)
            return function()
                connection:Disconnect()
            end
        end, { var4 })
    else
        var3 = 0
    end

    local var5 = nil
    local var6 = nil
    local var7 = nil
    if var1.isSquadIndicatorEnabled then
        local var8
        var5, var8 = React.useState(InExperienceAppChatModal.default.currentSquadId)
        var6 = var8
    end

    React.useEffect(function()
        if not var1.isSquadIndicatorEnabled then
            return function() end
        end

        local connection = InExperienceAppChatModal.default.currentSquadIdSignal.Event:Connect(function(arg1)
            var6(arg1)
        end)

        return function()
            connection:Disconnect()
        end
    end, { var1.isSquadIndicatorEnabled, var6 })

    if var1.isSquadIndicatorEnabled then
        if var5 ~= "" then
            var7 = var2.Color.System.Success
        elseif var3 > 0 then
            var7 = var2.Color.System.Contrast
        end
    end

    local bool1 = if var1.isSquadIndicatorEnabled then var7 else var3 > 0

    local mappedSignal = MappedSignal.new(InExperienceAppChatModal.default.visibilitySignal.Event, function(_)
        return InExperienceAppChatModal:getVisible()
    end)

    local var8 = useMappedSignal(mappedSignal)

    local var9 = React.useContext(SubMenuContext)
    local function getTransparency(transparency: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        if var9 then
            return (var9:map(function(arg1): number
                return transparency + (1 - transparency) * (1 - arg1)
            end))
        end

        return transparency
    end

    local default

    if FFlagEnableChatIconUnibarDropdownFixEnabled then
        local defaultTransparency = var2.Color.Content.Default.Transparency
        if var9 then
            default = var9:map(function(arg1)
                return {
                    Color3 = var2.Color.Content.Default.Color3,
                    Transparency = defaultTransparency + (1 - defaultTransparency) * (1 - arg1)
                }
            end)
        else
            default = var2.Color.Content.Default
        end
    else
        default = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        Size = UDim2.new(0, iconSize, 0, iconSize)
    }
    local tbl4 = { Icon = 0, Badge = 0 }
    local createElement2 = React.createElement
    local icon = Foundation.Icon
    local tbl5 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        name = appChatNavbarItemConfig.icon,
        variant = if var8 then Foundation.Enums.IconVariant.Filled else Foundation.Enums.IconVariant.Regular,
        style = 0
    }

    if not FFlagEnableChatIconUnibarDropdownFixEnabled then
        default = nil
    end

    tbl5.style = default
    tbl4.Icon = createElement2(icon, tbl5)
    local element

    if bool1 then
        element = React.createElement(Foundation.View, {
            Position = UDim2.new(1, -var2.Stroke.Thicker, 0, var2.Stroke.Thicker),
            backgroundStyle = var1.isSquadIndicatorEnabled and {
                Color3 = var7.Color3,
                Transparency = getTransparency(var7.Transparency)
            }
                or {
                    Color3 = var2.Color.System.Contrast.Color3,
                    Transparency = getTransparency(var2.Color.System.Contrast.Transparency)
                },
            stroke = {
                Color = var2.Color.Surface.Surface_0.Color3,
                Transparency = getTransparency(var2.Color.Surface.Surface_0.Transparency),
                Thickness = var2.Stroke.Thicker
            },
            tag = {
                ["anchor-top-right radius-circle size-200"] = true,
                ["stroke-thicker"] = not FFlagEnableChatIconUnibarDropdownFixEnabled
            },
            ZIndex = 2
        })
    else
        element = nil
    end

    tbl4.Badge = element
    return createElement(view, tbl3, tbl4)
end

return ConnectIcon
