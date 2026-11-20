-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Modules = game:GetService("CoreGui").RobloxGui.Modules

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local bool1 = game:DefineFastFlag("FontFaceConsoleOverscan", false)

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useDesignTokens = require(CorePackages.Workspace.Packages.Style).useDesignTokens
local useStyle = UIBlox.Core.Style.useStyle

local GlobalSettings = require(Modules.Shell.GlobalSettings)
local LocalizedStrings = require(Modules.Shell.LocalizedStrings)
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local useNavigation = require(CorePackages.Workspace.Packages.Navigation).useNavigation

local ControllerHint = require(Modules.Shell.Components.Overscan.ControllerHint)
local Edges = require(script.Parent.Edges)

local function Overscan(tbl1)
    local var1 = useNavigation()

    local var2 = tbl1.onUnmount or var1.goBack

    local var3 = useLocalization({ accept = "CommonUI.Controls.Action.Accept", cancel = "CommonUI.Controls.Action.Cancel" })

    local var4 = useDesignTokens(function(arg1)
        return {
            buttonHeight = arg1.Size.Size_1200,
            marginBetween = arg1.Size.Size_300
        }
    end)

    local var5 = useStyle()

    local ref = React.useRef(nil)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 1,
        BackgroundTransparency = tbl1.BackgroundTransparency,
        BackgroundColor3 = Color3.new(1 / 85, 1 / 85, 1 / 85)
    }

    local tbl3 = {
        React.createElement("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.new(1 / 85, 1 / 85, 1 / 85),
            BorderSizePixel = 1,
            Visible = tbl1.ImageVisible,
            Image = "rbxasset://textures/ui/Shell/ScreenAdjustment/Background.png"
        }),
        Title = React.createElement("TextLabel", {
            Position = UDim2.new(0, 230, 0, 205),
            BackgroundTransparency = 1,
            Font = if bool1 then nil else GlobalSettings.LightFont,
            FontFace = if bool1 then normalizeFontFace(GlobalSettings.LightFont) else nil,
            FontSize = GlobalSettings.HeaderSize,
            TextColor3 = GlobalSettings.WhiteTextColor,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = LocalizedStrings:LocStringUA("Xbox.Old.ScreenSizeWord")
        }),
        Prompt = React.createElement("TextLabel", {
            Position = UDim2.new(0, 230, 0, 243),
            BackgroundTransparency = 1,
            Font = if bool1 then nil else GlobalSettings.RegularFont,
            FontFace = if bool1 then normalizeFontFace(GlobalSettings.RegularFont) else nil,
            FontSize = GlobalSettings.ButtonSize,
            TextColor3 = GlobalSettings.WhiteTextColor,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = LocalizedStrings:LocStringUA("Xbox.Old.ResizeScreenPrompt")
        }),
        Controller = React.createElement(ControllerHint),
        Actions = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(0.4, 0),
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, -201)
            },
            {
                React.createElement(ButtonStack, {
                    buttonHeight = var4.buttonHeight,
                    marginBetween = var4.marginBetween,
                    forcedFillDirection = Enum.FillDirection.Horizontal,
                    buttons = {
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                text = var3.cancel,
                                fontStyle = var5.Font.Header1,
                                onActivated = var2
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                text = var3.accept,
                                fontStyle = var5.Font.Header1,
                                onActivated = function()
                                    if ref.current then
                                        ref.current.onAccept()
                                    end
                                end
                            }
                        }
                    }
                })
            }
        ),
        EdgeSelector = React.createElement(Edges, { onSetEdges = var2, ref = ref })
    }

    return createElement(str1, tbl2, tbl3)
end

return Overscan
