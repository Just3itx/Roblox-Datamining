-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local React = require(CorePackages.Packages.React)
local useEventConnection = require(CorePackages.Packages.ReactUtils).useEventConnection
local Service = require(Chrome.Service)
local ViewportUtil = require(Chrome.ChromeShared.Service.ViewportUtil)
local _WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local ShopContainer = require(CorePackages.Workspace.Packages.InExperienceShop).ShopContainer

local function ShopChromeWrapper(tbl1)
    local windowSize = tbl1.windowSize
    local fullScreen, var2 = React.useState(false)

    local var3 = React.useCallback(function(vector2: Vector2)
        local maxY = GuiService.TopbarInset.Max.Y
        local bool1 = vector2.X < tbl1.maxWindowWidth or vector2.Y - maxY < tbl1.maxWindowHeight
        if bool1 then
            windowSize:requestSize(vector2.X, vector2.Y - maxY)
        else
            local var3 = windowSize
            local num1 = math.min(tbl1.maxWindowWidth, vector2.X)
            local maxWindowHeight = tbl1.maxWindowHeight
            local var4 = vector2.Y - maxY
            var3:requestSize(num1, math.min(maxWindowHeight, var4))
        end

        var2(bool1)
    end, { windowSize, tbl1.maxWindowWidth, tbl1.maxWindowHeight })

    useEventConnection(GuiService:GetPropertyChangedSignal("TopbarInset"), function()
        var3(ViewportUtil.screenSize:get())
    end)

    React.useEffect(function()
        local connection = ViewportUtil.screenSize:connect(var3)
        var3(ViewportUtil.screenSize:get())
        return function()
            connection:disconnect()
        end
    end, { var3 })

    local toggleWindow = React.useCallback(function()
        Service:toggleWindow(Constants.IN_EXPERIENCE_SHOP_ID)
    end, {})

    return React.createElement(ShopContainer, { fullScreen = fullScreen, toggleWindow = toggleWindow })
end

return ShopChromeWrapper
