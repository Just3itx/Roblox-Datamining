-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local AppFonts = require(AuthCommonParent.Style).AppFonts

local Roact = require(AuthCommonParent.Roact)
local RoactRodux = require(AuthCommonParent.RoactRodux)
local RoactServices = require(AuthCommonParent.RoactServices).RoactServices
local RoactNetworking = require(AuthCommonParent.RoactServiceTags).RoactNetworking
local UIBlox = require(AuthCommonParent.UIBlox)

local withLocalization = require(AuthCommonParent.Localization).withLocalization

local FormFactor = require(AuthCommonParent.FormFactor).Enums.FormFactor

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local SearchBar = require(AuthCommon.Components.SearchBar)
local WindowedListFrame = require(AuthCommon.Components.WindowedListFrame)
local Colors = require(AuthCommonParent.Style).Colors

local Otter = require(AuthCommonParent.Otter)

local var1 = Roact.PureComponent:extend("ListSearchWidget")

local Flint = Colors.Flint
local Obsidian = Colors.Obsidian
local White = Colors.White

function var1.init(arg1)
    arg1.state = {
        fullLoad = false,
        visible = false,
        filteredList = arg1.props.List
    }

    arg1.visibility = 0
    arg1.visibilityTarget = 0
    arg1.baseFrameRef = Roact.createRef()

    function arg1.getWidgetPosition(): UDim2
        return UDim2.new(0.5, 0, 2 - arg1.visibility, 10)
    end

    function arg1.searchTextChanged(arg2)
        local str1 = string.lower(arg2.Text)
        if str1 == "" then
            if arg1.state.filteredList ~= arg1.props.List then
                arg1:setState({ filteredList = arg1.props.List })
            end

            return
        end

        local filteredList = {}
        for _, value in ipairs(arg1.props.List) do
            if string.find(string.lower(value.localizedName), str1, 1, true) then
                table.insert(filteredList, value)
            end
        end
        arg1:setState({ filteredList = filteredList })
    end

    function arg1.renderWidgetBackground(arg2)
        local var2 = 1.4 * arg2.closeButtonSize
        if not arg2.isWideScreen then
            local yOffset = arg2.closeButtonSize + 20
            local createElement = Roact.createElement
            local tbl1 = {
                Size = UDim2.new(1, 0, 1, 10),
                Position = arg2.Position,
                AnchorPoint = Vector2.new(0.5, 1),
                BackgroundColor3 = Flint,
                Visible = arg2.Visible,
                [Roact.Ref] = arg1.baseFrameRef
            }
            local tbl2 = {
                UIPadding = Roact.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, 40),
                    PaddingLeft = UDim.new(0, 20),
                    PaddingRight = UDim.new(0, 20),
                    PaddingBottom = UDim.new(0, 10)
                }),
                CloseButton = Roact.createElement(ImageSetButton, {
                    Size = UDim2.new(0, arg2.closeButtonSize, 0, arg2.closeButtonSize),
                    Image = GetImageData("LuaApp/icons/GameDetails/navigation/close") or "LuaApp/icons/GameDetails/navigation/close",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.21, 0),
                    [Roact.Event.Activated] = arg2.CloseCallback
                }),
                ContentWrapper = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, -yOffset),
                        Position = UDim2.new(0, 0, 0, yOffset)
                    },
                    arg2.contents
                )
            }
            return createElement("Frame", tbl1, tbl2)
        end

        local createElement = Roact.createElement
        local var3 = ImageSetLabel
        local tbl1 = {
            Size = UDim2.new(1, 0, 1, -var2 + 10),
            Position = arg2.Position,
            AnchorPoint = Vector2.new(0.5, 1),
            BackgroundTransparency = 1,
            Image = GetImageData("LuaApp/buttons/buttonFill") or "LuaApp/buttons/buttonFill",
            ImageColor3 = Flint,
            BorderSizePixel = 0,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Visible = arg2.Visible,
            [Roact.Ref] = arg1.baseFrameRef
        }
        local tbl2 = {
            CloseButton = Roact.createElement(ImageSetButton, {
                Size = UDim2.new(0, arg2.closeButtonSize, 0, arg2.closeButtonSize),
                AnchorPoint = Vector2.new(0, 1),
                Image = GetImageData("LuaApp/icons/GameDetails/navigation/close") or "LuaApp/icons/GameDetails/navigation/close",
                BackgroundTransparency = 1,
                [Roact.Event.Activated] = arg2.CloseCallback
            }),
            UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(600, math.huge) }),
            ContentWrapper = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -80, 1, -50),
                    Position = UDim2.new(0, 40, 0, 40)
                },
                arg2.contents
            )
        }
        return createElement(var3, tbl1, tbl2)
    end
