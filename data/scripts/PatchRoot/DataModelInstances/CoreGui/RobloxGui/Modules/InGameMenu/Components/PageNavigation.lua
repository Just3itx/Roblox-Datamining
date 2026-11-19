-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Otter = InGameMenuDependencies.Otter
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Foundation = require(CorePackages.Packages.Foundation)
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent

local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

local Pages = require(script.Parent.Pages)
local ThemedTextLabel = require(script.Parent.ThemedTextLabel)
local Divider = require(script.Parent.Divider)

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local divideTransparency = require(scriptParentParent.Utility.divideTransparency)

local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)

local var3 = Roact.PureComponent:extend("NavigationButton")

function var3.init(arg1, arg2)
    local fillProgress = if arg2.selected then 1 else 0
    local var4, var5 = Roact.createBinding(fillProgress)

    arg1.fillSize = var4:map(function(xScale: number?): UDim2
        return UDim2.new(xScale, 0, 1, 0)
    end)

    local hoverTransparency, setHoverTransparency = Roact.createBinding(0)
    arg1.hoverTransparency = hoverTransparency
    arg1.setHoverTransparency = setHoverTransparency

    arg1.motor = Otter.createGroupMotor({ fillProgress = fillProgress, hoverTransparency = 0 })

    arg1.motor:onStep(function(arg3)
        var5(arg3.fillProgress)
        arg1.setHoverTransparency(arg3.hoverTransparency)
    end)

    arg1:setState({ hovering = false, pressing = false })
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local props = arg1.props

    return withLocalization({ text = props.text })(function(arg3)
        return withFoundationOrUIBloxStyle(function(arg4)
            return {
                Theme = {
                    BackgroundOnPress = {
                        Color = arg4.Color.State.Press.Color3,
                        Transparency = arg4.Color.State.Press.Transparency
                    },
                    BackgroundOnHover = {
                        Color = arg4.Color.State.Hover.Color3,
                        Transparency = arg4.Color.State.Hover.Transparency
                    },
                    IconEmphasis = {
                        Color = arg4.Color.Content.Emphasis.Color3,
                        Transparency = arg4.Color.Content.Emphasis.Transparency
                    },
                    TextEmphasis = {
                        Color = arg4.Color.Content.Emphasis.Color3,
                        Transparency = arg4.Color.Content.Emphasis.Transparency
                    },
                    BackgroundMuted = {
                        Color = arg4.Color.Surface.Surface_200.Color3,
                        Transparency = arg4.Color.Surface.Surface_200.Transparency
                    }
                }
            }
        end, function(arg4)
            local var4 = arg1.state.pressing and not props.selected
            local tbl1 = {
                Transparency = 1,
                Color = Color3.new(1, 1, 1)
            }

            if arg1.state.pressing then
                tbl1 = arg4.Theme.BackgroundOnPress
            elseif arg1.state.hovering then
                tbl1 = arg4.Theme.BackgroundOnHover
            end

            local createElement = Roact.createElement
            local str1 = "TextButton"
            local tbl2 = {
                AutoButtonColor = false,
                BackgroundTransparency = tbl1.Transparency,
                BackgroundColor3 = tbl1.Color,
                BorderSizePixel = 0,
                LayoutOrder = props.LayoutOrder,
                Size = UDim2.new(1, 0, 0, 70),
                Text = "",
                SelectionImageObject = arg2(var2.Square),
                [Roact.Event.Activated] = props.onActivated,
                [Roact.Ref] = if props.LayoutOrder == 1 then props.mainPageFirstButtonRef or nil else nil
            }

            tbl2[Roact.Event.MouseEnter] = function()
                arg1:setState({ hovering = true })
            end

            tbl2[Roact.Event.MouseLeave] = function()
                arg1:setState({ hovering = false, pressing = false })
            end

            tbl2[Roact.Event.InputBegan] = function(_, arg5)
                if arg5.UserInputType == Enum.UserInputType.MouseButton1 or arg5.UserInputType == Enum.UserInputType.Touch then
                    arg1:setState({ pressing = true })
                end
            end

            tbl2[Roact.Event.InputEnded] = function(_, arg5)
                if arg5.UserInputType == Enum.UserInputType.MouseButton1 or arg5.UserInputType == Enum.UserInputType.Touch then
                    arg1:setState({ pressing = false })
                end
            end

            local tbl3 = { ContentContainer = 0, SelectedFill = 0 }
            local createElement2 = Roact.createElement
            local str2 = "Frame"
            local tbl4 = {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ZIndex = 3,
                BackgroundTransparency = 1
            }

            local tbl5 = { Icon = 0, Text = 0 }
            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element = Roact.createElement(Icon, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    name = props.icon,
                    size = IconSize.Medium,
                    style = {
                        Color3 = arg4.Theme.IconEmphasis.Color,
                        Transparency = divideTransparency(arg4.Theme.IconEmphasis.Transparency, if var4 then 2 else 1)
                    },
                    Position = UDim2.new(0, 28, 0.5, 0),
                    ZIndex = 3
                })
            else
                element = Roact.createElement(ImageSetLabel, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = props.icon,
                    ImageColor3 = arg4.Theme.IconEmphasis.Color,
                    ImageTransparency = divideTransparency(arg4.Theme.IconEmphasis.Transparency, if var4 then 2 else 1),
                    Position = UDim2.new(0, 28, 0.5, 0),
                    Size = UDim2.new(0, 36, 0, 36),
                    ZIndex = 3
                })
            end

            tbl5.Icon = element

            tbl5.Text = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 80, 0.5, 0),
                Size = UDim2.new(1, -104, 1, 0),
                Text = arg3.text,
                TextTransparency = divideTransparency(arg4.Theme.TextEmphasis.Transparency, if var4 then 2 else 1),
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 3
            })
            tbl3.ContentContainer = createElement2(str2, tbl4, tbl5)

            tbl3.SelectedFill = Roact.createElement(
                "Frame",
                {
                    BorderSizePixel = 0,
                    Size = arg1.fillSize,
                    BackgroundColor3 = arg4.Theme.BackgroundMuted.Color,
                    ZIndex = 2
                }
            )
            return createElement(str1, tbl2, tbl3)
        end)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didUpdate(arg1)
    arg1.motor:setGoal({
        fillProgress = Otter.spring(if arg1.props.selected then 1 else 0, { frequency = 2.5 }),
        hoverTransparency = Otter.spring(if arg1.state.hovering then 1 else 0, { frequency = 5 })
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        currentPage = arg1.menuPage
    }
end, function(callback)
    return {
        setCurrentPage = function(arg1)
            callback(SetCurrentPage(arg1))
            SendAnalytics("open_" .. arg1 .. "_tab", Constants.AnalyticsMenuActionName, {})
        end
    }
end)(function(arg1) -- name: PageNavigation
    local tbl1 = {
        Layout = Roact.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }
        )
    }
    local pagesByIndexLen = #Pages.pagesByIndex

    local num1 = 1
    for i, value in ipairs(Pages.pagesByIndex) do
        if value.parentPage ~= Constants.MainPagePageKey then
            continue
        end

        local var4 = "Page" .. value.key
        local createElement = Roact.createElement
        local var5 = var3
        local tbl2 = {
            icon = value.icon,
            LayoutOrder = num1,
            selected = arg1.currentPage == value.key,
            text = value.title,
            onActivated = 0,
            mainPageFirstButtonRef = 0
        }

        function tbl2.onActivated()
            arg1.setCurrentPage(value.key)
        end
        tbl2.mainPageFirstButtonRef = if num1 == 1 then arg1.mainPageFirstButtonRef or nil else nil
        tbl1[var4] = createElement(var5, tbl2)

        num1 += 1

        if not (i < pagesByIndexLen) then
            continue
        end

        local str1 = "Divider" .. num1
        tbl1[str1] = Roact.createElement(Divider, { LayoutOrder = num1, Size = UDim2.new(1, -24, 0, 1) })

        num1 += 1
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = arg1.Position,
        Size = UDim2.new(1, -Constants.Zone.ContentOffset, 0, pagesByIndexLen * 70 + (pagesByIndexLen - 1))
    }, tbl1)
end)
