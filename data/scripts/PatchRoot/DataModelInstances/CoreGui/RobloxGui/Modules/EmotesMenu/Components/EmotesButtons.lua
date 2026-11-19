-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent

local Actions = scriptParentParent.Actions
local Thunks = scriptParentParent.Thunks
local Utility = scriptParentParent.Utility

local Constants = require(scriptParentParent.Constants)

local GetSegmentFromPosition = require(Utility.GetSegmentFromPosition)

local FocusSegment = require(Actions.FocusSegment)
local HideMenu = require(Actions.HideMenu)
local PlayEmote = require(Thunks.PlayEmote)

local var1 = Roact.PureComponent:extend("EmotesButtons")

local function positionInsideOuterCircle(arg1, vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = arg1.AbsoluteSize.X / 2

    return var2 * Constants.InnerCircleSizeRatio < vector2.Magnitude and vector2.Magnitude < var2
end

local function getSegmentFromInput(arg1, arg2)
    local var2 = Vector2.new(arg2.Position.X, arg2.Position.Y) - arg1.AbsolutePosition - arg1.AbsoluteSize / 2

    local vector2 = Vector2.new(var2.X, -var2.Y)

    if not positionInsideOuterCircle(arg1, vector2) then
        return 0
    end

    return GetSegmentFromPosition(vector2)
end

local function getRandomAssetId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if #arg1 ~= 0 then
        return arg1[math.random(1, #arg1)]
    end
end

local function getEmoteImage(randomAssetId) -- Luacid: Inlined by compiler; 1 call site recovered
    return Constants.EmotesImage:format(randomAssetId)
end

function var1.render(arg1)
    local currentEmotes = arg1.props.emotesPage.currentEmotes
    local emotesInfo = arg1.props.emotesPage.emotesInfo
    local tbl1 = ({})

    for k, value in pairs(currentEmotes) do
        local var2 = emotesInfo[value]

        if Constants.EmotesPerPage < k then
            warn("EmotesMenu: Number of emotes in page exceeds max emotes per page")
            break
        end

        local var3 = 360 / Constants.EmotesPerPage * (k - 1) + Constants.SegmentsStartRotation
        local var4 = Constants.InnerCircleSizeRatio / 2

        local var5 = (1 - Constants.InnerCircleSizeRatio) / 2 - Constants.SlotNumberSize - Constants.ImageOutsidePadding

        local var6 = var5 / 2 + Constants.SlotNumberSize - Constants.ImageOutsidePadding / 2

        local num1 = math.cos(math.rad(var3))
        local var7 = var4 * num1

        local var8 = var6 * num1
        local xScale = 0.5 + var7 + var8

        local num2 = math.sin(math.rad(var3))
        local var9 = var4 * num2

        local var10 = var6 * num2
        local yScale = 0.5 + var9 + var10
        local image = getEmoteImage((getRandomAssetId(var2)))

        local createElement = Roact.createElement
        local tbl2 = {
            Image = image,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(xScale, 0, yScale, 0),
            Size = UDim2.new(var5, 0, var5, 0),
            BackgroundTransparency = 1,
            ZIndex = 2
        }

        local tbl3 = {
            AsspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1 })
        }
        tbl1[k] = createElement("ImageLabel", tbl2, tbl3)
    end

    local createElement = Roact.createElement
    local tbl2 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        Text = ""
    }
    tbl2[Roact.Event.InputChanged] = function(arg2, arg3)
        local userInputType = arg3.UserInputType

        if userInputType ~= Enum.UserInputType.MouseMovement and userInputType ~= Enum.UserInputType.Touch then
            return
        end

        local segmentFromInput = getSegmentFromInput(arg2, arg3)

        if segmentFromInput == arg1.props.emotesWheel.focusedSegmentIndex then
            return
        end

        if arg1.props.emotesPage.currentEmotes[segmentFromInput] then
            arg1.props.focusSegment(segmentFromInput)
            return
        end
        arg1.props.focusSegment(0)
    end

    tbl2[Roact.Event.Activated] = function(arg2, arg3)
        local segmentFromInput = getSegmentFromInput(arg2, arg3)
        if segmentFromInput == 0 then
            arg1.props.hideMenu()
            return
        end

        local var2 = arg1.props.emotesPage.currentEmotes[segmentFromInput]
        if not var2 then
            return
        end

        local var3 = arg1.props.emotesPage.emotesInfo[var2]
        if not var3 then
            return
        end

        local randomAssetId = getRandomAssetId(var3)
        arg1.props.playEmote(var2, segmentFromInput, randomAssetId)
    end

    tbl2[Roact.Event.MouseLeave] = function()
        arg1.props.focusSegment(0)
    end

    return createElement("TextButton", tbl2, tbl1)
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        displayOptions = arg1.displayOptions,
        emotesPage = arg1.emotesPage,
        emotesWheel = arg1.emotesWheel
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