end

function var1.didMount(arg1)
    arg1.motor = Otter.createSingleMotor(arg1.visibility)
    arg1.motor:onStep(function(visibility)
        arg1.visibility = visibility
        if arg1.baseFrameRef.current then
            arg1.baseFrameRef.current.Position = arg1.getWidgetPosition()
            arg1.baseFrameRef.current.Parent.BackgroundTransparency = 1 - 0.5 * arg1.visibility
        end

        if visibility == 0 and arg1.state.visible then
            arg1:setState({ visible = false })
        elseif visibility == 1 and not arg1.state.fullLoad then
            arg1:setState({ fullLoad = true })
        end
    end)
end

function var1.willUnmount(arg1)
    if arg1.motor then
        arg1.motor:destroy()
    end
end

var1.defaultProps = { SearchPlaceholder = "Feature.Chat.Label.SearchWord" }

function var1.render(arg1)
    local isWideScreen = arg1.props.formFactor == FormFactor.WIDE

    local num1 = 27
    local num2 = 14
    local num3 = 24
    local yOffset = 24
    local num4 = num2 + 36

    if isWideScreen then
        num1 = 48
        num2 = 18
        num3 = 30
        yOffset = 24
        num4 = num2 + 48
    end

    local yOffset2 = num2 * 2.4
    local scrollingFrameOffset = yOffset2 + 40 + yOffset

    local bool2 = arg1.props.VisibilityTarget == 1

    return withLocalization({ heading = arg1.props.Heading, search = arg1.props.SearchPlaceholder })(function(arg2)
        local autoButtonColor = not bool2 and nil
        return Roact.createElement(if bool2 then "TextButton" else "Frame", {
            AutoButtonColor = autoButtonColor,
            Text = if bool2 then "" else nil,
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 1 - 0.5 * arg1.visibility,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0
        }, {
            Roact.createElement(arg1.renderWidgetBackground, {
                isWideScreen = isWideScreen,
                closeButtonSize = num1,
                Position = arg1.getWidgetPosition(),
                CloseCallback = arg1.props.CloseCallback,
                Visible = arg1.state.visible,
                contents = {
                    Heading = Roact.createElement("TextLabel", {
                        Text = arg2.heading,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        TextSize = yOffset,
                        Font = AppFonts.default:getBold(),
                        TextColor3 = White,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    SearchBar = Roact.createElement(SearchBar, {
                        Size = UDim2.new(1, 0, 0, yOffset2),
                        Position = UDim2.new(0, 0, 0, yOffset + 20),
                        ImageColor3 = Obsidian,
                        PlaceholderText = arg2.search,
                        PlaceholderColor3 = Flint,
                        IconSize = num3,
                        Text = "",
                        TextSize = num2,
                        TextColor3 = White,
                        TextChanged = arg1.searchTextChanged
                    }),
                    ListFrame = Roact.createElement(WindowedListFrame, {
                        List = arg1.state.filteredList,
                        ScrollingFrameOffset = scrollingFrameOffset,
                        TextSize = num2,
                        ButtonSizeY = num4,
                        ListButton = arg1.props.ListButton,
                        ListButtonProps = {
                            TextSize = num2,
                            SelectionCallback = arg1.props.SelectionCallback
                        }
                    })
                }
            })
        })
    end)
end

function var1.didUpdate(arg1, arg2)
    if arg1.visibilityTarget ~= arg1.props.VisibilityTarget and arg1.motor then
        arg1.visibilityTarget = arg1.props.VisibilityTarget

        arg1.motor:setGoal(Otter.spring(arg1.visibilityTarget), { frequency = 3 })

        if arg1.visibilityTarget > 0 and not arg1.state.visible then
            arg1:setState({ visible = true })
        end
    end

    if arg2.List ~= arg1.props.List or arg1.props.VisibilityTarget == 1 and arg2.VisibilityTarget ~= 1 then
        arg1:setState({ filteredList = arg1.props.List })
    end
end

local var2 = RoactRodux.connect(function(arg1, _)
    return {
        formFactor = arg1.FormFactor
    }
end)(var1)

return RoactServices.connect({ networking = RoactNetworking })(var2)
