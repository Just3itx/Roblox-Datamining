-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)

local GlobalConfig = require(scriptParentParent.GlobalConfig)
local CloseMenu = require(scriptParentParent.Thunks.CloseMenu)

local vector2 = Vector2.new(0, 0)

local var1 = t.strictInterface(
    {
        currentPage = t.string,
        open = t.boolean,
        onActivated = t.callback,
        occupiedWidth = t.number,
        screenSize = t.Vector2
    }
)
return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        currentPage = arg1.menuPage,
        open = arg1.isMenuOpen,
        occupiedWidth = 464,
        screenSize = arg1.screenSize
    }
end, function(callback)
    return {
        onActivated = function()
            callback(CloseMenu)
        end
    }
end)(function(arg1) -- name: ViewportOverlay
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    if arg1.screenSize == vector2 then
        return nil
    end

    local bool1 = arg1.currentPage == Constants.InitalPageKey

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                Overlay = {
                    Color = arg2.Color.Common.Scrim.Color3,
                    Transparency = arg2.Color.Common.Scrim.Transparency
                }
            }
        }
    end, function(arg2)
        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundColor3 = arg2.Theme.Overlay.Color,
            BackgroundTransparency = arg2.Theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = not bool1 and arg1.open,
            ZIndex = 0
        }
        local tbl2 = {
            InputCapturer = Roact.createElement("TextButton", {
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(1, -arg1.occupiedWidth, 1, 0),
                Text = "",
                [Roact.Event.Activated] = arg1.onActivated
            })
        }
        return createElement("Frame", tbl1, tbl2)
    end)
end)
