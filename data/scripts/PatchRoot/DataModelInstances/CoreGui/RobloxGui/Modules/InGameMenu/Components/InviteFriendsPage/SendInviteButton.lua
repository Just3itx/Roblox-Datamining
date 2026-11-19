-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent

local InviteStatus = require(scriptParentParentParent.Resources.Constants).InviteStatus

local Images = UIBlox.App.ImageSet.Images

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local IconSize = Foundation.Enums.IconSize

local var3 = Roact.PureComponent:extend("SendInviteButton")

var3.validateProps = t.strictInterface({
    onActivated = t.callback,
    animationBegun = t.callback,
    animationEnded = t.callback,
    userInviteStatus = t.optional(t.string)
})

local function linearTween(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    local var4 = (arg3 - arg2) / 30
    return (arg1 - arg2 / 30) / var4
end

local function isBetweenFrames(arg1, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return num1 / 30 <= arg1 and arg1 <= num2 / 30
end

local tbl1 = {}
tbl1[InviteStatus.Pending] = function(arg1, arg2)
    local num1 = math.sin(math.pi * 2 * arg1) * 0.375 + 0.375
    arg2.sendTransparency(num1)
end

tbl1[InviteStatus.Success] = function(arg1, arg2, callback)
    if arg1 >= 0 and arg1 <= 2 / 15 then
        local var4 = (arg1 - 0) / (2 / 15)

        arg2.sendTransparency(var4)
        arg2.successTransparency(1 - var4)

        local var5 = 0.75 + 0.75 * (1 - var4)
        arg2.successSize(var5)
        return
    end

    if isBetweenFrames(arg1, 4, 9) then
        arg2.sendTransparency(1)
        arg2.successTransparency(0)
        local var4 = 0.75 + 0.25 * ((arg1 - 2 / 15) / (1 / 6))
        arg2.successSize(var4)
    else
        arg2.successSize(1)
        callback()
    end
end

tbl1[InviteStatus.Failed] = function(arg1, arg2, callback)
    if arg1 >= 0 and arg1 <= 1 / 15 then
        local var4 = (arg1 - 0) / (2 / 15)

        arg2.sendTransparency(var4)
    elseif isBetweenFrames(arg1, 2, 52) then
        arg2.sendTransparency(1)
    elseif isBetweenFrames(arg1, 52, 57) then
        local var4 = (arg1 - 26 / 15) / (1 / 6)

        arg2.sendTransparency(1 - var4)
    else
        arg2.sendTransparency(0)
        callback()
    end

    if arg1 >= 0 and arg1 <= 2 / 15 then
        local var4 = (arg1 - 0) / (2 / 15)

        arg2.failTransparency(1 - var4)
    elseif isBetweenFrames(arg1, 4, 42) then
        arg2.failTransparency(0)

        local var4 = arg1 - 2 / 15
        local var5 = -0.4 * 2.71828182846 ^ (-var4 * 8) * math.sin(var4 * 40)
        arg2.failPos(var5)
    elseif isBetweenFrames(arg1, 42, 47) then
        arg2.failPos(0)
        local var4 = (arg1 - 1.4) / (1 / 6)

        arg2.failTransparency(var4)
    else
        arg2.failTransparency(1)
    end
end

function var3.init(arg1, arg2)
    local sendTransparency, var4 = Roact.createBinding(0)
    local successTransparency, var5 = Roact.createBinding(1)
    local failTransparency, var6 = Roact.createBinding(1)

    local successScale, successSize = Roact.createBinding(1)
    local var12, failPos = Roact.createBinding(0)

    arg1.bindings = {
        sendTransparency = sendTransparency,
        successTransparency = successTransparency,
        failTransparency = failTransparency,
        successSize = successScale:map(function(num1: number?): UDim2
            return UDim2.new(num1, 0, num1, 0)
        end),
        successScale = successScale,
        failPos = var12:map(function(xScale: number?): UDim2
            return UDim2.new(xScale, 0, 0, 0)
        end)
    }

    arg1.updateBindings = {
        sendTransparency = var4,
        successTransparency = var5,
        failTransparency = var6,
        successSize = successSize,
        failPos = failPos
    }

    if arg2.userInviteStatus == InviteStatus.Success then
        var5(0)
        var4(1)
    end
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local props = arg1.props

    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                IconEmphasis = {
                    Color = arg3.Color.Content.Emphasis.Color3,
                    Transparency = arg3.Color.Content.Emphasis.Transparency
                }
            },
            IconSize = arg3.Size.Size_800
        }
    end, function(arg3)
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {
            Selectable = false,
            Size = UDim2.new(0, 36, 0, 36),
            BackgroundTransparency = 1,
            Text = "",
            SelectionImageObject = arg2(var2.InputFields)
        }
        tbl2[Roact.Event.Activated] = function()
            local bool1 = props.userInviteStatus == InviteStatus.Pending
            local bool2 = props.userInviteStatus == InviteStatus.Success
            if not (arg1.renderSteppedConnection or bool1 or bool2) then
                props.onActivated()
            end
        end
        local tbl3 = { SendLabel = 0, SuccessLabel = 0, FailLabel = 0 }
        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(Icon, {
                name = IconName.PersonArrowFromBottomRight,
                variant = IconVariant.Regular,
                size = IconSize.XXLarge,
                style = arg1.bindings.sendTransparency:map(function(transparency)
                    return {
                        Color3 = arg3.Theme.IconEmphasis.Color,
                        Transparency = transparency
                    }
                end)
            })
        else
            element = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = Images["icons/actions/friends/friendInvite"],
                Size = UDim2.new(1, 0, 1, 0),
                ImageColor3 = arg3.Theme.IconEmphasis.Color,
                ImageTransparency = arg1.bindings.sendTransparency
            })
        end

        tbl3.SendLabel = element
        local element2

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element2 = Roact.createElement(Icon, {
                name = IconName.CheckLarge,
                variant = IconVariant.Filled,
                size = arg1.bindings.successScale:map(function(arg4)
                    return arg3.IconSize * arg4
                end),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                style = arg1.bindings.successTransparency:map(function(transparency)
                    return {
                        Color3 = arg3.Theme.IconEmphasis.Color,
                        Transparency = transparency
                    }
                end)
            })
        else
            element2 = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = Images["icons/status/success"],
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                ImageColor3 = arg3.Theme.IconEmphasis.Color,
                ImageTransparency = arg1.bindings.successTransparency,
                Size = arg1.bindings.successSize
            })
        end

        tbl3.SuccessLabel = element2
        local element3

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element3 = Roact.createElement(Icon, {
                name = IconName.TriangleExclamation,
                variant = IconVariant.Filled,
                size = IconSize.XXLarge,
                style = arg1.bindings.failTransparency:map(function(transparency)
                    return {
                        Color3 = arg3.Theme.IconEmphasis.Color,
                        Transparency = transparency
                    }
                end),
                Position = arg1.bindings.failPos
            })
        else
            element3 = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = Images["icons/status/alert"],
                Size = UDim2.new(1, 0, 1, 0),
                ImageColor3 = arg3.Theme.IconEmphasis.Color,
                ImageTransparency = arg1.bindings.failTransparency,
                Position = arg1.bindings.failPos
            })
        end

        tbl3.FailLabel = element3
        return createElement(str1, tbl2, tbl3)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didUpdate(arg1, arg2)
    if arg1.props.userInviteStatus and arg1.props.userInviteStatus ~= arg2.userInviteStatus then
        arg1:playAnimation(tbl1[arg1.props.userInviteStatus])
    end
end

function var3.didMount(arg1)
    if arg1.props.userInviteStatus then
        arg1:playAnimation(tbl1[arg1.props.userInviteStatus])
    end
end

function var3.playAnimation(arg1, animationFunction)
    arg1.animationStartTime = tick()
    arg1.animationFunction = animationFunction

    if arg1.renderSteppedConnection then
        return
    end

    arg1.renderSteppedConnection = RunService.RenderStepped:Connect(function()
        arg1.animationFunction(tick() - arg1.animationStartTime, arg1.updateBindings, function()
            arg1:stopAnimation()
        end)
    end)
    arg1.props.animationBegun()
end

function var3.stopAnimation(arg1)
    if arg1.renderSteppedConnection then
        arg1.renderSteppedConnection:Disconnect()
        arg1.renderSteppedConnection = nil
        arg1.props.animationEnded()
    end
end

function var3.willUnmount(arg1)
    arg1:stopAnimation()
end

return var3
