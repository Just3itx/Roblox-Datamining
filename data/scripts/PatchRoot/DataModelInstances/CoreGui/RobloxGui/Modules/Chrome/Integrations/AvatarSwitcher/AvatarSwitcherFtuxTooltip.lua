-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal
local CommonFtuxTooltip = require(Chrome.Integrations.CommonFtuxTooltip)
local priority = game:DefineFastInt("AvatarSwitcherTooltipPriority", 3000)

local localStorageKey = game:DefineFastString("AvatarSwitcherTooltipStorageKey", "AvatarSwitcherTooltipStorageKey")
local showDelay = game:DefineFastInt("AvatarSwitcherTooltipShowDelay", 1000)
local dismissDelay = game:DefineFastInt("AvatarSwitcherTooltipDismissDelay", 8500)

local function AvatarSwitcherFtuxTooltip(tbl1)
    local var1 = Service:integrations()[Constants.AVATAR_SWITCHER_ID]
    local availability = if var1 then var1.availability else nil
    return useMappedSignal(availability) == Service.AvailabilitySignal.Available
        and CommonFtuxTooltip({
            id = "AVATAR_SWITCHER_TOOLTIP",
            priority = priority,
            isIconVisible = tbl1.visible,
            headerKey = "CoreScripts.FTUX.Heading.NewAvatarSwitcher",
            bodyKey = "CoreScripts.FTUX.Label.AvatarSwitcherDescription",
            localStorageKey = localStorageKey,
            showDelay = showDelay,
            dismissDelay = dismissDelay
        })
end

return AvatarSwitcherFtuxTooltip
