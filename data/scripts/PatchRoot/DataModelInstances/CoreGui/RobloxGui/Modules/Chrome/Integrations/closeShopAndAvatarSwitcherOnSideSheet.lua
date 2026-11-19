-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local Signals = require(CorePackages.Packages.Signals)
local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local getSideSheetVisibility = InExperienceSideSheet.getSideSheetVisibility

local tbl1 = { Constants.IN_EXPERIENCE_SHOP_ID, Constants.AVATAR_SWITCHER_ID }

local var1 = nil

local function bindCloseShopAndAvatarSwitcherOnSideSheet()
    local function canToggleWindow(str1: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        local var2 = Service:integrations()[str1]
        local components = if var2 then var2.components else nil
        return not (components == nil) and components.Window ~= nil
    end

    local function closeIfOpen(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        if not (canToggleWindow(str1) and Service:isWindowOpen(str1)) then
            return
        end

        Service:toggleWindow(str1)
    end

    local effect = Signals.createEffect(function(arg1)
        if not getSideSheetVisibility(arg1) then
            return
        end

        for _, value in tbl1 do
            closeIfOpen(value)
        end
    end)

    local function func1()
        if var1 == func1 then
            var1 = nil
        end
        effect()
    end
    var1 = func1

    return func1
end

return bindCloseShopAndAvatarSwitcherOnSideSheet
