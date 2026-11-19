-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Skeleton = require(CorePackages.Packages.Foundation).Skeleton

local VerticalScrollViewWithMargin = UIBlox.App.Container.VerticalScrollViewWithMargin
local withStyle = UIBlox.Style.withStyle
local EmptyState = UIBlox.App.Indicator.EmptyState

local ListSection = require(script.ListSection)

local scriptParentParent = script.Parent.Parent
local GetAssetsDifference = require(scriptParentParent.GetAssetsDifference)
local AddAnalyticsInfo = require(scriptParentParent.Actions.AddAnalyticsInfo)

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local var1 = Roact.PureComponent:extend("ItemsList")

var1.validateProps = t.strictInterface({
    humanoidDescription = t.optional(t.instanceOf("HumanoidDescription")),
    loadingFailed = t.boolean,
    retryLoadDescription = t.callback,
    itemListScrollableUpdated = t.optional(t.callback),
    addAnalyticsInfo = t.callback
})

function var1.init(arg1)
    arg1:setState({ canvasSizeY = 0, loading = true, addedAssetNames = nil, removedAssetNames = nil })

    arg1.mounted = false

    arg1.frameRef = Roact.createRef()
    local topGradientVisibleBinding, updateTopGradientVisibleBinding = Roact.createBinding(false)
    arg1.topGradientVisibleBinding = topGradientVisibleBinding
    arg1.updateTopGradientVisibleBinding = updateTopGradientVisibleBinding
    local bottomGradientVisibleBinding, updateBottomGradientVisibleBinding = Roact.createBinding(false)
    arg1.bottomGradientVisibleBinding = bottomGradientVisibleBinding
    arg1.updateBottomGradientVisibleBinding = updateBottomGradientVisibleBinding

    arg1.addedSectionRef = Roact.createRef()
    arg1.removedSectionRef = Roact.createRef()
    arg1.noChangedAssetsRef = Roact.createRef()

    arg1.lastWasScrollable = nil
    function arg1.checkIsScrollable()
        local value = arg1.frameRef:getValue()
        if not value or not arg1.props.itemListScrollableUpdated then
            return
        end

        local lastWasScrollable = arg1.state.canvasSizeY > value.AbsoluteSize.Y

        if lastWasScrollable ~= arg1.lastWasScrollable then
            arg1.lastWasScrollable = lastWasScrollable
            arg1.props.itemListScrollableUpdated(lastWasScrollable, value.AbsoluteSize.Y)
        end
    end

    function arg1.onContentSizeChanged(arg2)
        arg1:setState({ canvasSizeY = arg2.AbsoluteContentSize.Y })
    end

    function arg1.firstEntryPositionChanged(arg2)
        local value = arg1.frameRef:getValue()
        if not value then
            return
        end

        if arg2.AbsolutePosition.Y < value.AbsolutePosition.Y then
            arg1.updateTopGradientVisibleBinding(true)
        else
            arg1.updateTopGradientVisibleBinding(false)
        end
    end

    function arg1.lastEntryPositionChanged(arg2)
        local value = arg1.frameRef:getValue()
        if not value then
            return
        end

        if arg2.AbsolutePosition.Y + arg2.AbsoluteSize.Y > value.AbsolutePosition.Y + value.AbsoluteSize.Y then
            arg1.updateBottomGradientVisibleBinding(true)
        else
            arg1.updateBottomGradientVisibleBinding(false)
        end
    end

    function arg1.loadAssetNames()
        coroutine.wrap(function()
            GetAssetsDifference(arg1.props.humanoidDescription):andThen(function(arg2)
                if not arg1.mounted then
                    return
                end

                arg1.props.addAnalyticsInfo(arg2.addedAssetIds, arg2.removedAssetIds)

                arg1:setState({ loading = false, addedAssetNames = arg2.addedNames, removedAssetNames = arg2.removedNames })
            end, function(_)
                if arg1.mounted then
                    arg1:setState({ loading = false })
                end
            end)
        end)()
    end

    function arg1.onRetryLoading()
        arg1:setState({ loading = true })

        if arg1.props.humanoidDescription then
            arg1.loadAssetNames()
            return
        end
        arg1.props.retryLoadDescription()
    end
end

