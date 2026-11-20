-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local FreeTrialTopBarSlot = if InExperienceShop.FFlagEnableFreeTrialTopBarChip then InExperienceShop.FreeTrialTopBarSlot else nil
local Chrome = script.Parent.Parent.Parent.Parent.Chrome
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local _FreeTrialChipHostView = require(script.Parent.FreeTrialChipHostView)

local function openInExperienceShop()
    if not ChromeEnabled() then
        return
    end

    if InExperienceShop.FFlagCenterInExperienceShopWindow then
        require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).toggleInExperienceShopWindow()
    else
        local constants = require(Chrome.ChromeShared.Unibar.Constants)
        require(Chrome.Service):toggleWindow(constants.IN_EXPERIENCE_SHOP_ID)
    end
end

local function useFreeTrialChipHostViewModel(tbl1)
    local maxWidth, var2 = React.useState(nil)
    local slot = FreeTrialTopBarSlot

    if slot == nil then
        return nil
    end

    return {
        position = tbl1.position,
        size = tbl1.size,
        zIndex = if tbl1.zIndex == nil then 100 else tbl1.zIndex,
        visible = tbl1.visible,
        maxWidth = maxWidth,
        onAbsoluteSizeChanged = function(arg1)
            local absoluteSizeX = arg1.AbsoluteSize.X
            if absoluteSizeX > 0 and absoluteSizeX ~= maxWidth then
                var2(absoluteSizeX)
            end
        end,
        onActivated = openInExperienceShop,
        slot = slot
    }
end

return useFreeTrialChipHostViewModel
