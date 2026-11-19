-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local UIBlox = require(CorePackages.Packages.UIBlox)

local React = require(CorePackages.Packages.React)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle

local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useDispatch
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local useScreenSize = require(CoreGui.RobloxGui.Modules.Common.Hooks.useScreenSize)
local ExperienceService = require(CorePackages.Workspace.Packages.ExperienceService).ExperienceService

local scriptParentParent = script.Parent.Parent
local CloseOverlay = require(scriptParentParent.Actions.CloseOverlay)

local function AttributionTraversal(arg1)
    local var1 = useDispatch()
    local screenSize = useScreenSize()
    local var3 = useStyle()

    local onActivated = React.useCallback(function()
        var1(CloseOverlay())
    end, { var1 })

    local var2 = React.useCallback(function()
        local tbl1 = {
            placeId = arg1.rootPlaceId
        }

        ExperienceService:LaunchExperience(tbl1)
        var1(CloseOverlay())
    end, { var1, arg1.rootPlaceId })

    local var6 = useSelector(function(arg2)
        return arg2.locale
    end)

    local theme = var3.Theme
    local font = var3.Font
    local name = arg1.name or ""

    return React.createElement(InteractiveAlert, {
        title = RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Attribution.GoToExperience", var6),
        middleContent = function()
            local createElement = React.createElement
            local tbl1 = {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            }
            local tbl2 = {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, var3.Tokens.Size.Size_300)
                }),
                ExperienceThumbnailFrame = 0,
                BodyText = 0
            }
            local createElement2 = React.createElement
            local tbl3 = {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(150, 150),
                BackgroundColor3 = theme.BackgroundContrast.Color,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                ClipsDescendants = true
            }

            local tbl4 = {
                ExperienceThumbnail = React.createElement(
                    ImageSetLabel,
                    {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Image = string.format("rbxthumb://type=GameIcon&id=%s&w=%d&h=%d", tostring(arg1.universeId), 150, 150),
                        Size = UDim2.fromScale(1, 1),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    },
                    {
                        RoundCorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var3.Tokens.Radius.Medium) })
                    }
                )
            }
            tbl2.ExperienceThumbnailFrame = createElement2("Frame", tbl3, tbl4)

            tbl2.BodyText = React.createElement(StyledTextLabel, {
                text = RobloxTranslator:FormatByKeyForLocale(
                    "InGame.InspectMenu.Attribution.GoToDescription",
                    var6,
                    { EXPERIENCE_NAME = name }
                ),
                fontStyle = font.Body,
                colorStyle = theme.TextDefault,
                layoutOrder = 2,
                automaticSize = Enum.AutomaticSize.Y,
                size = UDim2.fromScale(1, 0),
                textXAlignment = Enum.TextXAlignment.Center,
                lineHeight = 1
            })
            return createElement("Frame", tbl1, tbl2)
        end,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = onActivated,
                        text = RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Action.Cancel", var6),
                        layoutOrder = 0
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimaryContextual,
                    props = {
                        onActivated = var2,
                        text = RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Action.Go", var6),
                        layoutOrder = 2
                    },
                    isDefaultChild = false
                }
            }
        },
        isMiddleContentFocusable = false,
        screenSize = screenSize
    })
end

return AttributionTraversal
