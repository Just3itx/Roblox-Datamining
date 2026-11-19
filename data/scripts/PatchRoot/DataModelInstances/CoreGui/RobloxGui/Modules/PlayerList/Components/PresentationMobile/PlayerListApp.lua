-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Otter = require(CorePackages.Packages.Otter)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local useLayoutValues = PlayerList.Common.useLayoutValues
local Constants = PlayerList.Common.Constants

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Constants2 = require(Modules.TopBar.Constants)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()

local useTokens = require(CorePackages.Packages.Foundation).Hooks.useTokens

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local SetPlayerListVisibility = require(scriptParentParentParent.Actions.SetPlayerListVisibility)
local SetIsUsingGamepad = require(scriptParentParentParent.Actions.SetIsUsingGamepad)

local PlayerListDisplayContainer = require(scriptParentParentParent.Components.Container.PlayerListDisplayContainer)
local PlayerDropDown = require(scriptParent.PlayerDropDown)

local Connection = scriptParentParentParent.Components.Connection
local EventConnections = require(Connection.EventConnections)
local ContextActionsBinder = require(Connection.ContextActionsBinder)
local TopStatConnector = require(Connection.TopStatConnector)
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local FFlagPlayerListFixMobileScrolling = require(scriptParentParentParent.Flags.FFlagPlayerListFixMobileScrolling)
local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagPlayerListIgnoreDevGamepadBindings = PlayerList.Flags.FFlagPlayerListIgnoreDevGamepadBindings
local FFlagPlayerListRemoveTopStat = require(scriptParentParentParent.Flags.FFlagPlayerListRemoveTopStat)

local tbl1 = { dampingRatio = 1, frequency = 4 }

local function map(arg1, arg2, arg3, arg4, arg5) -- Luacid: unused: defined but never referenced
    return (arg1 - arg2) * (arg5 - arg4) / (arg3 - arg2) + arg4
end

local var2 = Roact.PureComponent:extend("PlayerListApp")

local function playerListSizeFromViewportSize(arg1, vector2: Vector2, uiScale, yOffset: number?, num1: number?): UDim2
    local num2 = math.min(vector2.x, vector2.y)
    local num3 = math.max(vector2.x, vector2.y)
    local num4 = (num2 - 320) * 60 / 55 + 270
    local num5 = (num3 - 480) * 46 / 190 + 434

    if not (FFlagEnableMobilePlayerListOnConsole and num4 > 500) then
        yOffset = math.clamp(num4, math.min(270, num2 - 24), 500)
    end
    if not (FFlagEnableMobilePlayerListOnConsole and num5 > 600) then
        num1 = math.clamp(num5, math.min(434, num3 - 24), 600)
    end

    local xOffset = if vector2.x > vector2.y then num1 or yOffset else yOffset

    if vector2.y > vector2.x then
        yOffset = num1 or yOffset
    end

    if not FFlagEnableMobilePlayerListOnConsole then
        xOffset *= uiScale
        yOffset *= uiScale
    end

    if var1 and vector2.y < vector2.x then
        yOffset -= Constants2.TopBarHeight * arg1.state.UiScale - 24
    end

    return UDim2.fromOffset(xOffset, yOffset)
end

local function shouldShowNeutralTeam(players) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, player in ipairs(players) do
        if player.Team == nil then
            return true
        end
    end
    return false
end

local function getTeamCount(teams, players): number
    local tbl2 = {}
    local num1 = 0
    for _, team in pairs(teams) do
        if not tbl2[team.TeamColor.Number] then
            tbl2[team.TeamColor.Number] = true
            num1 += 1
        end
    end

    if num1 > 0 and shouldShowNeutralTeam(players) then
        num1 += 1
    end
    return num1
end