function var1.createEntriesList(arg1)
    local entriesList = {}

    if #arg1.state.addedAssetNames > 0 then
        local headerText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.Adding")
        table.insert(
            entriesList,
            Roact.createElement(RoactGamepad.Focusable[ListSection], {
                headerText = headerText,
                items = arg1.state.addedAssetNames,
                layoutOrder = 1,
                isFirstSection = true,
                isLastSection = #arg1.state.removedAssetNames == 0,
                NextSelectionDown = arg1.removedSectionRef,
                [Roact.Ref] = arg1.addedSectionRef
            })
        )

        if #arg1.state.removedAssetNames > 0 then
            table.insert(
                entriesList,
                Roact.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 2 })
            )
        end
    end

    if #arg1.state.removedAssetNames > 0 then
        local headerText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.Removing")
        table.insert(
            entriesList,
            Roact.createElement(RoactGamepad.Focusable[ListSection], {
                headerText = headerText,
                items = arg1.state.removedAssetNames,
                layoutOrder = 3,
                isFirstSection = #arg1.state.addedAssetNames == 0,
                isLastSection = true,
                NextSelectionUp = arg1.addedSectionRef,
                [Roact.Ref] = arg1.removedSectionRef
            })
        )
    end

    if #arg1.state.addedAssetNames == 0 and #arg1.state.removedAssetNames == 0 then
        local headerText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.NoChangedAssets")
        table.insert(
            entriesList,
            Roact.createElement(RoactGamepad.Focusable[ListSection], {
                headerText = headerText,
                items = {},
                layoutOrder = 1,
                isFirstSection = true,
                isLastSection = true,
                [Roact.Ref] = arg1.noChangedAssetsRef
            })
        )
    end

    return entriesList
end

function var1.renderItemsList(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        local var2 = arg1:createEntriesList()
        var2.Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            [Roact.Change.AbsoluteContentSize] = arg1.onContentSizeChanged
        })

        return Roact.createElement(RoactGamepad.Focusable.Frame, {
            defaultChild = arg1.addedSectionRef,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            [Roact.Ref] = arg1.frameRef
        }, {
            TopGradient = Roact.createElement("Frame", {
                Visible = arg1.topGradientVisibleBinding,
                Size = UDim2.new(1, 0, 0, 30),
                Position = UDim2.fromScale(0, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                ZIndex = 2
            }, {
                UIGradient = Roact.createElement("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.BackgroundUIDefault.Color), ColorSequenceKeypoint.new(1, theme.BackgroundUIDefault.Color) }),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
                })
            }),
            ScrollView = Roact.createElement(
                VerticalScrollViewWithMargin,
                {
                    size = UDim2.fromScale(1, 1),
                    canvasSizeY = UDim.new(0, arg1.state.canvasSizeY)
                },
                var2
            ),
            BottomGradient = Roact.createElement("Frame", {
                Visible = arg1.bottomGradientVisibleBinding,
                Size = UDim2.new(1, 0, 0, 30),
                Position = UDim2.fromScale(0, 1),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                ZIndex = 2
            }, {
                UIGradient = Roact.createElement("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.BackgroundUIDefault.Color), ColorSequenceKeypoint.new(1, theme.BackgroundUIDefault.Color) }),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
                })
            })
        })
    end)
end

function var1.renderLoading(_)
    return Roact.createElement(
        Skeleton,
        {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
end

function var1.renderFailed(arg1)
    return Roact.createElement(EmptyState, {
        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.ItemsListLoadingFailed"),
        size = UDim2.fromScale(1, 1),
        onActivated = arg1.onRetryLoading
    })
end

function var1.render(arg1)
    if arg1.state.loading and not arg1.props.loadingFailed then
        return arg1:renderLoading()
    elseif arg1.state.addedAssetNames then
        return arg1:renderItemsList()
    end
    return arg1:renderFailed()
end

function var1.didMount(arg1)
    arg1.mounted = true

    if arg1.props.humanoidDescription then
        arg1.loadAssetNames()
    end
    arg1.checkIsScrollable()
end

function var1.didUpdate(arg1, arg2, _)
    arg1.checkIsScrollable()

    if arg2.humanoidDescription == arg1.props.humanoidDescription then
        return
    end

    arg1:setState({ loading = true, addedAssetNames = Roact.None, removedAssetNames = Roact.None })

    arg1.loadAssetNames()
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        addAnalyticsInfo = function(arg2)
            return arg1(AddAnalyticsInfo(arg2))
        end
    }
end)(var1)
