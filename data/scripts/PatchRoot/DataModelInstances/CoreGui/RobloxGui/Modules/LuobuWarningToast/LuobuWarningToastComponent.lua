-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local Toast = UIBlox.App.Dialog.Toast
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local ContentProvider = game:GetService("ContentProvider")
local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local var1 = Roact.PureComponent:extend("LuobuWarningToastComponent")
local toastTitle = RobloxTranslator:FormatByKey("InGame.CommonUI.Message.LuobuGameJoinWarning")

function var1.init(arg1)
    arg1.state = { isLoaded = false }

    task.spawn(function()
        local image = Images["icons/status/alert"].Image
        pcall(function()
            ContentProvider:PreloadAsync({ image })
        end)
        arg1:setState({ isLoaded = true })
    end)

    function arg1.getToastContent()
        return {
            iconImage = Images["icons/status/alert"],
            iconColorStyle = {
                Color = Color3.new(1, 1, 1),
                Transparency = 0
            },
            toastTitle = toastTitle
        }
    end
end

function var1.render(arg1)
    if not arg1.state.isLoaded then
        return nil
    end
    local robloxCaptureNotificationGui = Roact.createElement("ScreenGui", {
        AutoLocalize = false,
        DisplayOrder = 9,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        Content = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0)
            },
            {
                WarningToast = Roact.createElement(Toast, { duration = 5, show = true, toastContent = arg1.getToastContent() })
            }
        )
    })

    return renderWithCoreScriptsStyleProvider({ RobloxCaptureNotificationGui = robloxCaptureNotificationGui })
end

return var1