function var2.init(arg1)
    arg1.state = { visible = false }

    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)

    local bodyTransparency, updateBodyTransparency = Roact.createBinding(0.5)
    arg1.bodyTransparency = bodyTransparency
    arg1.updateBodyTransparency = updateBodyTransparency
    arg1.bodyTransparencyMotor = Otter.createSingleMotor(1)
    arg1.bodyTransparencyMotor:onStep(function(arg2)
        arg1.updateBodyTransparency(arg2)
        arg1.props.setLayerCollectorEnabled(arg2 < 0.99 or arg1.props.displayOptions.isVisible)
    end)
    arg1.bodyTransparencyMotor:onComplete(function()
        if not arg1.props.displayOptions.isVisible then
            arg1:setState({ visible = false })
        end
    end)

    local bgTransparency, updateBgTransparency = Roact.createBinding(0)
    arg1.bgTransparency = bgTransparency
    arg1.updateBgTransparency = updateBgTransparency
    arg1.bgTransparencyMotor = Otter.createSingleMotor(1)
    arg1.bgTransparencyMotor:onStep(arg1.updateBgTransparency)

    local frameScale, updateFrameScale = Roact.createBinding(1)
    arg1.frameScale = frameScale
    arg1.updateFrameScale = updateFrameScale
    arg1.frameScaleMotor = Otter.createSingleMotor(0)
    arg1.frameScaleMotor:onStep(function(arg2)
        arg1.updateFrameScale(arg2)
    end)

    arg1.titleRef = Roact.createRef()
    arg1.closeRef = Roact.createRef()
end

function var2.renderBodyChildren(arg1, _, arg2)
    local visible = arg1.state.visible
    local isDropDownVisible = arg1.props.isDropDownVisible

    local size1100 = arg1.props.tokens.Size.Size_1100
    local size500 = arg1.props.tokens.Size.Size_500

    local tbl2 = {
        UIScale = Roact.createElement("UIScale", { Scale = arg1.frameScale }),
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 6) }),
        TitleText = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, size1100),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Font = AppFonts.default:getBold(),
            Visible = visible and not isDropDownVisible,
            TextSize = arg1.props.tokens.FontSize.FontSize_500,
            TextColor3 = Color3.fromRGB(240, 240, 240),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Text = RobloxTranslator:FormatByKey("InGame.PlayerList.Leaderboard"),
            [Roact.Ref] = arg1.titleRef
        }),
        CloseButton = 0,
        ContentFrame = 0
    }

    local createElement = Roact.createElement
    local tbl3 = {
        Image = "rbxasset://textures/ui/InspectMenu/x.png",
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(size500, size500),
        Position = UDim2.fromOffset(size500 / 2, size500),
        BackgroundTransparency = 1,
        Visible = visible and not isDropDownVisible,
        ZIndex = 0,
        [Roact.Ref] = arg1.closeRef
    }

    tbl3[Roact.Event.Activated] = function()
        arg1.props.setPlayerListVisible(false)
    end

    tbl2.CloseButton = createElement("ImageButton", tbl3)

    tbl2.ContentFrame = Roact.createElement("Frame", {
        Position = UDim2.new(0.5, 0, 1, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.new(1, 0, 1, -size1100),
        BackgroundTransparency = 1,
        Visible = visible and not isDropDownVisible,
        AutoLocalize = false
    }, arg2)
    return tbl2
end

function var2.render(arg1)
    if not arg1.state.visible then
        return Roact.createElement(ContextActionsBinder)
    end
    return WithLayoutValues(function(arg2)
        if FFlagEnableMobilePlayerListOnConsole then
            arg2 = arg1.props.layoutValues
        end

        local entrySizeX

        if arg2.IsTenFoot then
            entrySizeX = arg2.EntrySizeX
        else
            entrySizeX = arg2.EntryBaseSizeX + 4 * arg2.EntrySizeIncreasePerStat

            local var3 = arg2.PlayerDropDownSizeXMobile + arg2.PlayerDropDownOffset
            local var4 = arg2.ContainerPadding * 2 + var3

            if arg1.props.screenSizeX - var4 < entrySizeX then
                entrySizeX = arg1.props.screenSizeX - var4
            end
        end

        local huge = if Players.MaxPlayers >= 6 and Players.MaxPlayers <= 12 then Players.MaxPlayers * 26 + getTeamCount(arg1.props.teams, arg1.props.players) * 20 else math.huge

        local offset = Constants2.TopBarHeight * arg1.state.UiScale

        local tbl2 = ({})

        if arg1.state.visible then
            tbl2.PlayerScrollList = Roact.createElement(PlayerListDisplayContainer, {
                screenSizeY = arg1.props.screenSizeY,
                entrySize = entrySizeX,
                isVisible = if FFlagAddNewPlayerListFocusNav then arg1.props.displayOptions.isVisible else nil
            })
        end
        tbl2.EventConnections = Roact.createElement(EventConnections)
        tbl2.ContextActionsBindings = Roact.createElement(ContextActionsBinder)
        if not FFlagPlayerListRemoveTopStat then
            tbl2.TopStatConnector = Roact.createElement(TopStatConnector)
        end

        local createElement = Roact.createElement
        local str1 = "ImageButton"
        local tbl3 = {
            Active = arg1.props.displayOptions.isVisible,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundColor3 = Color3.fromRGB(17, 18, 20),
            BackgroundTransparency = arg1.bgTransparency,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            AutoLocalize = false,
            AutoButtonColor = false,
            Selectable = not FFlagPlayerListFixMobileScrolling,
            Image = ""
        }

        tbl3[Roact.Event.Activated] = function()
            arg1.props.setPlayerListVisible(false)
        end

        return createElement(str1, tbl3, {
            PlayerDropDown = Roact.createElement(PlayerDropDown, { contentsVisible = true, selectedPlayer = arg1.props.dropDownPlayer }),
            BodyPadding = if var1 and arg1.props.screenSizeY < arg1.props.screenSizeX then Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }) else nil,
            BodyBackground = Roact.createElement("Frame", {
                Size = playerListSizeFromViewportSize(
                    arg1,
                    Vector2.new(arg1.props.screenSizeX, arg1.props.screenSizeY),
                    arg1.state.UiScale,
                    arg2.PlayerListSizeMin,
                    arg2.PlayerListSizeMax
                ),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(17, 18, 20),
                BackgroundTransparency = arg1.bodyTransparency,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BorderSizePixel = 0
            }, arg1:renderBodyChildren(huge, tbl2))
        })
    end)
