-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local Service = require(Chrome.Service)
local ViewportUtil = require(Chrome.ChromeShared.Service.ViewportUtil)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local FFlagCenterInExperienceShopWindow = require(CorePackages.Workspace.Packages.InExperienceShop.FFlagCenterInExperienceShopWindow)

local bool1 = false

local function getCenteredShopWindowPosition(): UDim2
    local var1 = ViewportUtil.screenSize:get()
    local maxY = GuiService.TopbarInset.Max.Y
    local var2 = var1.Y - maxY
    local bool2 = var1.X < 844 or var2 < 754
    local x = if bool2 then var1.X else math.min(844, var1.X)
    local var3 = if bool2 then var2 else math.min(754, var2)
    local xOffset = (var1.X - x) / 2
    local yOffset = maxY + (var2 - var3) / 2
    return UDim2.fromOffset(xOffset, yOffset)
end

local function applyInitialWindowPositionIfNeeded() -- Luacid: Inlined by compiler; 2 call sites recovered
    if not FFlagCenterInExperienceShopWindow or bool1 then
        return
    end
    Service:updateWindowPosition(Constants.IN_EXPERIENCE_SHOP_ID, getCenteredShopWindowPosition())
    bool1 = true
end

local function toggleInExperienceShopWindow() -- Luacid: Inlined by compiler; 1 call site recovered
    if not Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID) then
        applyInitialWindowPositionIfNeeded()
    end

    Service:toggleWindow(Constants.IN_EXPERIENCE_SHOP_ID)
end

return {
    MAX_WINDOW_WIDTH = 844,
    MAX_WINDOW_HEIGHT = 754,
    getCenteredShopWindowPosition = getCenteredShopWindowPosition,
    getStartingWindowPosition = function()
        if FFlagCenterInExperienceShopWindow then
            return getCenteredShopWindowPosition()
        end
        return nil
    end,
    toggleInExperienceShopWindow = toggleInExperienceShopWindow,
    openInExperienceShopWindow = function()
        local inExperienceShopId = Constants.IN_EXPERIENCE_SHOP_ID
        if Service:isWindowOpen(inExperienceShopId) then
            return
        end

        if Service:isIntegrationValid(inExperienceShopId) then
            Service:activate(inExperienceShopId)
        else
            toggleInExperienceShopWindow()
        end
    end
}
