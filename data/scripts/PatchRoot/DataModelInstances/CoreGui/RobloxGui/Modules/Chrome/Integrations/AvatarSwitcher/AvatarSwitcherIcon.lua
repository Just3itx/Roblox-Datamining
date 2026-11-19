-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local _ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal
local SubMenuContext = require(Chrome.ChromeShared.Unibar.SubMenuContext)

local function AvatarSwitcherIcon(tbl1)
    local var1 = useMappedSignal(tbl1.isActive)
    local var2 = React.useContext(SubMenuContext)
    local var3 = useTokens()

    local style = if var2 then var2:map(function(num1: number)
        return {
            Color3 = var3.Color.Content.Default.Color3,
            Transparency = math.lerp(1, var3.Color.Content.Default.Transparency, num1)
        }
    end) else var3.Color.Content.Default

    return React.createElement(Foundation.Icon, {
        name = IconName.CirclePerson,
        size = IconSize.Large,
        variant = if var1 then IconVariant.Filled else IconVariant.Regular,
        style = style
    })
end

return AvatarSwitcherIcon