end

function var2.didMount(arg1)
    arg1.props.setLayerCollectorEnabled(false)
    arg1:setState({ visible = arg1.props.displayOptions.isVisible })
end

function var2.willUnmount(arg1)
    arg1.props.setLayerCollectorEnabled(true)
    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end

function var2.didUpdate(arg1, arg2, _)
    local isVisible = arg1.props.displayOptions.isVisible
    local isDropDownVisible = arg1.props.isDropDownVisible

    if FFlagPlayerListIgnoreDevGamepadBindings and isVisible ~= arg2.displayOptions.isVisible then
        GuiService:SetMenuIsOpen(isVisible, Constants.PLAYER_LIST_MENU)
    end

    if isVisible then
        arg1:setState({ visible = true })
    end

    if isVisible ~= arg2.displayOptions.isVisible and isVisible then
        local bool1 = UserInputService:GetLastInputType().Name:find("Gamepad") ~= nil
        arg1.props.setIsUsingGamepad(bool1)
    end

    arg1.bgTransparencyMotor:setGoal(Otter.spring(if isDropDownVisible or isVisible then 0.7 else 1, tbl1))

    local var3 = isDropDownVisible and isVisible

    local num1 = 1.25
    if var3 then
        num1 = 0.95
    elseif isVisible then
        num1 = 1
    end

    arg1.frameScaleMotor:setGoal(Otter.spring(num1, tbl1))

    local num2 = 1
    if var3 then
        num2 = 0.8 * arg1.props.preferredTransparency
    elseif isVisible then
        num2 = 0.2 * arg1.props.preferredTransparency
    end

    arg1.bodyTransparencyMotor:setGoal(Otter.spring(num2, tbl1))
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        isDropDownVisible = arg1.playerDropDown.isVisible,
        screenSizeX = arg1.screenSize.X,
        screenSizeY = arg1.screenSize.Y,
        preferredTransparency = arg1.settings.preferredTransparency,
        displayOptions = arg1.displayOptions,
        players = arg1.players,
        playerStats = arg1.playerStats,
        playerIconInfo = arg1.playerIconInfo,
        playerRelationship = arg1.playerRelationship,
        gameStats = arg1.gameStats,
        teams = arg1.teams
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        setPlayerListVisible = function(arg2)
            return arg1(SetPlayerListVisibility(arg2))
        end,
        setIsUsingGamepad = function(arg2)
            return arg1(SetIsUsingGamepad(arg2))
        end
    }
end)(function(arg1)
    local var3 = if FFlagEnableMobilePlayerListOnConsole then useLayoutValues() else nil
    local tokens = useTokens()

    local createElement = Roact.createElement
    local var5 = var2
    local join = Cryo.Dictionary.join
    local tbl2 = { layoutValues = 0, tokens = 0 }
    if not FFlagEnableMobilePlayerListOnConsole then
        var3 = nil
    end

    tbl2.layoutValues = var3
    tbl2.tokens = tokens
    return createElement(var5, join(arg1, tbl2))
end)
