-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local useEventConnection = require(CorePackages.Packages.ReactUtils).useEventConnection
local Foundation = require(CorePackages.Packages.Foundation)
local Service = require(Chrome.Service)
local ViewportUtil = require(Chrome.ChromeShared.Service.ViewportUtil)
local _WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local AvatarSwitcherContainer = require(CorePackages.Workspace.Packages.AvatarSwitcher).Components.AvatarSwitcherContainer

local FFlagAvatarWorkshopReplacesAvatarSwitcher = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAvatarWorkshopReplacesAvatarSwitcher
local AvatarWorkshopWindow = if FFlagAvatarWorkshopReplacesAvatarSwitcher then require(CorePackages.Workspace.Packages.AvatarWorkshop).Components.AvatarWorkshopWindow else nil

local function shouldUseVerticalLayout(uDim2: UDim2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return uDim2.X.Offset / uDim2.Y.Offset < 1.2
end

local function AvatarSwitcherChromeWrapper(tbl1)
    local windowSize = tbl1.windowSize
    local verticalLayout, var2 = React.useState(not not shouldUseVerticalLayout((windowSize:get())))
    local var3, var4 = React.useState(false)

    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)

    local var5 = React.useCallback(function(vector2: Vector2)
        local maxY = GuiService.TopbarInset.Max.Y
        local bool1 = vector2.X < tbl1.maxWindowWidth or vector2.Y - maxY < tbl1.maxWindowHeight
        if bool1 then
            windowSize:requestSize(vector2.X, vector2.Y - maxY)
        else
            local var5 = windowSize
            local num1 = math.min(tbl1.maxWindowWidth, vector2.X)
            local maxWindowHeight = tbl1.maxWindowHeight
            local var6 = vector2.Y - maxY
            var5:requestSize(num1, math.min(maxWindowHeight, var6))
        end

        var4(bool1)
    end, {
        windowSize,
        tbl1.maxWindowWidth,
        tbl1.maxWindowHeight,
        var3
    })
    useEventConnection(GuiService:GetPropertyChangedSignal("TopbarInset"), function()
        var5(ViewportUtil.screenSize:get())
    end)

    React.useEffect(function()
        local connection = ViewportUtil.screenSize:connect(var5)
        local connection2 = windowSize:connect(function(uDim2)
            var2(not not shouldUseVerticalLayout(uDim2))
        end)
        var5(ViewportUtil.screenSize:get())
        return function()
            connection:disconnect()
            connection2:disconnect()
        end
    end, { var5 })

    if FFlagAvatarWorkshopReplacesAvatarSwitcher and AvatarWorkshopWindow then
        return React.createElement(
            Foundation.View,
            {
                tag = {
                    ["size-full"] = true,
                    ["padding-x-large padding-bottom-xlarge padding-top-medium"] = var3
                }
            },
            {
                AvatarWorkshopWindow = React.createElement(AvatarWorkshopWindow, {
                    verticalLayout = verticalLayout,
                    onClose = function()
                        Service:toggleWindow(Constants.AVATAR_SWITCHER_ID)
                    end
                })
            }
        )
    end
    return React.createElement(
        Foundation.View,
        {
            tag = `size-full {if var3 then "padding-x-large padding-top-medium padding-bottom-xlarge" else ""}`
        },
        {
            AvatarSwitcherContainer = React.createElement(AvatarSwitcherContainer, {
                getRespawnBehaviour = settingsHub.GetRespawnBehaviour,
                respawnBehaviorChangedEvent = settingsHub.RespawnBehaviourChangedEvent,
                toggleWindow = function()
                    Service:toggleWindow(Constants.AVATAR_SWITCHER_ID)
                end,
                verticalLayout = verticalLayout
            })
        }
    )
end
return AvatarSwitcherChromeWrapper
