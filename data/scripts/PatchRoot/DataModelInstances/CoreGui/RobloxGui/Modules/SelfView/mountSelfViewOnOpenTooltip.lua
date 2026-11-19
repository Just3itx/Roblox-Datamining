-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local CoreGui = game:GetService("CoreGui")
local UIBlox = require(CorePackages.Packages.UIBlox)
local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Dark = ColorMode.Dark

local Promise = require(CorePackages.Packages.Promise)

local SelfViewTooltipFTUX = require(script.Parent.SelfViewTooltipFTUX)

return function(arg1)
    local selfViewTooltipOnOpenGui = Instance.new("ScreenGui")
    selfViewTooltipOnOpenGui.Name = "SelfViewTooltipOnOpenGui"
    selfViewTooltipOnOpenGui.DisplayOrder = -1
    selfViewTooltipOnOpenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    selfViewTooltipOnOpenGui.Parent = CoreGui

    local element = Roact.createElement(AppStyleProvider, {
        style = { themeName = Dark }
    }, {
        frame = Roact.createElement("Frame", {
            Position = arg1.position,
            Size = arg1.size,
            BackgroundTransparency = 0,
            AnchorPoint = arg1.anchorPoint,
            Visible = false
        }, {
            aspectRatioConstraint = Roact.createElement(
                "UIAspectRatioConstraint",
                {
                    AspectRatio = arg1.aspectRatio,
                    AspectType = "ScaleWithParentSize",
                    DominantAxis = "Width"
                }
            ),
            sizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = arg1.maxSize, MinSize = arg1.minSize }),
            bottomButtonsMock = Roact.createElement("Frame", {
                Position = arg1.bottomButtonsFramePosition,
                Size = arg1.bottomButtonsFrameSize,
                Visible = false,
                BackgroundTransparency = 0
            }, {
                tooltip = Roact.createElement(
                    SelfViewTooltipFTUX,
                    {
                        fallbackText = arg1.fallbackText,
                        translationKey = arg1.translationKey,
                        tooltipLifetime = arg1.tooltipLifetime
                    }
                )
            })
        })
    })
    local instance = Roact.mount(element, selfViewTooltipOnOpenGui, "SelfViewTooltipOnOpenGui")

    local function unmount() -- Luacid: Inlined by compiler; 1 call site recovered
        pcall(function()
            Roact.unmount(instance)
        end)
    end
    Promise.delay(arg1.tooltipLifetime + 5):andThen(function()
        unmount()
    end)

    return { instance = instance, unmount = unmount }
end
