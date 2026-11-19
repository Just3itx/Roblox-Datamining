-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")
local VRService = game:GetService("VRService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Actions = scriptParentParent.Actions
local Thunks = scriptParentParent.Thunks
local Utility = scriptParentParent.Utility

local Constants = require(scriptParentParent.Constants)

local GetSegmentFromPosition = require(Utility.GetSegmentFromPosition)

local EmotesButtons = require(scriptParent.EmotesButtons)
local SlotNumbers = require(scriptParent.SlotNumbers)
local WheelBackground = require(scriptParent.WheelBackground)

local FocusSegment = require(Actions.FocusSegment)
local HideMenu = require(Actions.HideMenu)
local PlayEmote = require(Thunks.PlayEmote)

local HighValue = Enum.ContextActionPriority.High.Value

local var1 = Roact.PureComponent:extend("EmotesWheel")

local function getRandomAssetId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if #arg1 ~= 0 then
        return arg1[math.random(1, #arg1)]
    end
end

function var1.bindActions(arg1)
    if arg1.actionsBound then
        return
    end

    ContextActionService:BindActionAtPriority(Constants.EmoteSelectionAction, function(_: string, _userInputState: Enum.UserInputState, inputObject: InputObject) -- name: selectEmote
        local vector2 = Vector2.new(inputObject.Position.X, inputObject.Position.Y)

        if vector2.Magnitude < Constants.ThumbstickThreshold then
            return
        end

        local segmentFromPosition = GetSegmentFromPosition(vector2)
        if segmentFromPosition == arg1.props.emotesWheel.focusedSegmentIndex then
            return
        end

        if arg1.props.emotesPage.currentEmotes[segmentFromPosition] then
            arg1.props.focusSegment(segmentFromPosition)
        else
            arg1.props.focusSegment(0)
        end
    end, false, HighValue, Constants.SelectionThumbstick)

    ContextActionService:BindActionAtPriority(Constants.PlaySelectedAction, function(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject) -- name: playSelected
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end

        local focusedSegmentIndex = arg1.props.emotesWheel.focusedSegmentIndex
        local var2 = arg1.props.emotesPage.currentEmotes[focusedSegmentIndex]

        if not var2 then
            return
        end

        local var3 = arg1.props.emotesPage.emotesInfo[var2]
        if not var3 then
            return
        end

        local randomAssetId = getRandomAssetId(var3)
        arg1.props.playEmote(var2, focusedSegmentIndex, randomAssetId)
    end, false, HighValue, Constants.PlayEmoteButton)

    local function closeMenu(_, userInputState, _) -- Luacid: Inlined by compiler; 1 call site recovered
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.hideMenu()
        end
    end

    local tbl1 = { Constants.EmoteMenuCloseKey, Constants.EmoteMenuCloseButton, Constants.EmoteMenuCloseButtonSecondary }

    ContextActionService:BindActionAtPriority(Constants.CloseMenuAction, closeMenu, false, HighValue, unpack(tbl1))

    local contextActionService = ContextActionService
    local leaveMenuDontSinkInputAction = Constants.LeaveMenuDontSinkInputAction

    local priorityLevel = HighValue
    local leaveMenuNoSinkInputs = Constants.LeaveMenuNoSinkInputs

    contextActionService:BindActionAtPriority(leaveMenuDontSinkInputAction, function(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject): Enum.ContextActionResult -- name: closeMenuNoSink
        closeMenu(nil, userInputState, nil)
        return Enum.ContextActionResult.Pass
    end, false, priorityLevel, unpack(leaveMenuNoSinkInputs))

    local function activateEmoteByNumber(_: string, userInputState: Enum.UserInputState, inputObject: InputObject)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end

        local var2 = nil

        for i, emoteSlotKey in ipairs(Constants.EmoteSlotKeys) do
            if emoteSlotKey == inputObject.KeyCode then
                var2 = i
                break
            end
        end

        if not var2 then
            return
        end

        local var3 = arg1.props.emotesPage.currentEmotes[var2]
        if not var3 then
            return
        end

        local var4 = arg1.props.emotesPage.emotesInfo[var3]
        if not var4 then
            return
        end

        local randomAssetId = getRandomAssetId(var4)
        arg1.props.playEmote(var3, var2, randomAssetId)
    end

    ContextActionService:BindActionAtPriority(
        Constants.ActivateEmoteSlotAction,
        activateEmoteByNumber,
        false,
        HighValue,
        unpack(Constants.EmoteSlotKeys)
    )

    ContextActionService:BindCoreActionAtPriority(Constants.VirtualCursorSinkAction, function(_, _, _): Enum.ContextActionResult -- name: sinkInput
        return Enum.ContextActionResult.Sink
    end, false, HighValue, Enum.KeyCode.ButtonSelect)

    arg1.actionsBound = true
end

function var1.unbindActions(arg1)
    if not arg1.actionsBound then
        return
    end

    ContextActionService:UnbindAction(Constants.CloseMenuAction)
    ContextActionService:UnbindAction(Constants.EmoteSelectionAction)
    ContextActionService:UnbindAction(Constants.PlaySelectedAction)
    ContextActionService:UnbindAction(Constants.LeaveMenuDontSinkInputAction)
    ContextActionService:UnbindAction(Constants.ActivateEmoteSlotAction)
    ContextActionService:UnbindCoreAction(Constants.VirtualCursorSinkAction)

    arg1.actionsBound = false
end

function var1.addCursorOverride(arg1)
    if VRService.VREnabled then
        return
    end

    if arg1.isUsingGamepad and not arg1.isCursorHidden then
        MouseIconOverrideService.push(Constants.CursorOverrideName, Enum.OverrideMouseIconBehavior.ForceHide)

        GamepadService.GamepadCursorEnabled = false
        arg1.isCursorHidden = true
    end
end

function var1.removeCursorOverride(arg1)
    if arg1.isCursorHidden then
        MouseIconOverrideService.pop(Constants.CursorOverrideName)

        arg1.isCursorHidden = false
    end
end

function var1.connectListeners(arg1)
    arg1.inputTypeChangedListener = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        if Constants.GamepadInputTypes[lastInputType] then
            arg1.isUsingGamepad = true

            if arg1.props.displayOptions.menuVisible then
                arg1:addCursorOverride()
            end
        else
            arg1.isUsingGamepad = false

            arg1:removeCursorOverride()
        end
    end)
end

function var1.disconnectListeners(arg1)
    arg1.inputTypeChangedListener:Disconnect()
end

function var1.didUpdate(arg1)
    if arg1.props.displayOptions.menuVisible then
        arg1:bindActions()

        arg1:addCursorOverride()
        return
    end
    arg1:unbindActions()

    arg1:removeCursorOverride()
end

function var1.didMount(arg1)
    if arg1.props.displayOptions.menuVisible then
        arg1:bindActions()
    end

    arg1:connectListeners()
end

function var1.willUnmount(arg1)
    arg1:unbindActions()

    arg1:disconnectListeners()
end

function var1.render(arg1)
    return Roact.createElement("Frame", {
        Active = true,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = arg1.props.displayOptions.menuVisible
    }, {
        MouseUnlock = Roact.createElement("TextButton", { Modal = true, Size = UDim2.new(0, 0, 0, 0), Text = "", Transparency = 1 }),
        Back = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 1
            },
            {
                Background = Roact.createElement(WheelBackground)
            }
        ),
        Front = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 2
            },
            {
                EmotesButtons = Roact.createElement(EmotesButtons),
                SlotNumbers = Roact.createElement(SlotNumbers)
            }
        )
    })
end
return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        displayOptions = arg1.displayOptions,
        emotesWheel = arg1.emotesWheel,
        emotesPage = arg1.emotesPage
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        playEmote = function(arg2, arg3, arg4)
            return arg1(PlayEmote(arg2, arg3, arg4))
        end,
        focusSegment = function(arg2)
            return arg1(FocusSegment(arg2))
        end,
        hideMenu = function()
            return arg1(HideMenu())
        end
    }
end)(var1)
